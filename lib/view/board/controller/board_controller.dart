import 'package:audioplayers/audioplayers.dart';
import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/core/const_data/app_strings.dart';
import 'package:chess_league/model/chess_piece.dart';
import 'package:chess_league/view/board/util/calculate_valid_moves.dart';
import 'package:chess_league/view/board/widgets/get_piece_image.dart';
import 'package:chess_league/view/board/widgets/initialize_board.dart';
import 'package:chess_league/view/computer/controller/computer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Color? squareColor;
  bool isPromotionInProgress = false;

  ChessPiece? selectedPiece;
  bool isVsComputer = true; // New flag to enable computer mode

  List<List<ChessPiece?>> board = InitializeBoard().initializeBoard;
  List<List<int>> validMoves = [];

  int selectedRow = -1;
  int selectedCol = -1;
  List<ChessPiece> whitePiecesTaken = [];
  List<ChessPiece> blackPiecesTaken = [];
  bool isWhiteTurn = true;
  List<int> whiteKingPosition = [7, 4]; // Starting position for white king
  List<int> blackKingPosition = [0, 4]; // Starting position for black king
  bool checkStatus = false;

  @override
  void onInit() {
    super.onInit();
    InitializeBoard().initializeBoard;
  }

  // Method to play a sound based on action
  Future<void> playSound(String fileName) async {
    await _audioPlayer.stop(); // Stop any currently playing sound

    await _audioPlayer.play(AssetSource(fileName));
  }

  getSquareColor(int index) {
    final isWhiteSquare = (index ~/ 8 + index % 8) % 2 == 0;
    return isWhiteSquare
        ? ColorsManager.foregroundColor
        : ColorsManager.backgroundColor;
  }

  updateState() {
    update();
  }

  bool selectedPieceColor(ChessPiece? selectedPiece) {
    return selectedPiece?.pieceColor == Colors.white;
  }

  bool isWhite(int index) {
    int row = index ~/ 8;
    int col = index % 8;
    return ((row + col) % 2) == 0;
  }

  bool isInBoard(int row, int col) {
    return row >= 0 && row < 8 && col >= 0 && col < 8;
  }

  ChessPiece? getChessPiece(int index) {
    int row = index ~/ 8;
    int col = index % 8;
    return board[row][col];
  }

  bool isKingInCheck(bool isWhiteKing) {
    List<int> kingPosition =
        isWhiteKing ? whiteKingPosition : blackKingPosition;

    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (board[i][j] == null ||
            selectedPieceColor(board[i][j]) == isWhiteKing) {
          continue;
        }

        List<List<int>> pieceValidMoves = calculateRealValidMoves(
          i,
          j,
          board[i][j],
          board,
          false,
        );

        if (pieceValidMoves.any((move) =>
            move[0] == kingPosition[0] && move[1] == kingPosition[1])) {
          return true;
        }
      }
    }

    return false;
  }

  bool isCheckMate(bool isWhiteKing) {
    // If the king is not in check, it's not checkmate
    if (!isKingInCheck(isWhiteKing)) {
      return false;
    }

    // Check if the current player's king has any valid moves
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (board[i][j] != null &&
            selectedPieceColor(board[i][j]) == isWhiteKing) {
          List<List<int>> pieceValidMoves =
              calculateRealValidMoves(i, j, board[i][j], board, true);
          if (pieceValidMoves.isNotEmpty) {
            return false;
          }
        }
      }
    }

    // If no valid moves, it's checkmate
    return true;
  }

  void resetGame() {
    board = InitializeBoard().initializeBoard;
    checkStatus = false;
    whitePiecesTaken.clear();
    blackPiecesTaken.clear();
    whiteKingPosition = [7, 4];
    blackKingPosition = [0, 4];
    isWhiteTurn = true;
    selectedPiece = null;
    selectedRow = -1;
    selectedCol = -1;
    validMoves.clear();
    update();
  }

  bool isKingInCheckSquare(int row, int col) {
    // Check if the current player's king is in check
    if (checkStatus) {
      // Highlight the correct king based on the turn (isWhiteTurn)
      if (isWhiteTurn) {
        return whiteKingPosition[0] == row && whiteKingPosition[1] == col;
      } else {
        return blackKingPosition[0] == row && blackKingPosition[1] == col;
      }
    }
    return false;
  }

  void promotePawn(ChessPiece pawn, PieceType newType, int row, int col,
      int originalRow, int originalCol) {
    // If it's black's turn, automatically promote the pawn to a queen
    if (!selectedPieceColor(pawn)) {
      newType = PieceType.queen; // Automatically promote black pawn to queen
    }

    // Replace the pawn with the selected piece at the new position
    board[row][col] = ChessPiece(
      isSelected: false,
      type: newType,
      pieceColor: pawn.pieceColor,
      image: getImageForPiece(newType, selectedPieceColor(pawn)),
    );

    // Clear the original pawn position
    board[originalRow][originalCol] = null;

    // Clear promotion status
    isPromotionInProgress = false;

    // Play promotion sound
    playSound(AppStrings.promoteSound);

    // Update the board UI
    update();

    // Switch turn *after* promotion and sound play
    if (!isPromotionInProgress) {
      isWhiteTurn = !isWhiteTurn; // Switch turn after promotion
    }

    // Trigger computer's move if it's now the computer's turn
    if (isVsComputer && !isWhiteTurn) {
      Get.find<ComputerController>().makeRandomMove();
      //isWhiteTurn = !isWhiteTurn; // Correct turn after computer move
    }
  }
}

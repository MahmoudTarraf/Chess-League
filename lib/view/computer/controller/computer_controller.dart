import 'dart:math';
import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/model/available_games.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:chess_league/view/board/util/calculate_valid_moves.dart';
import 'package:chess_league/view/board/util/move_piece.dart';
import 'package:get/get.dart';
import '../../../model/chess_piece.dart';

class ComputerController extends GetxController {
  BoardController boardController = Get.find<BoardController>();
  String difficultyLevel = 'Easy';
  String playerKingOption = '';
  AvailableGame finalSelectedGame =
      AvailableGame(timeControl: '', gameName: '');
  final Random _random = Random();

  // Get value of each piece type (could be used in advanced AI logic)
  int getPieceValue(ChessPiece piece) {
    switch (piece.type) {
      case PieceType.pawn:
        return 1;
      case PieceType.knight:
      case PieceType.bishop:
        return 3;
      case PieceType.rook:
        return 5;
      case PieceType.queen:
        return 9;
      default:
        return 0;
    }
  }

  // Randomly choose and move any piece
  void makeRandomMove() {
    List<List<int>> validMoves;
    ChessPiece? selectedPiece;
    int selectedRow = -1;
    int selectedCol = -1;

    // Try finding a valid random move
    for (int attempt = 0; attempt < 100; attempt++) {
      int row = _random.nextInt(8);
      int col = _random.nextInt(8);
      selectedPiece = boardController.board[row][col];

      // Continue if no piece or piece color does not match computer's turn
      if (selectedPiece == null ||
          boardController.selectedPieceColor(selectedPiece) !=
              boardController.isWhiteTurn) {
        continue;
      }

      // Calculate valid moves for the selected piece
      validMoves = calculateRealValidMoves(
          row, col, selectedPiece, boardController.board, true);

      if (validMoves.isNotEmpty) {
        // Choose a random valid move from the list
        List<int> move = validMoves[_random.nextInt(validMoves.length)];
        selectedRow = row;
        selectedCol = col;

        // Execute the move
        boardController.selectedPiece = selectedPiece;
        boardController.selectedRow = selectedRow;
        boardController.selectedCol = selectedCol;
        movePiece(move[0], move[1]);

        break;
      }
    }
  }

  // Update color selection for games
  void updateColor(AvailableGame gameItem) {
    for (AvailableGame item in games) {
      item.gameBackColor = ColorsManager.backgroundColor;
    }
    gameItem.gameBackColor = ColorsManager.lightThemeColor;
    finalSelectedGame = gameItem;
    update();
  }

  // Update king color selection
  void updatePlayerKingColor(AvailableGame king) {
    for (AvailableGame item in kings) {
      item.gameBackColor = ColorsManager.white;
    }
    king.gameBackColor = ColorsManager.lightThemeColor;
    playerKingOption = king.gameName;
    update();
  }

  // Update difficulty level
  void updateDifficulty(String diff) {
    difficultyLevel = diff;
    update();
  }
}

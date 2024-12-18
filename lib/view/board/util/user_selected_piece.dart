import 'package:chess_league/model/chess_piece.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:chess_league/view/board/util/move_piece.dart';
import 'package:chess_league/view/board/util/calculate_valid_moves.dart';
import 'package:get/get.dart';

void userSelectedPiece(int row, int col) {
  final boardController = Get.find<BoardController>();

  // Prevent interaction during promotion
  if (boardController.isPromotionInProgress) {
    print("Cannot select a piece during promotion.");
    return;
  }

  // Prevent interaction if it's not the player's turn
  if (!boardController.isWhiteTurn ||
      boardController.isWaitingForOpponentMove) {
    print("It's not your turn. Waiting for the opponent's move.");
    return;
  }

  ChessPiece? pieceAtPosition = boardController.board[row][col];

  // Handle piece selection
  if (boardController.selectedPiece == null && pieceAtPosition != null) {
    if (boardController.selectedPieceColor(pieceAtPosition) ==
        boardController.isWhiteTurn) {
      selectPiece(row, col);
    }
  } else if (pieceAtPosition != null &&
      boardController.selectedPieceColor(pieceAtPosition) ==
          boardController.selectedPieceColor(boardController.selectedPiece)) {
    selectPiece(row, col);
  } else if (boardController.selectedPiece != null &&
      boardController.validMoves
          .any((move) => move[0] == row && move[1] == col)) {
    movePiece(row, col);
  } else {
    deselectPiece();
  }

  boardController.updateState();
}

void selectPiece(int row, int col) {
  final boardController = Get.find<BoardController>();

  boardController.selectedPiece = boardController.board[row][col];
  boardController.selectedRow = row;
  boardController.selectedCol = col;
  boardController.validMoves = calculateRealValidMoves(
    boardController.selectedRow,
    boardController.selectedCol,
    boardController.selectedPiece,
    boardController.board,
    true,
  );

  print(
      "Selected ${boardController.selectedPiece?.type} at ($row, $col). Valid moves: ${boardController.validMoves}");
}

void deselectPiece() {
  final boardController = Get.find<BoardController>();

  boardController.selectedPiece = null;
  boardController.selectedRow = -1;
  boardController.selectedCol = -1;
  boardController.validMoves = [];

  print("Piece deselected.");
}

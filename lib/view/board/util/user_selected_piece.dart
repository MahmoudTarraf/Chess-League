import 'package:chess_league/core/service/messages.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:chess_league/view/board/util/move_piece.dart';
import 'package:chess_league/view/board/util/calculate_valid_moves.dart';
import 'package:get/get.dart';

void userSelectedPiece(int row, int col) {
  final boardController = Get.find<BoardController>();

  // Exit if promotion is in progress
  if (boardController.isPromotionInProgress) {
    return;
  }

  // Handle piece selection
  if (boardController.selectedPiece == null &&
      boardController.board[row][col] != null) {
    // Check if it's the player's turn
    if (boardController.selectedPieceColor(boardController.board[row][col]) ==
        boardController.isWhiteTurn) {
      selectPiece(row, col);
    }
  } else if (boardController.board[row][col] != null &&
      boardController.selectedPieceColor(boardController.board[row][col]) ==
          boardController.selectedPieceColor(boardController.selectedPiece)) {
    selectPiece(row, col);
  } else if (boardController.selectedPiece != null &&
      boardController.validMoves
          .any((move) => move[0] == row && move[1] == col)) {
    // Check for checkmate before moving the piece
    if (boardController.isCheckMate(!boardController.isWhiteTurn)) {
      // Display the checkmate dialog and stop the game
      Messages.showCheckmateDialog(
          !boardController.isWhiteTurn, boardController.resetGame);
      return; // Don't proceed with the move
    }

    // Proceed with the move if it's not checkmate
    if (boardController.isCheckMate(!boardController.isWhiteTurn)) {
      Messages.showCheckmateDialog(
          !boardController.isWhiteTurn, boardController.resetGame);
    }
    movePiece(row, col);

    // Check if it's checkmate after the move (to avoid user moving in check)
  } else {
    deselectPiece();
  }

  boardController.updateState();
}

// Helper method to select a piece
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
}

// Helper method to deselect a piece
void deselectPiece() {
  final boardController = Get.find<BoardController>();

  boardController.selectedPiece = null;
  boardController.selectedRow = -1;
  boardController.selectedCol = -1;
  boardController.validMoves = [];
}

import 'package:chess_league/core/const_data/app_strings.dart';
import 'package:chess_league/model/chess_piece.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:chess_league/view/board/util/user_selected_piece.dart';
import 'package:chess_league/view/board/widgets/promotion.dart';
import 'package:chess_league/view/computer/controller/computer_controller.dart';
import 'package:get/get.dart';

void movePiece(int newRow, int newCol) {
  final boardController = Get.find<BoardController>();

  if (boardController.selectedPiece == null) return;

  // Handle pawn movement and capture
  if (boardController.selectedPiece!.type == PieceType.pawn) {
    int direction =
        boardController.selectedPieceColor(boardController.selectedPiece)
            ? -1
            : 1;

    // Handle en passant capture
    if ((newCol != boardController.selectedCol) &&
        boardController.board[newRow][newCol] == null) {
      int capturedPawnRow = newRow - direction;
      ChessPiece? capturedPiece =
          boardController.board[capturedPawnRow][newCol];
      boardController.board[capturedPawnRow][newCol] = null;
      if (capturedPiece != null) {
        boardController.playSound(AppStrings.captureSound); // Capture sound
        if (boardController.selectedPieceColor(capturedPiece)) {
          boardController.whitePiecesTaken.add(capturedPiece);
        } else {
          boardController.blackPiecesTaken.add(capturedPiece);
        }
      }
    }

    // Handle promotion
    if ((boardController.selectedPieceColor(boardController.selectedPiece) &&
            newRow == 0) ||
        (!boardController.selectedPieceColor(boardController.selectedPiece) &&
            newRow == 7)) {
      boardController.isPromotionInProgress = true;
      PromotionDialog.showPromotionDialog(
        boardController.selectedPiece!,
        newRow,
        newCol,
        boardController.selectedRow,
        boardController.selectedCol,
      );
      return; // Wait for promotion to complete
    }
  }

  // Handle normal piece capture
  if (boardController.board[newRow][newCol] != null) {
    ChessPiece? capturedPiece = boardController.board[newRow][newCol];
    if (capturedPiece != null) {
      boardController.playSound(AppStrings.captureSound); // Capture sound
      if (boardController.selectedPieceColor(capturedPiece)) {
        boardController.whitePiecesTaken.add(capturedPiece);
      } else {
        boardController.blackPiecesTaken.add(capturedPiece);
      }
    }
  } else {
    boardController.playSound(AppStrings.moveSound); // Move sound
  }

  // Move the selected piece
  boardController.board[newRow][newCol] = boardController.selectedPiece;
  boardController.board[boardController.selectedRow]
      [boardController.selectedCol] = null;

  // Update king positions
  if (boardController.selectedPiece!.type == PieceType.king) {
    if (boardController.selectedPieceColor(boardController.selectedPiece)) {
      boardController.whiteKingPosition = [newRow, newCol];
    } else {
      boardController.blackKingPosition = [newRow, newCol];
    }
  }

  // Check if the king is in check and play the check sound
  boardController.checkStatus =
      boardController.isKingInCheck(!boardController.isWhiteTurn);
  if (boardController.checkStatus) {
    boardController.playSound(AppStrings.checkSound); // Check sound
  }

  // Deselect the piece and update the state
  deselectPiece();

  // Switch turns only if it's not a promotion
  if (!boardController.isPromotionInProgress) {
    // Switch turns
    boardController.isWhiteTurn = !boardController.isWhiteTurn;

    // If it's the computer's turn, let it make a move
    if (boardController.isVsComputer && !boardController.isWhiteTurn) {
      // Make computer move
      Get.find<ComputerController>().makeRandomMove();
    }
  }

  boardController.updateState();
}

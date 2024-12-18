import 'dart:convert';
import 'package:chess_league/core/const_data/app_strings.dart';
import 'package:chess_league/model/chess_piece.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:chess_league/view/board/util/user_selected_piece.dart';
import 'package:chess_league/view/board/widgets/promotion.dart';
import 'package:chess_league/view/opponent/controller/opponent_controller.dart';
import 'package:get/get.dart';

final myChannel = Get.find<OpponentController>().channel;

void movePiece(int newRow, int newCol) {
  final boardController = Get.find<BoardController>();

  // Prevent moves if it's the opponent's turn
  if (boardController.isVsOpponent && !boardController.isWhiteTurn) {
    print('is hereeeeeeeee');
    print("Waiting for opponent's move.");
    return;
  }

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
        boardController.playSound(AppStrings.captureSound);
        (boardController.selectedPieceColor(capturedPiece)
                ? boardController.whitePiecesTaken
                : boardController.blackPiecesTaken)
            .add(capturedPiece);
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
      return;
    }
  }

  // Handle normal piece capture
  ChessPiece? capturedPiece = boardController.board[newRow][newCol];
  if (capturedPiece != null) {
    boardController.playSound(AppStrings.captureSound);
    (boardController.selectedPieceColor(capturedPiece)
            ? boardController.whitePiecesTaken
            : boardController.blackPiecesTaken)
        .add(capturedPiece);
  } else {
    boardController.playSound(AppStrings.moveSound);
  }

  // Move the selected piece
  boardController.board[newRow][newCol] = boardController.selectedPiece;
  boardController.board[boardController.selectedRow]
      [boardController.selectedCol] = null;

  // Update king positions
  if (boardController.selectedPiece!.type == PieceType.king) {
    (boardController.selectedPieceColor(boardController.selectedPiece)
            ? boardController.whiteKingPosition
            : boardController.blackKingPosition)
        .setAll(0, [newRow, newCol]);
  }

  // Check for check and play sound
  boardController.checkStatus =
      boardController.isKingInCheck(!boardController.isWhiteTurn);
  if (boardController.checkStatus) {
    boardController.playSound(AppStrings.checkSound);
  }

  // Send move data
  Map<String, dynamic> moveData = {
    "action": "move",
    "move": {
      "from": [boardController.selectedRow, boardController.selectedCol],
      "to": [newRow, newCol],
      "piece": boardController.selectedPiece?.type.toString(),
      "player": boardController.isWhiteTurn ? "White" : "Black",
    }
  };

  String moveDataJson = jsonEncode(moveData);
  myChannel.sink.add(moveDataJson);

  // Switch turn only if no promotion is in progress
  if (!boardController.isPromotionInProgress) {
    boardController.isWhiteTurn = !boardController.isWhiteTurn;
  }

  // Deselect piece and update state
  deselectPiece();
  boardController.updateState();
}

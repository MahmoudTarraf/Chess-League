//calculate all valid moves
import 'package:chess_league/model/chess_piece.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<List<int>> calculateRawValidMoves(
    int row, int col, ChessPiece? thisPiece, List<List<ChessPiece?>> board) {
  final BoardController boardController = Get.find<BoardController>();
  List<List<int>> candidateMoves = [];

  if (thisPiece == null) {
    return [];
  }

  // different direction based on the color of the player
  int direction = thisPiece.pieceColor == Colors.white ? -1 : 1;
  switch (thisPiece.type) {
    case PieceType.pawn:
      //pawns can move one square forward
      if (boardController.isInBoard(row + direction, col) &&
          board[row + direction][col] == null) {
        candidateMoves.add([row + direction, col]);
      }
      //pawns can move 2 squares if they are at the initial places
      if ((row == 1 && !boardController.selectedPieceColor(thisPiece)) ||
          (row == 6 && boardController.selectedPieceColor(thisPiece))) {
        if (boardController.isInBoard(row + 2 * direction, col) &&
            board[row + 2 * direction][col] == null &&
            board[row + direction][col] == null) {
          candidateMoves.add([row + 2 * direction, col]);
        }
      }
      //pawns can attack diagnolly
      if (boardController.isInBoard(row + direction, col - 1) &&
          board[row + direction][col - 1] != null &&
          boardController.selectedPieceColor(board[row + direction][col - 1]) !=
              boardController.selectedPieceColor(thisPiece)) {
        candidateMoves.add([row + direction, col - 1]);
      }
      if (boardController.isInBoard(row + direction, col + 1) &&
          board[row + direction][col + 1] != null &&
          boardController.selectedPieceColor(board[row + direction][col + 1]) !=
              boardController.selectedPieceColor(thisPiece)) {
        candidateMoves.add([row + direction, col + 1]);
      }
      // En passant check
      if (row == 3 || row == 4) {
        // White pawn on row 4 or black pawn on row 5
        // Check left and right columns for en passant opportunities
        if (boardController.isInBoard(row, col - 1) &&
            board[row][col - 1] != null &&
            board[row][col - 1]!.type == PieceType.pawn &&
            boardController.selectedPieceColor(board[row][col - 1]) !=
                boardController.selectedPieceColor(thisPiece) &&
            board[row + direction][col - 1] == null) {
          candidateMoves.add([row + direction, col - 1]); // En passant left
        }
        if (boardController.isInBoard(row, col + 1) &&
            board[row][col + 1] != null &&
            board[row][col + 1]!.type == PieceType.pawn &&
            boardController.selectedPieceColor(board[row][col + 1]) !=
                boardController.selectedPieceColor(thisPiece) &&
            board[row + direction][col + 1] == null) {
          candidateMoves.add([row + direction, col + 1]); // En passant right
        }
      }
      //write method enpasent for pawns on the row 4 and row 5 and the other pawn i played 2 squares forward on the first play
      break;
    case PieceType.rook:
      //the rook move horizontally
      // the rook moves vertically
      // [ 0,1,2,3,4]
      List<List<int>> rookMoves = [
        [-1, 0], //up
        [1, 0], //down
        [0, -1], //left
        [0, 1], //right
      ];
      for (var direction in rookMoves) {
        var i = 1;
        while (true) {
          var newRow = row + i * direction[0];
          var newCol = col + i * direction[1];
          if (!boardController.isInBoard(newRow, newCol)) {
            break;
          }
          if (board[newRow][newCol] != null) {
            if (boardController.selectedPieceColor(board[newRow][newCol]) !=
                boardController.selectedPieceColor(thisPiece)) {
              candidateMoves.add([newRow, newCol]);
            }
            break;
          }
          candidateMoves.add([newRow, newCol]);
          i += 1;
        }
      }
      break;
    case PieceType.knight:
      var knightMoves = [
        [-2, -1], //up 2 and left 1 ...
        [-2, 1],
        [-1, -2],
        [-1, 2],
        [1, -2],
        [1, 2],
        [2, -1],
        [2, 1],
      ];
      for (var move in knightMoves) {
        var newRow = row + move[0];
        var newCol = col + move[1];
        if (!boardController.isInBoard(newRow, newCol)) {
          continue;
        }
        if (board[newRow][newCol] != null) {
          if (boardController.selectedPieceColor(board[newRow][newCol]) !=
              boardController.selectedPieceColor(thisPiece)) {
            candidateMoves.add([newRow, newCol]);
          }
          continue;
        }
        candidateMoves.add([newRow, newCol]);
      }
      break;
    case PieceType.bishop:
      var bishopMoves = [
        [-1, -1],
        [-1, 1],
        [1, 1],
        [1, -1],
      ];
      for (var bmove in bishopMoves) {
        var i = 1;
        while (true) {
          var newRow = row + i * bmove[0];
          var newCol = col + i * bmove[1];
          if (!boardController.isInBoard(newRow, newCol)) {
            break;
          }
          if (board[newRow][newCol] != null) {
            if (boardController.selectedPieceColor(board[newRow][newCol]) !=
                boardController.selectedPieceColor(thisPiece)) {
              candidateMoves.add([newRow, newCol]);
            }
            break;
          }
          candidateMoves.add([newRow, newCol]);
          i += 1;
        }
      }
      break;
    case PieceType.king:
      var kingMoves = [
        [-1, 0],
        [1, 0],
        [0, 1],
        [0, -1],
        [1, -1],
        [1, 1],
        [-1, -1],
        [-1, 1]
      ];
      for (var kmove in kingMoves) {
        var newRow = row + kmove[0];
        var newCol = col + kmove[1];
        if (!boardController.isInBoard(newRow, newCol)) {
          continue;
        }
        if (board[newRow][newCol] != null) {
          if (boardController.selectedPieceColor(board[newRow][newCol]) !=
              boardController.selectedPieceColor(thisPiece)) {
            candidateMoves.add([newRow, newCol]);
          }
          continue;
        }

        candidateMoves.add([newRow, newCol]);
      }
      break;
    case PieceType.queen:
      var queenMoves = [
        [-1, 0],
        [1, 0],
        [0, 1],
        [0, -1],
        [1, -1],
        [1, 1],
        [-1, -1],
        [-1, 1],
      ];
      for (var qmoves in queenMoves) {
        var i = 1;
        while (true) {
          var newRow = row + i * qmoves[0];
          var newCol = col + i * qmoves[1];
          if (!boardController.isInBoard(newRow, newCol)) {
            break;
          }
          if (board[newRow][newCol] != null) {
            if (boardController.selectedPieceColor(board[newRow][newCol]) !=
                boardController.selectedPieceColor(thisPiece)) {
              candidateMoves.add([newRow, newCol]);
            }
            break;
          }
          candidateMoves.add([newRow, newCol]);
          i += 1;
        }
      }
      break;
  }

  return candidateMoves;
}

List<List<int>> calculateRealValidMoves(
  int row,
  int col,
  ChessPiece? thisSelectedPiece,
  List<List<ChessPiece?>> board,
  bool checkSimulation,
) {
  List<List<int>> realValidMoves = [];
  List<List<int>> candidateMoves =
      calculateRawValidMoves(row, col, thisSelectedPiece, board);
  if (checkSimulation) {
    for (var move in candidateMoves) {
      int endRow = move[0];
      int endCol = move[1];
      if (simulatedMoveIsSafe(
        board: board,
        endCol: endCol,
        endRow: endRow,
        piece: thisSelectedPiece,
        startCol: col,
        startRow: row,
      )) {
        realValidMoves.add(move);
      }
    }
  } else {
    realValidMoves = candidateMoves;
  }

  return realValidMoves;
}
//see if the move is safe (doesnt put king under attack)

bool simulatedMoveIsSafe({
  required ChessPiece? piece,
  required int startRow,
  required int startCol,
  required int endRow,
  required int endCol,
  required List<List<ChessPiece?>> board,
}) {
  final BoardController boardController = Get.find<BoardController>();

  ChessPiece? originalDestinationPiece = board[endRow][endCol];
  List<int>? originalKingPosition;

  // If the piece is the king, temporarily update its position
  if (piece!.type == PieceType.king) {
    originalKingPosition = boardController.selectedPieceColor(piece)
        ? boardController.whiteKingPosition
        : boardController.blackKingPosition;

    if (boardController.selectedPieceColor(piece)) {
      boardController.whiteKingPosition = [endRow, endCol];
    } else {
      boardController.blackKingPosition = [endRow, endCol];
    }
  }

  // Simulate the move
  board[endRow][endCol] = piece;
  board[startRow][startCol] = null;

  // Check if the move puts the king in check
  bool kingInCheck = boardController.isKingInCheck(
    boardController.selectedPieceColor(piece),
  );

  // Restore the original state
  board[startRow][startCol] = piece;
  board[endRow][endCol] = originalDestinationPiece;

  if (piece.type == PieceType.king) {
    if (boardController.selectedPieceColor(piece)) {
      boardController.whiteKingPosition = originalKingPosition!;
    } else {
      boardController.blackKingPosition = originalKingPosition!;
    }
  }

  return !kingInCheck;
}

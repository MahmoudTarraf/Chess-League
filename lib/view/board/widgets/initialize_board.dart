import 'package:chess_league/core/const_data/app_images.dart';
import 'package:chess_league/model/chess_piece.dart';
import 'package:flutter/material.dart';

class InitializeBoard {
  List<List<ChessPiece?>> get initializeBoard => _initializeBoard();
  List<List<ChessPiece?>> _initializeBoard() {
    List<List<ChessPiece?>> newBoard = List.generate(
      8,
      (index) => List.generate(
        8,
        (index) => null,
      ),
    );

    //create the pawns
    for (int i = 0; i < 8; i++) {
      newBoard[1][i] = ChessPiece(
        type: PieceType.pawn,
        image: AppImages.blackPawn,
        pieceColor: Colors.black,
        isSelected: false,
      );
    }
    for (int j = 0; j < 8; j++) {
      newBoard[6][j] = ChessPiece(
        type: PieceType.pawn,
        image: AppImages.whitePawn,
        pieceColor: Colors.white,
        isSelected: false,
      );
    }

    newBoard[0][2] = ChessPiece(
      type: PieceType.bishop,
      image: AppImages.blackBishop,
      isSelected: false,
      pieceColor: Colors.black,
    );
    newBoard[0][5] = ChessPiece(
      type: PieceType.bishop,
      image: AppImages.blackBishop,
      pieceColor: Colors.black,
      isSelected: false,
    );
    newBoard[7][2] = ChessPiece(
      type: PieceType.bishop,
      image: AppImages.whiteBishop,
      pieceColor: Colors.white,
      isSelected: false,
    );
    newBoard[7][5] = ChessPiece(
      type: PieceType.bishop,
      image: AppImages.whiteBishop,
      pieceColor: Colors.white,
      isSelected: false,
    );
    //create knights
    newBoard[0][1] = ChessPiece(
      type: PieceType.knight,
      image: AppImages.blackKnight,
      pieceColor: Colors.black,
      isSelected: false,
    );
    newBoard[0][6] = ChessPiece(
      type: PieceType.knight,
      image: AppImages.blackKnight,
      pieceColor: Colors.black,
      isSelected: false,
    );
    newBoard[7][1] = ChessPiece(
      type: PieceType.knight,
      image: AppImages.whiteKnight,
      isSelected: false,
      pieceColor: Colors.white,
    );
    newBoard[7][6] = ChessPiece(
      type: PieceType.knight,
      image: AppImages.whiteKnight,
      isSelected: false,
      pieceColor: Colors.white,
    );
    //create rooks
    newBoard[0][0] = ChessPiece(
      type: PieceType.rook,
      image: AppImages.blackRook,
      isSelected: false,
      pieceColor: Colors.black,
    );
    newBoard[0][7] = ChessPiece(
      type: PieceType.rook,
      image: AppImages.blackRook,
      isSelected: false,
      pieceColor: Colors.black,
    );
    newBoard[7][0] = ChessPiece(
      type: PieceType.rook,
      image: AppImages.whiteRook,
      isSelected: false,
      pieceColor: Colors.white,
    );
    newBoard[7][7] = ChessPiece(
      type: PieceType.rook,
      image: AppImages.whiteRook,
      isSelected: false,
      pieceColor: Colors.white,
    );
    //create kings
    newBoard[7][4] = ChessPiece(
      type: PieceType.king,
      image: AppImages.whiteKing,
      isSelected: false,
      pieceColor: Colors.white,
    );

    newBoard[0][4] = ChessPiece(
      type: PieceType.king,
      image: AppImages.blackKing,
      isSelected: false,
      pieceColor: Colors.black,
    );
    //create queens
    newBoard[0][3] = ChessPiece(
      type: PieceType.queen,
      image: AppImages.blackQueen,
      isSelected: false,
      pieceColor: Colors.black,
    );
    newBoard[7][3] = ChessPiece(
      type: PieceType.queen,
      image: AppImages.whiteQueen,
      pieceColor: Colors.white,
      isSelected: false,
    );
    return newBoard;
  }
}
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ChessPiece {
  final PieceType type;
  final String image;
  Color pieceColor;
  bool isSelected;
  ChessPiece({
    required this.type,
    required this.image,
    required this.isSelected,
    required this.pieceColor,
  });
  // Copy constructor to create a copy of the ChessPiece
  ChessPiece copy() {
    return ChessPiece(
      type: type,
      pieceColor: pieceColor,
      image: image,
      isSelected: isSelected,
    );
  }
}

enum PieceType {
  king,
  queen,
  pawn,
  knight,
  rook,
  bishop,
}

import 'package:chess_league/model/chess_piece.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:chess_league/view/board/widgets/chess_piece_creator.dart';
import 'package:flutter/material.dart';

class FlipBoardscreen extends StatelessWidget {
  const FlipBoardscreen({super.key, required this.controller});
  final BoardController controller;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemBuilder: (context, index) {
          ChessPiece? piece = controller.getFlippedPiece(index);
          return ChessPieceCreator(
            piece: piece,
            isWhite: controller.isWhite(index),
            isSelected: false,
            isValid: false,
            onTap: () {},
            isInCheck: false,
          );
        },
        itemCount: 8 * 8,
      ),
    );
  }
}

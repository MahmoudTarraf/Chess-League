import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/model/chess_piece.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChessPieceCreator extends StatelessWidget {
  const ChessPieceCreator({
    super.key,
    required this.isWhite,
    required this.piece,
    required this.isSelected,
    required this.isValid,
    required this.isInCheck,
    required this.onTap,
  });

  final bool isWhite;
  final bool isSelected;
  final bool isValid;
  final bool isInCheck;
  final ChessPiece? piece;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: BoardController(),
      builder: (controller) {
        Color? squareColor;

        if (isInCheck) {
          squareColor = Colors.red; // Highlight the king's square in check
        } else if (isSelected) {
          squareColor = Colors.green; // Highlight selected square
        } else if (isValid) {
          squareColor = const Color.fromARGB(255, 127, 212, 131); // Valid moves
        } else {
          squareColor = isWhite
              ? ColorsManager.foregroundColor
              : ColorsManager.backgroundColor; // Default colors
        }

        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.all(isValid ? 2 : 0),
            color: squareColor,
            child: piece == null
                ? const SizedBox()
                : Image.asset(
                    piece!.image,
                  ),
          ),
        );
      },
    );
  }
}

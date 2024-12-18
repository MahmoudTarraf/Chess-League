import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/model/chess_piece.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';

class ChessPieceCreator extends StatelessWidget {
  const ChessPieceCreator({
    super.key,
    required this.isWhite,
    required this.piece,
    required this.isSelected,
    required this.isValid,
    required this.isInCheck,
    required this.onTap,
    required this.row,
    required this.col,
  });

  final bool isWhite;
  final bool isSelected;
  final bool isValid;
  final bool isInCheck;
  final ChessPiece? piece;
  final void Function()? onTap;
  final int row;
  final int col;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: BoardController(),
      builder: (controller) {
        Color? squareColor;

        if (isInCheck) {
          squareColor = Colors.red;
        } else if (isSelected) {
          squareColor = Colors.green;
        } else if (isValid) {
          squareColor = const Color.fromARGB(255, 127, 212, 131);
        } else {
          squareColor = isWhite
              ? ColorsManager.foregroundColor
              : ColorsManager.backgroundColor;
        }

        return GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                color: squareColor,
                child: piece == null
                    ? Container(
                        color: squareColor,
                      )
                    : Image.asset(piece!.image),
              ),
              // Add A-H on the first row
              if (row == 7)
                Positioned(
                  bottom: 1,
                  left: 1,
                  child: Text(
                    String.fromCharCode(65 + col), // A-H
                    style: TextStyle(
                      color: squareColor == Colors.white
                          ? Colors.brown
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              // Add 1-8 on the last column
              if (col == 0)
                Positioned(
                  top: 2,
                  left: 2,
                  child: Text(
                    '${8 - row}', // 1-8
                    style: TextStyle(
                      color: squareColor == Colors.white
                          ? Colors.brown
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

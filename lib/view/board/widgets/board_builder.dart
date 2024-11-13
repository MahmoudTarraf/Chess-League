import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/core/service/messages.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:chess_league/view/board/util/user_selected_piece.dart';
import 'package:chess_league/view/board/widgets/chess_piece_creator.dart';
import 'package:chess_league/view/board/widgets/dead_piece.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardBuilder extends StatelessWidget {
  const BoardBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldExit = await Messages.onWillPop(
          'Leave Game',
          'If you leave, you will lose this match',
        );

        if (shouldExit) {
          // If the user confirmed to leave, reset the game before exiting
          Get.find<BoardController>().resetGame();
        }

        return shouldExit;
      },
      child: Scaffold(
        backgroundColor: ColorsManager.backgroundColor,
        body: GetBuilder(
          init: BoardController(),
          builder: (controller) {
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2),
                        child: DeadPiece(
                          imagePath: controller.whitePiecesTaken[index].image,
                        ),
                      );
                    },
                    itemCount: controller.whitePiecesTaken.length,
                  ),
                ),
                Text(
                  controller.checkStatus ? 'Check!!!' : '',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                Expanded(
                  flex: 3,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                    ),
                    itemBuilder: (context, index) {
                      int row = index ~/ 8;
                      int col = index % 8;
                      //check if the square is selected
                      bool isSelected = controller.selectedRow == row &&
                          controller.selectedCol == col;
                      bool isValidMove = false;
                      for (var position in controller.validMoves) {
                        if (position[0] == row && position[1] == col) {
                          isValidMove = true;
                        }
                      }
                      bool isKingInCheck =
                          controller.isKingInCheckSquare(row, col);
                      return ChessPieceCreator(
                        piece: controller.getChessPiece(index),
                        isWhite: controller.isWhite(index),
                        isSelected: isSelected,
                        isValid: isValidMove,
                        onTap: () => userSelectedPiece(row, col),
                        isInCheck: isKingInCheck,
                      );
                    },
                    itemCount: 8 * 8,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2),
                        child: DeadPiece(
                          imagePath: controller.blackPiecesTaken[index].image,
                        ),
                      );
                    },
                    itemCount: controller.blackPiecesTaken.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

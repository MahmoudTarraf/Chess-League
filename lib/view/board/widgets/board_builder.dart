import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/core/service/messages.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:chess_league/view/flip_board/screen/flip_board_screen.dart';
import 'package:chess_league/view/board/util/player_header.dart';
import 'package:chess_league/view/board/util/user_selected_piece.dart';
import 'package:chess_league/view/board/widgets/chess_piece_creator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
          Get.find<BoardController>().resetGame();
        }

        return shouldExit;
      },
      child: Scaffold(
        backgroundColor: ColorsManager.scaffoldBackColor,
        body: GetBuilder<BoardController>(
          init: BoardController(),
          builder: (controller) {
            return GestureDetector(
              onTap: () {
                if (controller.isHelpMenuVisible) {
                  controller.updateisHelpMenuVisible();
                }
              },
              child: Column(
                children: [
                  Expanded(
                    child: PlayerHeader(
                      takenpieces: controller.whitePiecesTaken,
                      playerName: 'Black Player',
                      playerRating: '1600',
                    ),
                  ),
                  Text(
                    controller.checkStatus ? 'Check!!!' : '',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  controller.isBoardFlipped
                      ? FlipBoardscreen(controller: controller)
                      : Expanded(
                          flex: 2,
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
                              bool isSelected = controller.selectedRow == row &&
                                  controller.selectedCol == col;
                              bool isValidMove = controller.validMoves
                                  .any((pos) => pos[0] == row && pos[1] == col);
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
                    child: PlayerHeader(
                      takenpieces: controller.blackPiecesTaken,
                      playerName: 'White Player',
                      playerRating: '1500',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: GetBuilder(
          init: BoardController(),
          builder: (controller) => Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Main Help Button
              FloatingActionButton(
                backgroundColor: ColorsManager.backgroundColor,
                onPressed: () {
                  Get.find<BoardController>()
                      .updateisHelpMenuVisible(); // Toggle help menu
                },
                child: Icon(
                  Get.find<BoardController>().isHelpMenuVisible
                      ? Icons.close
                      : Icons.help_outline,
                  color: Colors.white,
                ),
              ),

              // Space between the help button and the other buttons
              SizedBox(width: 1.w),

              // Flip Button (only shown when help menu is visible)
              if (Get.find<BoardController>().isHelpMenuVisible)
                FloatingActionButton(
                  backgroundColor: ColorsManager.backgroundColor,
                  onPressed: () {
                    controller.toggleBoardFlip();
                  },
                  child: const Icon(
                    Icons.flip,
                    color: Colors.white,
                  ),
                ),

              // Take Back Button (only shown when help menu is visible)
              SizedBox(width: 1.w),
              if (Get.find<BoardController>().isHelpMenuVisible)
                FloatingActionButton(
                  backgroundColor: ColorsManager.backgroundColor,
                  onPressed: () {},
                  child: const Icon(
                    Icons.undo,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

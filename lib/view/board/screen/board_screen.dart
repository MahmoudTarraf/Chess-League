import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/core/const_data/app_strings.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:chess_league/view/board/widgets/board_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final boardController = Get.find<BoardController>();
    boardController.playSound(AppStrings.gamestartSound);

    return const Scaffold(
      backgroundColor: ColorsManager.black,
      body: BoardBuilder(),
    );
  }
}

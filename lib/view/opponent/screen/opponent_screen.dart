import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/model/available_games.dart';
import 'package:chess_league/utils/waiting_for_player.dart';
import 'package:chess_league/view/auth/user/user_controller.dart';
import 'package:chess_league/view/board/screen/board_screen.dart';
import 'package:chess_league/view/opponent/controller/opponent_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpponentScreen extends StatelessWidget {
  const OpponentScreen({
    super.key,
    required this.game,
  });
  final AvailableGame game;
  @override
  Widget build(BuildContext context) {
    final user = Get.find<UserController>().currentUser!.user;
    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackColor,
      body: GetBuilder(
        init: OpponentController(),
        builder: (controller) {
          controller.setPlayerConfig(user, game);
          controller.connectToWebSocket();
          return controller.gameStarted
              ? const BoardScreen()
              : WaitingForPlayerScreen(game: game);
        },
      ),
    );
  }
}

import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/model/available_games.dart';
import 'package:get/get.dart';

class FriendController extends GetxController {
  String difficultyLevel = 'Easy';
  String playerKingOption = '';
  AvailableGame finalSelectedGame =
      AvailableGame(timeControl: '', gameName: '');
  updateColor(AvailableGame gameItem) {
    for (AvailableGame item in games) {
      item.gameBackColor = ColorsManager.backgroundColor;
    }
    gameItem.gameBackColor = ColorsManager.lightThemeColor;
    finalSelectedGame = gameItem;
    update();
  }

  updatePlayerKingColor(AvailableGame king) {
    for (AvailableGame item in kings) {
      item.gameBackColor = ColorsManager.white;
    }
    king.gameBackColor = ColorsManager.lightThemeColor;
    playerKingOption = king.gameName;
    update();
  }

  updateDifficulty(String diff) {
    difficultyLevel = diff;
    update();
  }
}

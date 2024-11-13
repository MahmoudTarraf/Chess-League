import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:flutter/painting.dart';

class AvailableGame {
  final String timeControl;
  final String gameName;
  Color gameBackColor;

  AvailableGame({
    required this.timeControl,
    required this.gameName,
    this.gameBackColor = ColorsManager.backgroundColor,
  });
}

List<AvailableGame> games = [
  AvailableGame(timeControl: '1 + 0', gameName: 'Bullet'),
  AvailableGame(timeControl: '3 + 0', gameName: 'Blitz'),
  AvailableGame(timeControl: '5 + 0', gameName: 'Blitz'),
  AvailableGame(timeControl: '10 + 0', gameName: 'Rapid'),
  AvailableGame(timeControl: '15 + 0', gameName: 'Rapid'),
  AvailableGame(timeControl: '30 + 0', gameName: 'Classical'),
];
List<AvailableGame> kings = [
  AvailableGame(
      timeControl: '',
      gameName: 'BlackKing',
      gameBackColor: ColorsManager.white),
  AvailableGame(
      timeControl: '',
      gameName: 'WhiteKing',
      gameBackColor: ColorsManager.white),
];

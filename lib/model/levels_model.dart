import 'package:flutter/material.dart';

class LevelsModel {
  final String levelName;
  final IconData iconData;

  LevelsModel({
    required this.levelName,
    required this.iconData,
  });
}

final List<LevelsModel> playerLevel = [
  LevelsModel(
    levelName: 'Noob',
    iconData: Icons.sentiment_dissatisfied,
  ),
  LevelsModel(
    levelName: 'Beginner',
    iconData: Icons.trending_up,
  ),
  LevelsModel(
    levelName: 'Good',
    iconData: Icons.star,
  ),
  LevelsModel(
    levelName: 'Expert',
    iconData: Icons.workspace_premium,
  ),
];

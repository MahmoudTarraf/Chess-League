import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget gridItemCreator(String timeControl, String gameName, Color color) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(20),
    ),
    margin: const EdgeInsets.all(2),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          timeControl,
          style: TextStyle(color: ColorsManager.white, fontSize: 17.sp),
        ),
        Text(
          gameName,
          style: TextStyle(color: ColorsManager.white, fontSize: 17.sp),
        ),
      ],
    ),
  );
}

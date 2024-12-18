import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget titleCreator(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              size: 30,
              color: ColorsManager.white,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          Text(
            'Chess League',
            style: TextStyle(
              color: ColorsManager.white,
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Text(
            'games: ',
            style: TextStyle(
              color: ColorsManager.white,
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '0',
              style: TextStyle(
                color: ColorsManager.white,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

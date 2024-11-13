import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/core/service/messages.dart';
import 'package:chess_league/model/available_games.dart';
import 'package:chess_league/view/board/screen/board_screen.dart';
import 'package:chess_league/view/computer/screen/computer_screen.dart';
import 'package:chess_league/view/home/widgets/grid_item_builder.dart';
import 'package:chess_league/widgets/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Messages.onWillPop(
          'Exit Chess League', 'Are you sure you want to leave?'),
      child: Scaffold(
        backgroundColor: ColorsManager.scaffoldBackColor,
        body: Column(
          children: [
            titleCreator(),
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Play Online',
                style: TextStyle(
                  color: ColorsManager.white,
                  fontSize: 18.sp,
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  final thisItem = games[index];
                  return GestureDetector(
                    onTap: () => Get.to(
                      () => const BoardScreen(),
                    ),
                    child: gridItemCreator(
                      thisItem.timeControl,
                      thisItem.gameName,
                      ColorsManager.backgroundColor,
                    ),
                  );
                },
                itemCount: 6,
              ),
            ),
            CustomElevatedButton(
              width: 90.w,
              onPressed: () {
                Get.to(() => const ComputerScreen());
              },
              height: 7.h,
              backgroundColor: ColorsManager.backgroundColor,
              foregroundColor: ColorsManager.white,
              child: Text(
                'Play With Computer',
                style: TextStyle(fontSize: 17.sp),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            CustomElevatedButton(
              width: 80.w,
              onPressed: () {
                Get.snackbar(
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2),
                  backgroundColor: ColorsManager.primary,
                  'Coming Soon!',
                  'try oter game options',
                );
              },
              height: 7.h,
              backgroundColor: ColorsManager.backgroundColor,
              foregroundColor: ColorsManager.white,
              child: Text(
                'Play With Friend',
                style: TextStyle(fontSize: 17.sp),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Need Help?',
                    style: TextStyle(
                      color: ColorsManager.white,
                      fontSize: 16.sp,
                      decoration: TextDecoration.underline,
                      decorationColor: ColorsManager.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget titleCreator() {
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
            onPressed: () {},
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

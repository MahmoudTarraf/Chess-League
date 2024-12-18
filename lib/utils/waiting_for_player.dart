import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/model/available_games.dart';
import 'package:chess_league/view/opponent/controller/opponent_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class WaitingForPlayerScreen extends StatelessWidget {
  const WaitingForPlayerScreen({
    super.key,
    required this.game,
  });
  final AvailableGame game;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  game.gameName,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  game.timeControl,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            Center(
              child: Text(
                'Waiting for another player',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.black,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Center(
              child: Text(
                'This might take some time...',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            const CircularProgressIndicator(
              color: Colors.lightGreen,
            ),
            SizedBox(height: 20.sp),
            ElevatedButton(
              onPressed: () {
                Get.back();
                Get.find<OpponentController>().onClose();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.black,
                foregroundColor: ColorsManager.white,
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:chess_league/core/class/status_request.dart';
import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/model/levels_model.dart';
import 'package:chess_league/view/auth/player_rating/widgets/level_creator.dart';
import 'package:chess_league/view/auth/signup/controller/signup_controller.dart';
import 'package:chess_league/widgets/appbar/custom_app_bar.dart';
import 'package:chess_league/widgets/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PlayerRatingScreen extends StatelessWidget {
  const PlayerRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: SignupController(),
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              backGroundColor: ColorsManager.white,
              iconData: Icons.arrow_back_ios,
              title: 'Player Rating',
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'How good are you at chess?\n',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            LevelCreator(
              levelList: playerLevel,
            ),
            SizedBox(
              height: 2.h,
            ),
            Center(
              child: CustomElevatedButton(
                width: 90.w,
                onPressed: () {
                  controller.signUp();
                },
                height: 7.h,
                backgroundColor: ColorsManager.black,
                foregroundColor: ColorsManager.white,
                child: controller.statusRequest == StatusRequest.loading
                    ? const CircularProgressIndicator(
                        color: ColorsManager.white,
                      )
                    : Text(
                        "Signup Now!",
                        style: TextStyle(fontSize: 18.sp),
                      ),
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}

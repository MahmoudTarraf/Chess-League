import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/core/const_data/app_images.dart';
import 'package:chess_league/view/auth/splash_screen_folder/controller/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: Center(
        child: GetBuilder(
          init: SplashScreenController(),
          builder: (controller) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.blackKnight,
                fit: BoxFit.cover,
              ), // Chess logo
              SizedBox(height: 20.h),
              Text(
                'Chess League',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.black,
                ),
              ),
              SizedBox(height: 20.sp),
              const CircularProgressIndicator(
                color: ColorsManager.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

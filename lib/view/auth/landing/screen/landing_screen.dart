// ignore_for_file: use_key_in_widget_constructors, camel_case_types

import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/core/const_data/app_images.dart';
import 'package:chess_league/core/service/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:sizer/sizer.dart';

class LandingSCreen extends StatelessWidget {
  final pages = [
    PageViewModel(
      bubbleBackgroundColor: ColorsManager.primary,
      pageColor: ColorsManager.white,
      bubble: SvgPicture.asset(
        AppImages.chessLanding,
      ),
      body: Builder(builder: (context) {
        return Text(
          'Explore a wide range of categories from electronics to fashion. We’ve got everything you need, all in one place.',
          style: TextStyle(
            fontSize: 18.sp,
            color: ColorsManager.black,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        );
      }),
      title: Text(
        'Discover Endless Categories',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 23.sp,
          color: ColorsManager.black,
          fontWeight: FontWeight.w500,
          fontFamily: "play",
        ),
      ),
      mainImage: SvgPicture.asset(
        AppImages.chessLanding,
      ),
    ),
    PageViewModel(
      bubbleBackgroundColor: ColorsManager.primary,
      pageColor: ColorsManager.white,
      bubble: SvgPicture.asset(
        AppImages.chessLanding2,
      ),
      body: Builder(builder: (context) {
        return Text(
          'Enjoy a seamless shopping experience with fast navigation, easy checkout, and personalized recommendations.',
          style: TextStyle(
            fontSize: 18.sp,
            color: ColorsManager.black,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        );
      }),
      title: Text(
        'Effortless Shopping Experience',
        style: TextStyle(
          fontSize: 23.sp,
          color: ColorsManager.black,
          fontWeight: FontWeight.w500,
          fontFamily: "play",
        ),
        textAlign: TextAlign.center,
      ),
      mainImage: SvgPicture.asset(
        AppImages.chessLanding2,
      ),
    ),
    PageViewModel(
      bubbleBackgroundColor: ColorsManager.primary,
      pageColor: ColorsManager.white,
      bubble: SvgPicture.asset(
        AppImages.chessLanding3,
      ),
      body: Builder(builder: (context) {
        return Text(
          'Stay ahead with daily deals, flash sales, and discounts available only for our app users.',
          style: TextStyle(
            fontSize: 18.sp,
            color: ColorsManager.black,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        );
      }),
      title: Text(
        'Exclusive Deals and Offers',
        style: TextStyle(
          fontSize: 23.sp,
          color: ColorsManager.black,
          fontWeight: FontWeight.w500,
          fontFamily: "play",
        ),
        textAlign: TextAlign.center,
      ),
      mainImage: SvgPicture.asset(
        AppImages.chessLanding3,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      backText: const Text(
        "Back",
      ),
      nextText: const Text(
        "Next",
      ),
      skipText: const Text(
        "Skip",
      ),
      doneText: const Text(
        "Done",
      ),
      pages,
      showNextButton: true,
      showBackButton: true,
      onTapDoneButton: () {
        Get.offAndToNamed(Routes.signupScreen);
      },
      pageButtonTextStyles: TextStyle(
        color: ColorsManager.primary,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

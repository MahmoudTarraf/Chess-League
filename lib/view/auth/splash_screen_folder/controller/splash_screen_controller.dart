import 'dart:async';

import 'package:chess_league/core/service/routes.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  void timer() {
    Timer(const Duration(seconds: 3), () {
      Get.offNamed(Routes.landingScreen);
    });
  }

  @override
  void onInit() {
    timer();
    super.onInit();
  }
}

import 'package:chess_league/view/auth/user/user_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  homeFunction() {
    Get.find<UserController>().getuserData();
  }

  @override
  void onInit() {
    homeFunction();
    super.onInit();
  }
}

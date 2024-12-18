// import 'package:chess_league/core/class/crud.dart';
import 'package:chess_league/core/service/network_connection.dart';

import 'package:chess_league/view/auth/user/user_controller.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:chess_league/view/opponent/controller/opponent_controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(BoardController(), permanent: true);
    Get.put(NetworkManager());
    Get.put(UserController(), permanent: true);
    Get.put(OpponentController(), permanent: true);
  }
}

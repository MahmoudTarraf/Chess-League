// import 'package:chess_league/core/class/crud.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(BoardController(), permanent: true);
  }
}

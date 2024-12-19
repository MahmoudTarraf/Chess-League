import 'package:chess_league/model/user_model.dart';
import 'package:chess_league/view/auth/user/user_controller.dart';
import 'package:chess_league/view/board/screen/board_screen.dart';
import 'package:get/get.dart';

void setDetials(Map<String, dynamic> gameData) {
  final player1Info = gameData['player_1'];
  final player2Info = gameData['player_2'];
  print(
    ' ${gameData} ${gameData.runtimeType}',
  );
  /**
   {room_name: room6BlitzuvlYDk, game_type: Blitz, time_limit: 5 + 0,
    player_1: {username: ali, email: ali@gmail.com, rating: 1800, id: 6},
     player_2: {username: Fatima, email: fatimahazem7a@gmail.com, rating: 500, id: 9}, status: active}
   */
  final thisUser = Get.find<UserController>().currentUser!.user;
  if (thisUser.username == player1Info['username']) {
    final temp = UserModel(
      accessToken: '',
      user: User(
        id: player2Info['id'],
        username: player2Info['username'],
        email: player2Info['email'],
        image: 'image',
        rating: player2Info['rating'],
      ),
    );
    Get.find<UserController>().setOpponentModel(temp);
  } else {
    final temp = UserModel(
      accessToken: '',
      user: User(
        id: player1Info['id'],
        username: player1Info['username'],
        email: player1Info['email'],
        image: 'image',
        rating: player1Info['rating'],
      ),
    );
    Get.find<UserController>().setOpponentModel(temp);
  }

  Get.off(() => const BoardScreen());
}

import 'dart:convert';

import 'package:chess_league/core/const_data/const_data.dart';
import 'package:chess_league/model/available_games.dart';
import 'package:chess_league/view/auth/user/user_controller.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:chess_league/core/const_data/app_link.dart';

Future<String> fetchRoomNameAndAssignColor(
    {required AvailableGame thisGame}) async {
  try {
    final url = Uri.parse(AppLink.roomName);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ConstData.accessToken}',
      },
      body: jsonEncode({
        'game_type': thisGame.gameName,
        'time_limit': thisGame.timeControl,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final roomName = data['game']['room_name'];
      final player1Color = data['game']['player_1_color'];
      final player2Color = data['game']['player_2_color'];
      final player1Id = data['game']['player_1'];
      final player2Id = data['game']['player_2'];

      String thisPlayerColor = ''; // Default value
      int thisId = Get.find<UserController>().currentUser!.user.id;
      // Determine the current player's color
      if (player1Id == thisId) {
        thisPlayerColor = player1Color;
      } else if (player2Id == thisId) {
        thisPlayerColor = player2Color;
      }
      Get.find<BoardController>().setTihsPlayerColor(thisPlayerColor);

      return roomName;
    } else {
      return 'error in room name';
    }
  } catch (e) {
    rethrow;
  }
}

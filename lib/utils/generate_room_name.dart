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

      // Assuming ConstData.userId contains the current player's user ID
      String thisPlayerColor = 'white'; // Default value
      String thisId =
          Get.find<UserController>().currentUser!.user.id.toString();
      // Determine the current player's color
      if (player1Id == thisId) {
        thisPlayerColor = player1Color; // You are player 1
      } else if (player2Id == thisId) {
        thisPlayerColor = player2Color; // You are player 2
      }

      print("Room Name: $roomName");
      print("You are playing as: $thisPlayerColor");
      Get.find<BoardController>().setTihsPlayerColor(thisPlayerColor);
      // Now you can pass thisPlayerColor to your boardController
      // Example: BoardController.setPlayerColor(thisPlayerColor);
      return roomName;
    } else {
      print(response.body);
      return 'error in room name, ';
    }
  } catch (e) {
    print('Error fetching room name: $e');
    rethrow;
  }
}

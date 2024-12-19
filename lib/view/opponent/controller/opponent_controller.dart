import 'package:chess_league/core/const_data/app_link.dart';
import 'package:chess_league/model/available_games.dart';
import 'package:chess_league/model/chess_piece.dart';
import 'package:chess_league/model/user_model.dart';
import 'package:chess_league/utils/generate_room_name.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:chess_league/view/opponent/utils/set_game_details.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class OpponentController extends BoardController {
  late User thisUser;
  late AvailableGame thisGame;
  late WebSocketChannel channel; // WebSocket channel instance
  String roomName = '';
  bool gameStarted = false;

  void setPlayerConfig(User user, AvailableGame game) {
    isVsOpponent = true;
    thisUser = user;
    thisGame = game;
  }

  // Initialize WebSocket connection
  void connectToWebSocket() async {
    try {
      roomName = await fetchRoomNameAndAssignColor(
          thisGame: thisGame); // Get room name from backend
      String wsUrl = '${AppLink.channelsLink}/$roomName/';
      print('Connecting to: $wsUrl');

      channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      joinGame();

      // Listen for incoming messages
      channel.stream.listen(
        (message) {
          _handleIncomingMessage(message);
        },
        onError: (error) {
          print('WebSocket Error: $error');
        },
        onDone: () {
          print('WebSocket Closed');
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  void joinGame() {
    final gameDetails = {
      'action': 'join_game',
      'game_type': thisGame.gameName,
      'time_limit': thisGame.timeControl,
      'player_1': {
        'username': thisUser.username,
        'email': thisUser.email,
      },
    };

    channel.sink.add(jsonEncode(gameDetails));
    print('Sent: ${jsonEncode(gameDetails)}');
  }

  void _handleIncomingMessage(String message) {
    final data = jsonDecode(message);
    print('Decoded message: $data');

    if (data.containsKey('game')) {
      print('got hereeeeeeeeeeeeeeeeeeeeeeeeeee');
      setDetials(data['game']);
    }

    if (data.containsKey('move')) {
      print('Opponent move: ${data['move']}');
      onOpponentMoveReceived(data['move']);
    } else if (data['message'] == 'Game joined successfully' &&
        data['status'] == 'active') {
      print('player 2 info incoming...');
    } else if (data['status'] == 'waiting') {
      print('Waiting for opponent...');
    }
  }

  void onOpponentMoveReceived(Map<String, dynamic> moveData) {
    final boardController = Get.find<BoardController>();

    // Ensure the move is from the opponent
    String movePlayerColor = moveData['player']; // "white" or "black"
    bool isOpponentMove = movePlayerColor != boardController.thisPlayerColor;

    if (!isOpponentMove) {
      print("Ignoring move sent by the current player.");
      return; // Ignore moves sent by the current player
    }

    // Lock interaction for the current player
    boardController.isWaitingForOpponentMove = true;

    // Apply the opponent's move to the board
    List<dynamic> fromDynamic = moveData['from'];
    List<dynamic> toDynamic = moveData['to'];

    // Safely cast List<dynamic> to List<int>
    List<int> from = fromDynamic.cast<int>();
    List<int> to = toDynamic.cast<int>();

    // If the current player is black, flip the coordinates
    if (boardController.thisPlayerColor == "black") {
      from = [7 - from[0], 7 - from[1]];
      to = [7 - to[0], 7 - to[1]];
    }

    // Apply the opponent's move to the board
    ChessPiece? movedPiece = boardController.board[from[0]][from[1]];
    boardController.board[to[0]][to[1]] = movedPiece;
    boardController.board[from[0]][from[1]] = null;

    // Update the board controller state
    boardController.isWhiteTurn = !boardController.isWhiteTurn;

    // Unlock interaction for the current player after the move is applied
    boardController.isWaitingForOpponentMove = false;

    // Update the board state
    boardController.updateState();

    // Log the move for debugging purposes
    print(
        "Move applied: From [${from[0]}, ${from[1]}] to [${to[0]}, ${to[1]}]. Turn updated.");
  }

  @override
  void onClose() {
    super.onClose();
    channel.sink.close();
    print('WebSocket connection closed.');
  }
}

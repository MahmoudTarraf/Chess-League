import 'package:chess_league/core/const_data/app_link.dart';
import 'package:chess_league/model/available_games.dart';
import 'package:chess_league/model/chess_piece.dart';
import 'package:chess_league/model/user_model.dart';
import 'package:chess_league/utils/generate_room_name.dart';
import 'package:chess_league/view/auth/user/user_controller.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:chess_league/view/board/screen/board_screen.dart';
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
      print('=====================');
      print('=====================');
      print(roomName);
      String wsUrl = '${AppLink.channelsLink}/$roomName/';
      print('Connecting to: $wsUrl');

      channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      joinGame();

      // Listen for incoming messages
      channel.stream.listen(
        (message) {
          print('Received: $message');
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
      print(e);
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
    if (data.containsKey('player_2_info')) {
      final opponentProfile = data['player_2_info'];
      final temp = UserModel(
        accessToken: '',
        user: User(
          id: opponentProfile['id'],
          username: opponentProfile['username'],
          email: opponentProfile['email'],
          image: 'image',
          rating: opponentProfile['rating'],
        ),
      );
      Get.find<UserController>().setOpponentModel(temp);
      Get.off(() => const BoardScreen());
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

// Function to handle receiving the opponent's move
  void onOpponentMoveReceived(Map<String, dynamic> moveData) {
    final boardController = Get.find<BoardController>();

    // Check if the move is from the opponent
    bool isOpponentWhite = moveData['player'] == 'White';
    if (isOpponentWhite) {
      print("Ignoring move sent by the current player.");
      return; // Ignore moves sent by the current player
    }

    // Apply the opponent's move to the board
    List<int> from = moveData['from'];
    List<int> to = moveData['to'];

    ChessPiece? movedPiece = boardController.board[from[0]][from[1]];
    boardController.board[to[0]][to[1]] = movedPiece;
    boardController.board[from[0]][from[1]] = null;

    // Update turn logic
    boardController.isWhiteTurn = !boardController.isWhiteTurn;

    boardController.isWaitingForOpponentMove = false; // Unlock interaction

    // Update the board state
    boardController.updateState();
  }

  @override
  void onClose() {
    super.onClose();
    channel.sink.close();
    print('WebSocket connection closed.');
  }
}

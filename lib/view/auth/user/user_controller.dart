import 'package:chess_league/core/class/crud.dart';
import 'package:chess_league/core/const_data/app_link.dart';
import 'package:chess_league/core/const_data/const_data.dart';
import 'package:chess_league/core/service/messages.dart';
import 'package:chess_league/core/service/my_service.dart';
import 'package:chess_league/core/service/shared_prefrences_keys.dart';
import 'package:chess_league/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  UserModel userModel = temp;
  UserModel opponent = temp;
  void setUserModel(UserModel user) {
    userModel = user;
  }

  void setOpponentModel(UserModel user) {
    opponent = user;
  }

  UserModel? get currentUser => userModel;
  UserModel? get opponentUser => opponent;

  Future<void> getuserData() async {
    try {
      final email = await MyService().getStringData(SharedPrefrencesKeys.email);

      final result = await Crud().getData(
        "${AppLink.getUser}$email",
      );
      result.fold((error) {
        Messages.getSnackMessage(
          "Error",
          error.toString(),
          Colors.red,
        );
      }, (responseBody) async {
        final userModel = User.fromJson(responseBody);
        print(userModel.id);
        setUserModel(
          UserModel(
            accessToken: "${ConstData.accessToken}",
            user: userModel,
          ),
        );
        update();
      });
    } catch (e) {
      Messages.getSnackMessage(
        'Error',
        e.toString(),
        Colors.red,
      );
    }
  }
}

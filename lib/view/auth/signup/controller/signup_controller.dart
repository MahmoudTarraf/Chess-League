// ignore_for_file: unused_field

import 'dart:convert';

import 'package:chess_league/core/class/crud.dart';
import 'package:chess_league/core/class/status_request.dart';
import 'package:chess_league/core/const_data/app_link.dart';
import 'package:chess_league/core/service/messages.dart';
import 'package:chess_league/core/service/routes.dart';
import 'package:chess_league/model/levels_model.dart';
import 'package:chess_league/view/auth/user_service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/user_model.dart';

class SignupController extends GetxController {
  LevelsModel selectedLevel = LevelsModel(
    levelName: '',
    iconData: Icons.abc,
  );
  bool isPasswordVisible = false;
  bool isPasswordAgainVisible = false;
  StatusRequest statusRequest = StatusRequest.none;
  String _userName = '';
  String _email = '';
  String _password = '';

  void setUserName(String name) {
    _userName = name;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  // Validators
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  void seletLevel(LevelsModel level) {
    selectedLevel = level;
    update();
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Weak Password! Must be at least 6 characters';
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value != _password) {
      return 'Passwords don\'t match!';
    }
    if (value.length < 6) {
      return 'Weak Password! Must be at least 6 characters';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!value.contains('@')) {
      return 'Not a valid email!';
    }
    return null;
  }

  Future<void> signUp() async {
    try {
      if (selectedLevel.levelName == '' ||
          selectedLevel.iconData == Icons.abc) {
        Messages.getSnackMessage(
          'Error',
          'Choose level!',
          Colors.red,
        );
        return;
      }

      int rating = getRating(selectedLevel);
      final Map<String, dynamic> body = {
        'username': _userName,
        'email': _email,
        'password': _password,
        'image': 'image',
        'rating': rating
      };
      statusRequest = StatusRequest.loading;
      update();
      final result = await Crud().postData(
        AppLink.signup,
        body,
        AppLink().getHeader(),
        true,
        isFormData: false,
      );
      result.fold((error) {
        statusRequest = StatusRequest.failure; // Update with error status

        Messages.getSnackMessage(
          "Error",
          error,
          Colors.red,
        );
      }, (responseBody) {
        statusRequest = StatusRequest.success;
        final userModel = userModelFromJson(jsonEncode(responseBody));

        Get.find<UserService>().setUser(userModel);

        Messages.getSnackMessage(
          'Signup Successful',
          'Login To Your Account!',
          Colors.green,
        );
        Get.offNamed(Routes.loginScreen);
      });
    } catch (e) {
      statusRequest = StatusRequest.serverFailure; // General failure status

      Messages.getSnackMessage(
        'Error',
        e.toString(),
        Colors.red,
      );
    } finally {
      statusRequest = StatusRequest.none;

      update();
    }
  }

  // Form validation and submission
  void verify(var key) async {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      Get.toNamed(Routes.playerRatingScreen);
    }
  }

  // Toggling password visibility
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void togglePasswordAgainVisibility() {
    isPasswordAgainVisible = !isPasswordAgainVisible;
    update();
  }

  int getRating(LevelsModel selectedLevel) {
    if (selectedLevel.levelName == 'Noob') {
      return 500;
    } else if (selectedLevel.levelName == 'Beginner') {
      return 1000;
    } else if (selectedLevel.levelName == 'Good') {
      return 1500;
    } else {
      return 1800;
    }
  }
}

// ignore_for_file: unused_field

import 'dart:convert';

import 'package:chess_league/core/class/crud.dart';
import 'package:chess_league/core/class/status_request.dart';
import 'package:chess_league/core/const_data/app_link.dart';
import 'package:chess_league/core/service/messages.dart';
import 'package:chess_league/core/service/my_service.dart';
import 'package:chess_league/core/service/routes.dart';
import 'package:chess_league/model/user_model.dart';
import 'package:chess_league/view/auth/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  bool isPasswordVisible = false;
  StatusRequest statusRequest = StatusRequest.none;

  String _email = '';
  String _password = '';

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

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
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

  Future<void> login() async {
    try {
      final Map<String, dynamic> body = {
        'email': _email,
        'password': _password,
      };
      statusRequest = StatusRequest.loading;
      update();
      final result = await Crud().postData(
        AppLink.login,
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
      }, (responseBody) async {
        statusRequest = StatusRequest.success;
        final userModel = userModelFromJson(jsonEncode(responseBody));

        Get.find<UserController>().setUserModel(userModel);

        Messages.getSnackMessage(
          'Signup Successful',
          'Login To Your Account!',
          Colors.green,
        );
        await MyService().storeIsLogin(true);
        Get.offAllNamed(Routes.homeScreen);
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
      await login();
    }
  }

  // Toggling password visibility
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }
}

import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Messages {
  static void showCheckmateDialog(bool isWhiteTurn, Function resetGame) {
    Get.dialog(
      AlertDialog(
        title: const Text('Checkmate'),
        content: Text(isWhiteTurn ? 'Black wins!' : 'White wins!'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
              resetGame();
            },
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  static Future<bool> onWillPop(String message, String body) async {
    bool shouldExit = false; // Variable to track if the app should close

    await Get.defaultDialog(
      backgroundColor: ColorsManager.white,
      buttonColor: ColorsManager.primary,
      title: message,
      middleText: body,
      textCancel: "No",
      textConfirm: "Yes",
      confirmTextColor: Colors.white,
      onCancel: () {
        shouldExit = false; // Don't exit the app
      },
      onConfirm: () {
        shouldExit = true; // Set to true to signal app exit
        Get.back(); // Close the dialog
      },
    );
    return shouldExit; // Return true if the user confirmed to exit
  }
}

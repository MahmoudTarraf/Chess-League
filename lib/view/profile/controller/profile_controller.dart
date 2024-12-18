import 'dart:io';
import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/core/service/messages.dart';
import 'package:chess_league/core/service/routes.dart';
import 'package:chess_league/view/auth/user/user_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final userController = Get.find<UserController>();
  final thisUser = Get.find<UserController>().currentUser!.user;
  bool choseImage = false;

  // Variables for image handling
  final ImagePicker _picker = ImagePicker();
  File? image;
  String? imageUrl;
  var selectedImagePath = '';

  // Function to pick an image from the gallery
  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path); // Set the selected image
      selectedImagePath = pickedFile.path;
      choseImage = true;
      update();
    } else {
      selectedImagePath = 'No image selected';
      update();
    }
  }

  Future<void> uploadImage() async {
    if (image == null) return;

    try {
      update();
      Get.offNamed(Routes.profileScreen);
    } catch (e) {
      Messages.getSnackMessage("Error", e.toString(), ColorsManager.primary);
    }
  }

  Future<void> getImage() async {
    try {
      // if (userSnapshot.exists && userSnapshot['profileImageUrl'] != null) {
      //   imageUrl = userSnapshot['profileImageUrl'];
      //   update(); // Notify the UI about the change
      // }
    } catch (e) {
      return;
    }
  }

  // Logout logic
  Future<void> logOut() async {
    bool shouldExit = false;
    await Get.defaultDialog(
      backgroundColor: ColorsManager.white,
      buttonColor: ColorsManager.primary,
      title: "Logout Now",
      middleText: "Are you sure you want to Logout?",
      textCancel: "No",
      textConfirm: "Yes",
      confirmTextColor: ColorsManager.white,
      onCancel: () {
        shouldExit = false; // Don't exit the app
        Get.back(); // Close the dialog
        return;
      },
      onConfirm: () {
        shouldExit = true;
        Get.back();
      },
    );
    if (shouldExit == true) {
      try {
        //Get.offAllNamed(Routes.signupScreen);
        // Messages.getSnackMessage('Logged Out',
        //     'You have been successfully logged out.', ColorsManager.green);
      } catch (e) {
        rethrow;
      }
    }
  }
}

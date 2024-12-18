import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/view/profile/controller/profile_controller.dart';
import 'package:chess_league/widgets/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:sizer/sizer.dart';

import '../../../widgets/buttons/custom_text_icon_button.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Image from Gallery'),
      ),
      body: GetBuilder(
        init: ProfileController(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              controller.selectedImagePath == ''
                  ? const Text('No image selected')
                  : InkWell(
                      onTap: () => controller.pickImageFromGallery(),
                      child: CircleAvatar(
                        radius: 100,
                        foregroundImage: FileImage(
                          File(controller.selectedImagePath),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              CustomTextIconButton(
                width: 90.w,
                textButtonIcon:
                    const Icon(Icons.photo, color: ColorsManager.primary),
                title: "Select Image from Gallery",
                onPressed: controller.pickImageFromGallery,
                height: 9.h,
                backgroundColor: ColorsManager.white,
                foregroundColor: ColorsManager.black,
              ),
              SizedBox(
                height: 2.h,
              ),
              Visibility(
                visible: controller.choseImage,
                child: CustomElevatedButton(
                  width: 50.w,
                  onPressed: () {
                    controller.uploadImage();
                  },
                  height: 7.h,
                  backgroundColor: ColorsManager.primary,
                  foregroundColor: ColorsManager.white,
                  child: Text(
                    'Save Image',
                    style:
                        TextStyle(fontSize: 18.sp, color: ColorsManager.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

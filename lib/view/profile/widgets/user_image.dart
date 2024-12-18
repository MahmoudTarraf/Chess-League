import 'package:chess_league/view/profile/screen/profile_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/const_data/app_images.dart';
import '../controller/profile_controller.dart';

Widget userImage(double height, double width) {
  final controller = Get.put(ProfileController());
  return InkWell(
    onTap: () => Get.to(() => const ProfileImage()),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(100), // Make the image rounded
      child: controller.imageUrl != null && controller.imageUrl!.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: controller.imageUrl!, // Firebase image URL
              height: height.h,
              width: width.w,
              fit: BoxFit.cover, // Ensure the image fits the container
              placeholder: (context, url) => SvgPicture.asset(
                AppImages.chessLanding,
              ),
              errorWidget: (context, url, error) => SvgPicture.asset(
                AppImages.chessLanding2,
                height: height.h,
                width: width.w,
                fit: BoxFit.cover,
              ),
            )
          : SvgPicture.asset(
              AppImages.chessLanding, // Default local image
              height: height.h,
              width: width.w,
              fit: BoxFit.cover,
            ),
    ),
  );
}

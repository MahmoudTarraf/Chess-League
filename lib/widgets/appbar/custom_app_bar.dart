import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.iconData,
    required this.title,
    required this.backGroundColor,
    this.showBackButton = true,
  });
  final IconData? iconData;
  final Color backGroundColor;
  final String title;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // This disables the default back button
      backgroundColor: backGroundColor,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                iconData,
                color: ColorsManager.black, // Customize the color of the icon
              ),
              onPressed: () {
                Get.back();
              },
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'play',
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({
    super.key,
    required this.icon,
    required this.title,
    required this.backGroundColor,
    required this.lateWidget,
  });
  final IconData? icon;
  final Color backGroundColor;
  final String title;
  final Widget lateWidget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // This disables the default back button
      backgroundColor: backGroundColor,
      leading: IconButton(
        icon: Icon(
          icon,
          color: ColorsManager.primary, // Customize the color of the icon
        ),
        onPressed: () async {
          Get.back();
        },
      ),
      title: Row(
        children: [
          SizedBox(
            width: 20.w,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 25.w,
          ),
          lateWidget,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

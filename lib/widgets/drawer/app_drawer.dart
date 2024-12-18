import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/core/const_data/app_images.dart';
import 'package:chess_league/core/service/routes.dart';
import 'package:chess_league/view/auth/user/user_controller.dart';
import 'package:chess_league/view/profile/screen/profile_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final thisUser = Get.find<UserController>().currentUser!.user;
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: ListTile(
              leading: Container(
                width: 23.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  AppImages.blackKnight,
                ),
              ),
              title: Text(
                'Hey!',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                thisUser.username,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: ColorsManager.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          drawerItemCreator(
            icon: Icons.home,
            title: "Homepage",
            function: () {
              Get.toNamed(Routes.homeScreen);
              Get.back();
            },
          ),
          drawerItemCreator(
            icon: Icons.message,
            title: "Messages",
            function: () {},
          ),
          drawerItemCreator(
            icon: Icons.person,
            title: "Profile",
            function: () => Get.to(() => const ProfileScreen()),
          ),
          drawerItemCreator(
            icon: Icons.settings,
            title: "Settings",
            function: () {},
          ),
          const Divider(
            color: ColorsManager.backgroundColor,
            thickness: 2,
          ),
          TextButton.icon(
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: () {},
            label: Text(
              "Logout",
              style: TextStyle(
                fontSize: 17.sp,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget drawerItemCreator({
  required IconData icon,
  required String title,
  required Function()? function,
}) {
  return GestureDetector(
    onTap: function,
    child: ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          color: ColorsManager.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: ColorsManager.black,
        size: 20,
      ),
    ),
  );
}

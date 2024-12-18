import 'package:chess_league/core/const_data/my_size.dart';
import 'package:chess_league/view/auth/user/user_controller.dart';
import 'package:chess_league/view/profile/widgets/profile_appbar.dart';
import 'package:chess_league/view/profile/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/const_data/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (controller) {
        final user = controller.currentUser!.user;
        return RefreshIndicator(
          onRefresh: () => controller.getuserData(),
          child: Scaffold(
            backgroundColor: ColorsManager.scaffoldBackColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileAppBar(
                    lateWidget: InkWell(
                      onTap: () {
                        showMenu(
                            color: ColorsManager.white,
                            context: context,
                            position: RelativeRect.fromLTRB(
                                MySize.screenWidth(context),
                                MySize.screenHeight(context) * 0.05,
                                0,
                                0),
                            items: <PopupMenuEntry<dynamic>>[
                              PopupMenuItem(
                                child: const Text('Edit Profile'),
                                onTap: () {},
                              )
                            ]);
                      },
                      child: const Icon(
                        Icons.menu,
                        size: 35,
                        color: Colors.amber,
                      ),
                    ),
                    icon: Icons.arrow_back_ios,
                    backGroundColor: ColorsManager.scaffoldBackColor,
                    title: 'Profile',
                  ),
                  userImage(20, 40),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      user.username,
                      style: TextStyle(
                        fontSize: 19.sp,
                        color: ColorsManager.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: ColorsManager.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    //onTap: () => Get.toNamed(Routes.changePassword),
                    child: profileItemCreator(
                      title: "Change Password",
                      prefix: const Icon(
                        Icons.lock,
                        color: ColorsManager.primary,
                      ),
                    ),
                  ),
                  InkWell(
                    // onTap: () => Get.toNamed(Routes.messaging),
                    child: profileItemCreator(
                      title: "My Chats",
                      prefix: const Icon(
                        Icons.chat,
                        color: ColorsManager.primary,
                      ),
                    ),
                  ),
                  InkWell(
                    //onTap: () => Get.to(() => const SettingsScreen()),
                    child: profileItemCreator(
                      title: "Settings",
                      prefix: const Icon(
                        Icons.settings,
                        color: ColorsManager.primary,
                      ),
                    ),
                  ),
                  InkWell(
                    //  onTap: () => Get.to(() => const ProfileHelp()),
                    child: profileItemCreator(
                      title: "Help Center",
                      prefix: const Icon(
                        Icons.help,
                        color: ColorsManager.primary,
                      ),
                    ),
                  ),
                  InkWell(
                    // onTap: () => controller.logOut(),
                    child: profileItemCreator(
                      title: "Logout",
                      prefix: const Icon(
                        Icons.logout,
                        color: ColorsManager.primary,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget profileItemCreator({
  required String title,
  required Icon prefix,
}) {
  return Container(
    margin: const EdgeInsets.all(5),
    width: Adaptive.w(95),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    child: ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 17.sp,
          color: ColorsManager.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      leading: prefix,
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: ColorsManager.white,
      ),
    ),
  );
}

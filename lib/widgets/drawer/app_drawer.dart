import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/core/const_data/app_images.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsManager.white,
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
                  AppImages.blackBishop,
                  fit: BoxFit.cover,
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
                'James Karl',
                style: TextStyle(
                  fontSize: 17.sp,
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
            function: () {},
          ),
          drawerItemCreator(
            icon: Icons.shopping_cart,
            title: "Cart",
            function: () {},
          ),
          drawerItemCreator(
            icon: Icons.payment,
            title: "Checkout",
            function: () {},
          ),
          drawerItemCreator(
            icon: Icons.search,
            title: "Search Products",
            function: () {},
          ),
          drawerItemCreator(
            icon: Icons.wallet,
            title: "Wallet",
            function: () {},
          ),
          drawerItemCreator(
            icon: Icons.list_alt,
            title: "Orders",
            function: () {},
          ),
          drawerItemCreator(
            icon: Icons.message,
            title: "Messages",
            function: () {},
          ),
          drawerItemCreator(
            icon: Icons.person,
            title: "Profile",
            function: () {},
          ),
          drawerItemCreator(
            icon: Icons.settings,
            title: "Settings",
            function: () {},
          ),
          drawerItemCreator(
            icon: Icons.point_of_sale,
            title: "Points",
            function: () {},
          ),
          const Divider(
            color: ColorsManager.grey,
            thickness: 2,
          ),
          TextButton.icon(
            icon: const Icon(
              Icons.logout,
              color: ColorsManager.primary,
            ),
            onPressed: () {},
            label: Text(
              "Logout",
              style: TextStyle(
                fontSize: 17.sp,
                color: ColorsManager.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget drawerItemCreator(
    {required IconData icon,
    required String title,
    required Function()? function}) {
  return GestureDetector(
    onTap: () => function,
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

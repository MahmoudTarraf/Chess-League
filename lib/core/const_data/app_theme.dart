import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static const lightThemeFont = "ComicNeue", darkThemeFont = "Poppins";

  // light theme
  static final lightTheme = ThemeData(
    primaryColor: ColorsManager.lightThemeColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorsManager.white,
    useMaterial3: true,
    fontFamily: lightThemeFont,
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>(
          (states) => ColorsManager.lightThemeColor),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorsManager.white,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: ColorsManager.black,
        fontSize: 23, //20
      ),
      iconTheme: IconThemeData(color: ColorsManager.lightThemeColor),
      elevation: 0,
      actionsIconTheme: IconThemeData(color: ColorsManager.lightThemeColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorsManager.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  );

  // dark theme
  static final darkTheme = ThemeData(
    primaryColor: ColorsManager.darkThemeColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorsManager.black,
    useMaterial3: true,
    fontFamily: darkThemeFont,
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith<Color>(
          (states) => ColorsManager.darkThemeColor),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorsManager.black,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: ColorsManager.white,
        fontSize: 23, //20
      ),
      iconTheme: IconThemeData(color: ColorsManager.darkThemeColor),
      elevation: 0,
      actionsIconTheme: IconThemeData(color: ColorsManager.darkThemeColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorsManager.black,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
  );

  // colors
}

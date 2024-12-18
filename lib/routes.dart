import 'package:chess_league/core/service/routes.dart';
import 'package:chess_league/view/auth/landing/screen/landing_screen.dart';
import 'package:chess_league/view/auth/login/screen/login_screen.dart';
import 'package:chess_league/view/auth/player_rating/screen/player_rating.dart';
import 'package:chess_league/view/auth/signup/screen/signup_screen.dart';
import 'package:chess_league/view/auth/splash_screen_folder/screen/splash_screen.dart';
import 'package:chess_league/view/home/screen/home_screen.dart';
import 'package:chess_league/view/profile/screen/profile_main_screen.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: Routes.homeScreen,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: Routes.signupScreen,
    page: () => SignupScreen(),
  ),
  GetPage(
    name: Routes.loginScreen,
    page: () => LoginScreen(),
  ),
  GetPage(
    name: Routes.landingScreen,
    page: () => LandingSCreen(),
  ),
  GetPage(
    name: Routes.playerRatingScreen,
    page: () => const PlayerRatingScreen(),
  ),
  GetPage(
    name: Routes.profileScreen,
    page: () => const ProfileScreen(),
  ),
  GetPage(
    name: Routes.splashScreen,
    page: () => const SplashScreen(),
  ),
];

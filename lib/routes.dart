import 'package:chess_league/view/home/screen/home_screen.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: '/homeScreen',
    page: () => const HomeScreen(),
  ),
];

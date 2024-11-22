// ignore_for_file: camel_case_types

import 'package:chess_league/binding/initial_bindings.dart';
import 'package:chess_league/core/const_data/app_theme.dart';
import 'package:chess_league/core/service/my_service.dart';
import 'package:chess_league/core/service/routes.dart';
import 'package:chess_league/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await initialService();
  final initialRoute = await MyService().getIsLoginKey() == true
      ? Routes.homeScreen
      : Routes.landingScreen;
  runApp(MyApp(
    initialRoute: initialRoute,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.initialRoute,
  });
  final String? initialRoute;

  @override
  Widget build(BuildContext context) {
    print(initialRoute);
    return ResponsiveSizer(
      builder: (p0, p1, p2) => GetMaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        initialBinding: InitialBindings(),
        getPages: routes,
        initialRoute: initialRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

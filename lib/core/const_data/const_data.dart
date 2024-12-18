import 'dart:async';

class ConstData {
  static bool isLogin = false;
  static String? accessToken = "";
  static Future<void> updateToken() async {}
  static Future<void> startTokenUpdater() async {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      updateToken();
    });
  }
}

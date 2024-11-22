//this file for the API

import 'package:chess_league/core/const_data/const_data.dart';

class AppLink {
  // Remote link
  static String appRoot = "http://192.168.1.4:8000";
  static String signup = "$appRoot/signup";
  static String login = "$appRoot/login";

  // Token link

  Map<String, String> getHeader() {
    Map<String, String> mainHeader = {
      "Content-Type": "application/json",
    };
    return mainHeader;
  }

  Map<String, String> getHeaderToken() {
    Map<String, String> mainHeader = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ConstData.token}'
    };
    return mainHeader;
  }
}

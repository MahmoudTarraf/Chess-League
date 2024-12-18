//this file for the API

import 'package:chess_league/core/const_data/const_data.dart';

class AppLink {
  // Remote link
  static String myIp = '192.168.1.2:8000';
  static String appRoot = "http://$myIp";
  static String signup = "$appRoot/signup";
  static String login = "$appRoot/login";
  static String getUser = "$appRoot/get_user/";
  static String roomName = "$appRoot/get_or_create_room/";
  // channels remote link
  static String channelsLink = 'ws://$myIp/ws/chess';

  // Token link

  Map<String, String> getHeader() {
    Map<String, String> mainHeader = {
      "Content-Type": "application/json",
    };
    return mainHeader;
  }

  Map<String, String> getHeaderToken() {
    Map<String, String> mainHeader = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${ConstData.accessToken}'
    };
    return mainHeader;
  }
}

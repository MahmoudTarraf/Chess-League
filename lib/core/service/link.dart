//this file for the API

import 'package:chess_league/core/const_data/const_data.dart';

class AppLink {
  // Remote link
  static String appRoot = "https://";
  static String imageWithRoot = "$appRoot/storage";
  static String imageWithoutRoot = "$appRoot/";
  static String serverApiRoot = "$appRoot/api";

  static String login = "$serverApiRoot/login";
  static String home = "$serverApiRoot/home";
  //Local link

  static String localLink = "http://127.0.0.1:8000/";
  // Token link

  Map<String, String> getHeader() {
    Map<String, String> mainHeader = {
      'content-type': 'application/json',
      'Accept': 'application/json',
      'X-Requested-With': 'XmlHttpRequest'
    };
    return mainHeader;
  }

  Map<String, String> getHeaderToken() {
    Map<String, String> mainHeader = {
      'content-type': 'application/json',
      'Accept': 'application/json',
      'X-Requested-With': 'XmlHttpRequest',
      'Authorization': 'Bearer ${ConstData.token}'
    };
    return mainHeader;
  }
}

// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:chess_league/core/class/check_internet.dart';
import 'package:chess_league/core/class/status_request.dart';
import 'package:chess_league/core/service/link.dart';
import 'package:chess_league/model/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<StatusRequest, Map>> postData(
    String linkUrl,
    Map data,
    Map<String, String> header,
  ) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(linkUrl),
          body: jsonEncode(data),
          headers: header,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map resposneBody = jsonDecode(response.body);
          print(resposneBody);
          return Right(resposneBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map<String, dynamic>>> getData(
    String linkUrl,
    Map data,
  ) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(
          Uri.parse(linkUrl),
          headers: AppLink().getHeaderToken(),
        );
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        print("response status code is : ${response.statusCode}");
        print("response body code is : ${response.body}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          UserModel.fromJson(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverFailure);
    }
  }
}

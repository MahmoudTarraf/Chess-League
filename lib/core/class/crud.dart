import 'dart:convert';

import 'package:chess_league/core/class/check_internet.dart';
import 'package:chess_league/core/class/status_request.dart';
import 'package:chess_league/core/const_data/app_link.dart';
import 'package:chess_league/core/service/my_service.dart';
import 'package:chess_league/core/service/shared_prefrences_keys.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<String, Map<String, dynamic>>> postData(
    String linkUrl,
    Map<String, dynamic> data,
    Map<String, String> headers,
    bool toSaveToken, {
    bool isFormData = false,
    String methodCall = "POST",
  }) async {
    try {
      if (await checkInternet()) {
        http.Response response;

        if (isFormData) {
          // If isFormData is true, use MultipartRequest for form-data
          var request = http.MultipartRequest(methodCall, Uri.parse(linkUrl));
          request.fields.addAll(
              data.map((key, value) => MapEntry(key, value.toString())));
          request.headers.addAll(headers);

          final streamedResponse = await request.send();
          response = await http.Response.fromStream(streamedResponse);
        } else {
          // Otherwise, send as JSON
          response = await http.post(
            Uri.parse(linkUrl),
            body: jsonEncode(data),
            headers: headers,
          );
        }

        var responseBody = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (toSaveToken && responseBody?['access_token'] != null) {
            var token = responseBody['access_token'];
            await MyService()
                .storeStringData(SharedPrefrencesKeys.accessToken, token);
            await MyService().storeStringData(
              SharedPrefrencesKeys.email,
              responseBody['user']['email'],
            );
            await MyService().setConstantData();
          }

          return Right(responseBody);
        } else {
          var message = responseBody.toString();
          return Left(message);
        }
      } else {
        var message = "Server Offline!";

        return Left(message);
      }
    } catch (e) {
      var message = e.toString();

      return Left(message);
    }
  }

  Future<Either<String, Map<String, dynamic>>> getData(
    String linkUrl,
  ) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(
          Uri.parse(linkUrl),
          headers: AppLink().getHeaderToken(),
        );
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(responseBody);
        } else {
          var message = responseBody;
          return Left(message.toString());
        }
      } else {
        return Left(StatusRequest.offlineFailure.toString());
      }
    } catch (_) {
      return Left(StatusRequest.serverFailure.toString());
    }
  }
}

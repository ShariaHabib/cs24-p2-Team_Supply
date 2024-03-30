import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class ResetPasswordInitiate {
  static Future<RegistGeneralResponse> reset(String email) async {
    late RegistGeneralResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
      };
      String body = json.encode({"email": email});
      var resp = await http.post(
        Uri.parse(API_RESET_INIT),
        headers: headers,
        body: body,
      );
      print(resp.body);
      data = RegistGeneralResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = RegistGeneralResponse(message: e.toString(), success: false);
    }
    return data;
  }
}

class ResetPasswordConfirm {
  static Future<RegistGeneralResponse> confirm(
      String veriToken, String newPassword) async {
    late RegistGeneralResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
      };
      String body = json.encode(
          {"verification_token": veriToken, "new_password": newPassword});
      var resp = await http.post(
        Uri.parse(API_RESET_CONFIRM),
        headers: headers,
        body: body,
      );
      print(resp.body);
      data = RegistGeneralResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = RegistGeneralResponse(message: e.toString(), success: false);
    }
    return data;
  }
}

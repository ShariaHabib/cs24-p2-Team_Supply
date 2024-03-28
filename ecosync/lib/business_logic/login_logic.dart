import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class LoginLogic {
  static Future<LoginResponse> login(String email, String password) async {
    late LoginResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
      };
      String body = LoginModel(email: email, password: password).toJson();

      var resp = await http.post(
        Uri.parse(API_LOGIN),
        headers: headers,
        body: body,
      );
      print(resp.body);
      data = LoginResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = LoginResponse(
          message: e.toString(), token: "", userId: "", success: false);
    }
    return data;
  }
}

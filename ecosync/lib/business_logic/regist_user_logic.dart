import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class RegistUserLogic {
  static Future<RegistGeneralResponse> registUser(String token, String userName,
      String email, String password, String userRole) async {
    late RegistGeneralResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };

      String body = User(
              email: email,
              userName: userName,
              userRole: userRole,
              password: password)
          .toJson();

      http.Response resp = await http.post(
        Uri.parse(API_GET_USERS),
        headers: headers,
        body: body,
      );
      data = RegistGeneralResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = RegistGeneralResponse(message: e.toString(), success: false);
    }
    return data;
  }
}

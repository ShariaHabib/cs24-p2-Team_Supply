import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class GetUserInfoLogic {
  static Future<User> getUserInfo(String token, String userId) async {
    late User data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      http.Response resp = await http.get(
        Uri.parse(API_GET_USER_INFO + userId),
        headers: headers,
      );
      data = User.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = User(
          email: "", userName: "", userRole: "", success: false, userId: "");
    }
    return data;
  }
}

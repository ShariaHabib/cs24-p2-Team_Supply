import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class LogoutLogic {
  static Future<RegistGeneralResponse> logout() async {
    late RegistGeneralResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
      };
      var resp = await http.get(
        Uri.parse(API_LOGOUT),
        headers: headers,
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

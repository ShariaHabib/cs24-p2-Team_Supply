import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class LoginLogic {
  static Future<dynamic> login(String email, String password) async {
    try {
      String body = LoginModel(email: email, password: password).toJson();

      http.Response resp = await http.post(
        Uri.parse(API_LOGIN),
        body: body,
      );
      print(resp);
    } catch (e) {
      print(e);
    }
  }
}

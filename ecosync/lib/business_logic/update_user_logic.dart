import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class UpdateUserLogic {
  static Future<RegistGeneralResponse> updateUser(
      String token, String name, String userId) async {
    late RegistGeneralResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      String body = User(
        userName: name,
      ).toJson();

      print(body);
      var resp = await http.put(
        Uri.parse(API_UPDATE_USER + userId),
        headers: headers,
        body: body,
      );
      data = RegistGeneralResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = RegistGeneralResponse(message: "", success: false);
    }
    return data;
  }
}

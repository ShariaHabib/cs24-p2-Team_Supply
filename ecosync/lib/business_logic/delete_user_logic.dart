import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class DeleteUserLogic {
  static Future<RegistGeneralResponse> deleteUser(
      String token, String userId) async {
    late RegistGeneralResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      http.Response resp = await http.delete(
        Uri.parse(API_DELETE_USER + userId),
        headers: headers,
      );
      print("\n\n\n\n\n\n");
      print(resp.body.toString());
      print("\n\n\n\n\n\n");
      data = RegistGeneralResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = RegistGeneralResponse(message: e.toString(), success: false);
    }
    return data;
  }
}

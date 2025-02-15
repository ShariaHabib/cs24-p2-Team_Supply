import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class UpadateRolesLogic {
  static Future<RegistGeneralResponse> updateRole(
      String token, String roleId, String userId) async {
    late RegistGeneralResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      String body = Role(roleId: int.parse(roleId)).toJson();

      http.Response resp = await http.put(
          Uri.parse("$API_GET_USERS/$userId/roles"),
          headers: headers,
          body: body);
      print(resp.body);
      data = RegistGeneralResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = RegistGeneralResponse(message: "", success: false);
    }
    return data;
  }
}

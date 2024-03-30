import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class GetUserByRoleLogic {
  static Future<UserListResponse> getUser(String token, String roleId) async {
    late UserListResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      http.Response resp = await http.get(
        Uri.parse('$API_GET_USERS/$roleId'),
        headers: headers,
      );
      print(resp.body);
      data = UserListResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = UserListResponse(userList: [], success: false);
    }
    return data;
  }
}

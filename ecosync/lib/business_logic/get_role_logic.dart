import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class GetRoleLogic {
  static Future<RoleListResponse> getRole(String token) async {
    late RoleListResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      http.Response resp = await http.get(
        Uri.parse(API_GET_ROLES),
        headers: headers,
      );
      data = RoleListResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = RoleListResponse(roleList: []);
    }
    return data;
  }
}

import 'package:ecosync/models/rbac_roles_response.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class GetRbacRolesLogic {
  static Future<RbacRolesResponse> getRbacRole(String token) async {
    late RbacRolesResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      http.Response resp = await http.get(
        Uri.parse(API_GET_RBAC_ROLES),
        headers: headers,
      );
      print(resp.body);
      data = RbacRolesResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = RbacRolesResponse(roleList: [], success: false, message: "");
    }
    return data;
  }
}

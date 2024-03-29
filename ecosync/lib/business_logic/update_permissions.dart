import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/models.dart';

class UpdatePermissionLogic {
  static Future<RegistGeneralResponse> updatePermissions(
      String token, String roleId, List<int> permissionList) async {
    late RegistGeneralResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      var body = {
        "role_id": int.parse(roleId),
        "permissionList": permissionList
      };
      http.Response resp = await http.put(
          Uri.parse('http://127.0.0.1:8000/rbac/roles/$roleId/permissions'),
          headers: headers,
          body: json.encode(body));
      // print(json.e);
      data = RegistGeneralResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = RegistGeneralResponse(success: false, message: "");
    }
    return data;
  }
}

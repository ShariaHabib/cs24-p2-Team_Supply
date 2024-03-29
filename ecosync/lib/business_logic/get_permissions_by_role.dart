import 'package:ecosync/models/permission_list_model.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class GetPermissionByRoleListLogic {
  static Future<PermissionListModel> getPermissions(
      String token, String roleId) async {
    late PermissionListModel data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      http.Response resp = await http.get(
        Uri.parse('$API_GET_PERMISSIONS/$roleId'),
        headers: headers,
      );
      // print(resp.body);
      data = PermissionListModel.fromJson(resp.body);
    } catch (e) {
      print(e);
      data =
          PermissionListModel(permissionList: [], success: false, message: "");
    }
    return data;
  }
}

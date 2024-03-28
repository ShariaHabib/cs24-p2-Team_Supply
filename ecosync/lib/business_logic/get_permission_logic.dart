import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class GetPermissionListLogic {
  static Future<PermissionListModel> getPermissions(String token) async {
    late PermissionListModel data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      http.Response resp = await http.get(
        Uri.parse(API_GET_PERMISSIONS),
        headers: headers,
      );
      data = PermissionListModel.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = PermissionListModel(data: [], success: false);
    }
    return data;
  }
}

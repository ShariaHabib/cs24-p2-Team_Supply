import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class GetUserLogic {
  static Future<UserListResponse> getUser(String token) async {
    late UserListResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };
      http.Response resp = await http.get(
        Uri.parse(API_GET_USERS),
        headers: headers,
      );
      data = UserListResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = UserListResponse(userList: []);
    }
    return data;
  }
}

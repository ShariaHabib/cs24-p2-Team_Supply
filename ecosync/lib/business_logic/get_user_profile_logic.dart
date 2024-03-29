import 'package:ecosync/features/features.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class GetUserProfileLogic {
  static Future<UserProfileResponse> getUser(
    String token,
  ) async {
    late UserProfileResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      http.Response resp = await http.get(
        Uri.parse(API_GET_USER_PROFILE),
        headers: headers,
      );
      print(resp.body);
      data = UserProfileResponse.fromJson(resp.body);
      print("SYCESDADAFA");
    } catch (e) {
      print(e);
      data =
          UserProfileResponse(success: false, userData: Map<String, String>());
    }
    return data;
  }
}

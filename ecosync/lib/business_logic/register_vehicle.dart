import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class RegisterVehicleLogic {
  static Future<RegistGeneralResponse> registerVehicle(String token) async {
    late RegistGeneralResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      http.Response resp = await http.post(
        Uri.parse(API_REGIST_VEHICLE),
        headers: headers,
      );
      data = RegistGeneralResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = RegistGeneralResponse(message: "", success: false);
    }
    return data;
  }
}

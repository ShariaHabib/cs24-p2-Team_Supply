import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class DeleteVehicleLogic {
  static Future<RegistGeneralResponse> deleteVehicle(
      String token, String vehicleNumber) async {
    late RegistGeneralResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      http.Response resp = await http.delete(
        Uri.parse(API_DELETE_VEHICLE + vehicleNumber),
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

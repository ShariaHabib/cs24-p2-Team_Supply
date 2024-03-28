import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class RegisterVehicleLogic {
  static Future<RegistGeneralResponse> registerVehicle(
      {required String token,
      required int capacity,
      required String vechileNumber,
      required String vehicleType,
      required int fuelCapacityLoaded,
      required int fuelCapacityUnloaded}) async {
    late RegistGeneralResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };

      String body = Vehicle(
        vehicle_number: vechileNumber,
        vehicle_type: vehicleType,
        capacity: capacity,
        fuel_cost_loaded: fuelCapacityLoaded,
        fuel_cost_unloaded: fuelCapacityUnloaded,
      ).toJson();

      print(body);

      http.Response resp = await http.post(
        Uri.parse(API_REGIST_VEHICLE),
        headers: headers,
        body: body,
      );

      data = RegistGeneralResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = RegistGeneralResponse(message: "", success: false);
    }
    return data;
  }
}

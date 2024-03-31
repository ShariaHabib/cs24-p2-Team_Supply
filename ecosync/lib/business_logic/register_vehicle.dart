import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class RegisterVehicleLogic {
  static Future<RegistGeneralResponse> registerVehicle(
      {required String token,
      required String capacity,
      required String vechileNumber,
      required String vehicleType,
      required String fuelCapacityLoaded,
      required String fuelCapacityUnloaded,
      required String stsId}) async {
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
              capacity: int.parse(capacity),
              fuel_cost_loaded: int.parse(fuelCapacityLoaded),
              fuel_cost_unloaded: int.parse(fuelCapacityUnloaded),
              sts_id: int.parse(stsId))
          .toJson();

      print(body);

      http.Response resp = await http.post(
        Uri.parse(API_REGIST_VEHICLE),
        headers: headers,
        body: body,
      );
      print(resp.body);
      data = RegistGeneralResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = RegistGeneralResponse(message: "", success: false);
    }
    return data;
  }
}

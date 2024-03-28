import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/vehicle_list_response.dart';

class GetVehicleListLogic {
  static Future<VehicleListResponse> getVehicleList(String token) async {
    late VehicleListResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      http.Response resp = await http.get(
        Uri.parse(API_GET_VEHICLE),
        headers: headers,
      );
      data = VehicleListResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = VehicleListResponse(vehicleList: [], success: false);
    }
    return data;
  }
}

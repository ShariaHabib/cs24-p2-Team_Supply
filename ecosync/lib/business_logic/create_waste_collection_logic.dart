import 'package:ecosync/models/waste_collection_model.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/regist_general_model.dart';
import '../models/waste_collection_response_model.dart';

class RegistWasteCollectionLogic {
  static Future<RegistGeneralResponse> getWasteCollection(
      String token,
      String vehicleNumber,
      int volumeWaste,
      String arrivalTime,
      String departureTime) async {
    late RegistGeneralResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      String body = WasteCollectionModel(
              vehicle_number: vehicleNumber,
              volume_waste: volumeWaste,
              arrival_time: arrivalTime,
              departure_time: departureTime)
          .toJson();

      print(body);
      http.Response resp = await http.post(Uri.parse(API_GET_WASTE_COLLECTION),
          headers: headers, body: body);
      print(resp.body);
      data = RegistGeneralResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = RegistGeneralResponse(success: false, message: e.toString());
    }
    return data;
  }
}

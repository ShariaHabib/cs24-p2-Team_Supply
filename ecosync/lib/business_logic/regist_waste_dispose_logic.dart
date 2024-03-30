import 'package:ecosync/models/waste_dispose_model.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class ResgistWasteDisposeLogic {
  static Future<RegistGeneralResponse> registData(String token,
      {required String vehicle_number,
      required int volume_waste,
      required String arrival_time,
      required String departure_time}) async {
    late RegistGeneralResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };

      String body = WasteDisposeModel(
              vehicle_number: vehicle_number,
              volume_waste: volume_waste,
              arrival_time: arrival_time,
              departure_time: departure_time)
          .toJson();

      http.Response resp = await http.post(
        Uri.parse(API_WASTE_DISPOSE),
        headers: headers,
        body: body,
      );
      print(body);
      data = RegistGeneralResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = RegistGeneralResponse(message: e.toString(), success: false);
    }
    return data;
  }
}

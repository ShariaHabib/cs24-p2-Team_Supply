import 'package:ecosync/models/sts_model.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class UpdateSTSLogic {
  static Future<RegistGeneralResponse> updateSTS(
      {required String token,
      required int ward_no,
      required int stsId,
      required int capacity,
      required double latitude,
      required double longitude,
      String? manager}) async {
    late RegistGeneralResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      String body = STS(
              capacity: capacity,
              latitude: latitude,
              longitude: longitude,
              manager: manager ?? "",
              ward_no: ward_no,
              sts_id: stsId)
          .toJson();

      print(body);
      var resp = await http.put(
        Uri.parse(API_UPDATE_STS + stsId.toString()),
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

import 'package:ecosync/models/sts_model.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class RegistSTSLogic {
  static Future<RegistGeneralResponse> registSTS(
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
              ward_no: ward_no,
              sts_id: stsId,
              latitude: latitude,
              longitude: longitude,
              manager: manager ?? "",
              capacity: capacity)
          .toJson();

      print("sadsadasdasdasd $body");
      var resp = await http.post(
        Uri.parse(API_CREATE_STS),
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

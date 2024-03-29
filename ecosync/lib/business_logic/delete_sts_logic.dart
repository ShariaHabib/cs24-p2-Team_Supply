import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class DeleteSTSLogic {
  static Future<RegistGeneralResponse> deleteSTS(
      String token, String wardNo) async {
    late RegistGeneralResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      print(token);
      http.Response resp = await http.delete(
        Uri.parse(API_DELETE_STS + wardNo),
        headers: headers,
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

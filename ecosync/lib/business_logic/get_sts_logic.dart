import 'package:ecosync/models/get_sts_response_model.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';

class GetSTSlogic {
  static Future<GetSTSResponse> getSTS(String token) async {
    late GetSTSResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      http.Response resp = await http.get(
        Uri.parse(API_GET_STS),
        headers: headers,
      );
      print(resp.body);
      data = GetSTSResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = GetSTSResponse(stsList: [], success: false);
    }
    return data;
  }
}

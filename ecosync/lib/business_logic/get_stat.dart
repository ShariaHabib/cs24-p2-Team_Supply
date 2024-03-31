import 'package:ecosync/models/get_sts_response_model.dart';
import 'package:ecosync/models/stats_model.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';

class GetStat {
  static Future<StatModel> getStat(String token) async {
    late StatModel data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      http.Response resp = await http.get(
        Uri.parse(API_GET_STAT),
        headers: headers,
      );
      print(resp.body);
      data = StatModel.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = StatModel(
          success: false,
          weekly_bills: 0,
          monthly_bills: 0,
          daily_bills: 0,
          total_waste_collected: 0,
          total_waste_disposed: 0);
    }
    return data;
  }
}

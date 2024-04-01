import 'dart:convert';

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
      data = StatModel.fromJson(json.decode(resp.body));
    } catch (e) {
      data = StatModel(
          success: false,
          weeklyBills: 0,
          monthlyBills: 0,
          dailyBills: 0,
          totalWasteCollected: 0,
          totalWasteDisposed: 0,
          stsWasteCollected: []);
    }
    return data;
  }
}

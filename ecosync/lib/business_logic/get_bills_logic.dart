import 'package:ecosync/models/billings_list_model.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';

class GetBillsLogic {
  static Future<BillingListResponse> getBill(String token) async {
    late BillingListResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      http.Response resp = await http.get(
        Uri.parse(API_WASTE_DISPOSAL_SLIP),
        headers: headers,
      );
      print(resp.body);
      data = BillingListResponse.fromJson(resp.body);
      print(data);
    } catch (e) {
      print(e);
      data =
          BillingListResponse(billingSlipList: [], success: false, message: "");
    }
    return data;
  }
}

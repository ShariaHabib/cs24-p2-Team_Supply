import 'package:ecosync/models/waste_dispose_response_model.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class GetWasteDisposeListLogic {
  static Future<WasteDisposeResponse> getWasteDisposeList(String token) async {
    late WasteDisposeResponse data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      http.Response resp = await http.get(
        Uri.parse(API_WASTE_DISPOSE),
        headers: headers,
      );
      print(resp.body);
      data = WasteDisposeResponse.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = WasteDisposeResponse(landfillEntryList: [], success: false);
    }
    return data;
  }
}

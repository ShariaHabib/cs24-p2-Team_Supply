import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/waste_collection_response_model.dart';

class WasteCollectionLogic {
  static Future<WasteCollectionResponseModel> getWasteCollection(
      String token) async {
    late WasteCollectionResponseModel data;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": "true",
        'Authorization': token
      };
      http.Response resp = await http.get(
        Uri.parse(API_GET_WASTE_COLLECTION),
        headers: headers,
      );
      print(API_GET_WASTE_COLLECTION);
      data = WasteCollectionResponseModel.fromJson(resp.body);
    } catch (e) {
      print(e);
      data = WasteCollectionResponseModel(
          stsScheduleList: [], success: false, message: e.toString());
    }
    return data;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

const String baseUrl =
    'https://api.openrouteservice.org/v2/directions/driving-car';
const String apiKey =
    '5b3ce3597851110001cf62489845da5a6daf45d79f14250248a47bda';

getRouteUrl(String startPoint, String endPoint) {
  return Uri.parse('$baseUrl?api_key=$apiKey&start=$startPoint&end=$endPoint');
}

class MapInit extends ChangeNotifier {
  List listOfPoints = [];

  List<LatLng> points = [];

  Map<String, dynamic> summary = {};

  bool loading = false;
  getMap() async {
    loading = true;
    var response = await http.get(getRouteUrl(
        "90.4154939718578, 23.802413983791226",
        '90.40856646565196, 23.79326586279359'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      summary = data['features'][0]['properties']['summary'];
      listOfPoints = data['features'][0]['geometry']['coordinates'];

      points = listOfPoints
          .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
          .toList();
    }
    loading = false;
    notifyListeners();
  }
}

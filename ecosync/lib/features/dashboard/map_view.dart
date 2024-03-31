import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    getCoordinates();
    super.initState();
  }

  List listOfPoints = [];

  List<LatLng> points = [];

  Map<String, dynamic> summary = {};

  getCoordinates() async {
    var response = await http.get(getRouteUrl(
        "1.243344,6.145332", '1.2160116523406839,6.125231015668568'));
    setState(() {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // summary = data['features'][0]['properties']['summary'];
        summary = data['features'][0]['properties']['summary'];
        listOfPoints = data['features'][0]['geometry']['coordinates'];

        points = listOfPoints
            .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 500,
        height: 500,
        child: FlutterMap(
          options: MapOptions(zoom: 15, center: LatLng(6.131015, 1.223898)),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: const LatLng(6.145332, 1.243344),
                  width: 80,
                  height: 80,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.location_on),
                    color: Colors.green,
                    iconSize: 45,
                  ),
                ),
                Marker(
                  point: const LatLng(6.125231015668568, 1.2160116523406839),
                  width: 80,
                  height: 80,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.location_on),
                    color: Colors.red,
                    iconSize: 45,
                  ),
                ),
              ],
            ),
            Tooltip(
              message: "Distance ${summary['distance']}",
              child: PolylineLayer(
                polylineCulling: false,
                polylines: [
                  Polyline(
                    points: points,
                    color: Colors.green,
                    strokeWidth: 15,
                    isDotted: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

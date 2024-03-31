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
        "90.4154939718578, 23.802413983791226",
        '90.40856646565196, 23.79326586279359'));

    setState(() {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
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
      body: SizedBox(
        width: 300,
        height: 300,
        child: FlutterMap(
          options: const MapOptions(
              initialZoom: 15,
              initialCenter: LatLng(23.802413983791226, 90.4154939718578)),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: const LatLng(23.802413983791226, 90.4154939718578),
                  width: 80,
                  height: 80,
                  child: Tooltip(
                    message: "Landfill",
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.location_on),
                      color: Colors.yellow,
                      iconSize: 45,
                    ),
                  ),
                ),
                Marker(
                  point: const LatLng(23.79326586279359, 90.40856646565196),
                  width: 80,
                  height: 80,
                  child: Tooltip(
                    message: "STS",
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.location_on),
                      color: Colors.red,
                      iconSize: 45,
                    ),
                  ),
                ),
              ],
            ),
            Tooltip(
              message: "Distance ${summary['distance'] / 1000}",
              child: PolylineLayer(
                polylineCulling: false,
                polylines: [
                  Polyline(
                    points: points,
                    color: Colors.green,
                    strokeWidth: 10,
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

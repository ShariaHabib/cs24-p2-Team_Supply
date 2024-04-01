import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import 'api.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    context.read<MapInit>().getMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ctr = context.watch<MapInit>();
    return Scaffold(
      body: ctr.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FlutterMap(
              options: const MapOptions(
                  initialZoom: 14,
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
                  message: "Distance ${ctr.summary['distance'] / 1000}",
                  child: PolylineLayer(
                    polylineCulling: false,
                    polylines: [
                      Polyline(
                        points: ctr.points,
                        color: Colors.green,
                        strokeWidth: 10,
                        isDotted: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

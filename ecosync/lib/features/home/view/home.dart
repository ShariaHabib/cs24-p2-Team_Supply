import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:unique_simple_bar_chart/data_models.dart';
import 'package:unique_simple_bar_chart/simple_bar_chart.dart';
import '../../../common/profile_card.dart';
import '../../../constants/constants.dart';
import '../../dashboard/map_view.dart';
import '../controller/stat_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.userName});
  final String userName;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<StatController>().getStat(context);
    super.initState();
  }

  Color generateRandomColor() {
    final random = Random();
    final r = random.nextInt(256);
    final g = random.nextInt(256);
    final b = random.nextInt(256);
    return Color.fromRGBO(r, g, b, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    StatController ctr = context.watch<StatController>();
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileCard(userName: widget.userName),
            const SizedBox(
              height: 50,
            ),
            const Text("STS Insights", style: TextStyle(fontSize: 20)),
            ctr.loading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    child: SimpleBarChart(
                        verticalInterval: 150,
                        horizontalBarPadding: 10,
                        listOfHorizontalBarData: List.generate(
                          ctr.data.stsWasteCollected?.length ?? 0,
                          (index) => HorizontalDetailsModel(
                              name: ctr.data.stsWasteCollected![index].stsId
                                  .toString(),
                              color: generateRandomColor(),
                              size: ctr.data.stsWasteCollected?[index]
                                      .totalVolumeCollected
                                      ?.toDouble() ??
                                  0),
                        )),
                  ),
            const SizedBox(height: kDefaultPadding * 2),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const Text("Waste Details",
                          style: TextStyle(fontSize: 20)),
                      ctr.loading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: SimpleBarChart(
                                  verticalInterval: 300,
                                  horizontalBarPadding: 2,
                                  listOfHorizontalBarData: [
                                    HorizontalDetailsModel(
                                        color: Colors.blue,
                                        name: "Total Waste Collected",
                                        size: ctr.data.totalWasteCollected
                                                ?.toDouble() ??
                                            0),
                                    HorizontalDetailsModel(
                                        color: Colors.green,
                                        name: "Total Waste Disposed",
                                        size: ctr.data.totalWasteDisposed
                                                ?.toDouble() ??
                                            0),
                                  ]),
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: kDefaultPadding,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const Text("Bills", style: TextStyle(fontSize: 20)),
                      ctr.loading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: SimpleBarChart(
                                  verticalInterval: 50000,
                                  horizontalBarPadding: 10,
                                  listOfHorizontalBarData: [
                                    HorizontalDetailsModel(
                                        color: Colors.green,
                                        name: "Total Waste Disposed",
                                        size: ctr.data.dailyBills!.toDouble() /
                                                30.0 ??
                                            0),
                                    HorizontalDetailsModel(
                                        color: Colors.green,
                                        name: "Total Waste Disposed",
                                        size: ctr.data.weeklyBills!.toDouble() /
                                                7.0 ??
                                            0),
                                    HorizontalDetailsModel(
                                        color: Colors.green,
                                        name: "Total Waste Disposed",
                                        size:
                                            ctr.data.monthlyBills?.toDouble() ??
                                                0),
                                  ]),
                            ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: kDefaultPadding * 2),
            const Text(
              "STS and Landfill Location",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 500,
              width: 500,
              child: FlutterMap(
                options: const MapOptions(
                    initialZoom: 10,
                    initialCenter:
                        LatLng(23.71971928311676, 90.33155643793262)),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point:
                            const LatLng(23.802413983791226, 90.4154939718578),
                        width: 80,
                        height: 80,
                        child: Tooltip(
                          message: "STS",
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.location_on),
                            color: Colors.yellow,
                            iconSize: 45,
                          ),
                        ),
                      ),
                      Marker(
                        point:
                            const LatLng(23.79326586279359, 90.40856646565196),
                        width: 80,
                        height: 80,
                        child: Tooltip(
                          message: "Landfill",
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.location_on),
                            color: Colors.red,
                            iconSize: 45,
                          ),
                        ),
                      ),
                      Marker(
                        point:
                            const LatLng(23.73094858219429, 90.21582426948251),
                        width: 80,
                        height: 80,
                        child: Tooltip(
                          message: "STS",
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.location_on),
                            color: Colors.yellow,
                            iconSize: 45,
                          ),
                        ),
                      ),
                      Marker(
                        point:
                            const LatLng(23.778187752651117, 90.2672891016997),
                        width: 80,
                        height: 80,
                        child: Tooltip(
                          message: "STS",
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.location_on),
                            color: Colors.yellow,
                            iconSize: 45,
                          ),
                        ),
                      ),
                      Marker(
                        point:
                            const LatLng(23.774203389355918, 90.27769312515073),
                        width: 80,
                        height: 80,
                        child: Tooltip(
                          message: "STS",
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.location_on),
                            color: Colors.yellow,
                            iconSize: 45,
                          ),
                        ),
                      ),
                      Marker(
                        point:
                            const LatLng(23.74922899115044, 90.32665577451074),
                        width: 80,
                        height: 80,
                        child: Tooltip(
                          message: "STS",
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.location_on),
                            color: Colors.yellow,
                            iconSize: 45,
                          ),
                        ),
                      ),
                      Marker(
                        point:
                            const LatLng(23.713175541013467, 90.27928401190388),
                        width: 80,
                        height: 80,
                        child: Tooltip(
                          message: "STS",
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.location_on),
                            color: Colors.yellow,
                            iconSize: 45,
                          ),
                        ),
                      ),
                      Marker(
                        point:
                            const LatLng(23.650175744297243, 90.35179194066093),
                        width: 80,
                        height: 80,
                        child: Tooltip(
                          message: "STS",
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.location_on),
                            color: Colors.yellow,
                            iconSize: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: kDefaultPadding * 2),
          ],
        ),
      ),
    );
  }
}

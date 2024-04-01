import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unique_simple_bar_chart/data_models.dart';
import 'package:unique_simple_bar_chart/simple_bar_chart.dart';
import '../../../common/profile_card.dart';
import '../../../constants/constants.dart';
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
            ctr.loading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: 200,
                    child: SimpleBarChart(
                        verticalInterval: 100,
                        horizontalBarPadding: 0,
                        listOfHorizontalBarData: List.generate(
                          ctr.data.sts_waste_collected.length,
                          (index) => HorizontalDetailsModel(
                            name: ctr.data.sts_waste_collected[index].sts_id
                                .toString(),
                            color: generateRandomColor(),
                            size: ctr.data.sts_waste_collected[index]
                                .total_volume_collected
                                .toDouble(),
                          ),
                        )),
                  ),
            // Container(height: 500, width: 500, child: const MapScreen()),
          ],
        ),
      ),
    );
  }
}

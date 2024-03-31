import 'package:ecosync/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/profile_card.dart';
import '../../../constants/constants.dart';
import '../../dashboard/map_view.dart';
import '../controller/sts_vehicle_controller.dart';
import '../widget/table.dart';

class STSVehicle extends StatefulWidget {
  const STSVehicle({super.key, required this.userName});
  final String userName;
  @override
  State<STSVehicle> createState() => _STSVehicleState();
}

class _STSVehicleState extends State<STSVehicle> {
  final TextEditingController _search = TextEditingController();
  @override
  void initState() {
    context.read<STSVehicleController>().getData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    STSVehicleController ctr = context.watch<STSVehicleController>();
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        // padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          children: [
            ProfileCard(userName: widget.userName),
            const SizedBox(height: kDefaultPadding),
            Row(
              children: [
                SizedBox(
                    width: 400,
                    child: ctr.loading
                        ? const Center(child: CircularProgressIndicator())
                        : STSVehicleView(search: _search, vehicles: ctr.data)),
                Container(height: 300, width: 300, child: const MapScreen()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

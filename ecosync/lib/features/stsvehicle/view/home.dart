import 'package:flutter/material.dart';

import '../../../common/profile_card.dart';
import '../../../constants/constants.dart';
import '../../dashboard/map_view.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          children: [
            ProfileCard(userName: widget.userName),
            Row(
              children: [
                STSVehicleView(search: _search, vehicles: []),
                Container(height: 300, width: 300, child: const MapScreen()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

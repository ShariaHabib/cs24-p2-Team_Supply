import 'package:ecosync/business_logic/business_logic.dart';
import 'package:ecosync/features/manage_vehicles/controller/vehicle_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';
import '../../../common/profile_card.dart';
import '../../../constants/constants.dart';
import '../widget/widgets.dart';

class ManageVehicles extends StatefulWidget {
  const ManageVehicles({super.key, required this.userName});
  final String userName;

  @override
  State<ManageVehicles> createState() => _ManageVehiclesState();
}

class _ManageVehiclesState extends State<ManageVehicles> {
  final TextEditingController _search = TextEditingController();
  @override
  void initState() {
    context.read<GetVehiclesController>().getData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GetVehiclesController ctr = context.watch<GetVehiclesController>();
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(userName: widget.userName),
            const BodyTitle(),
            const SizedBox(height: kDefaultPadding * 2),
            SearchBox(search: _search),
            const SizedBox(height: kDefaultPadding),
            CustomAddButton(onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const CustomDialog();
                  });
            }),
            const SizedBox(height: kDefaultPadding),
            ctr.loading
                ? const Center(child: CircularProgressIndicator())
                : UserTableView(
                    vehicles: context.watch<GetVehiclesController>().data,
                    search: _search,
                  )
          ],
        ),
      ),
    );
  }
}

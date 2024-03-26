import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features.dart';
import '../controller/menu_controller.dart';
import '../widgets/widgets.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: SideMenu(),
            ),
            Expanded(
              flex: 4,
              child: IndexedStack(
                index: context.watch<MenuAppController>().currentSelection,
                children: const [
                  Home(),
                  ManageUsers(),
                  ManageRoles(),
                  ManageVehicles(),
                  ManageSTS(),
                  WasteCollection(),
                  WasteDispose()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

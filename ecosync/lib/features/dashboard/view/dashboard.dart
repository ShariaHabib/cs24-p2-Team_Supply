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
              child: Builder(
                builder: (context) {
                  final currentSelection =
                      context.watch<MenuAppController>().currentSelection;

                  // Render different widgets based on current selection
                  Widget selectedWidget;
                  switch (currentSelection) {
                    case 0:
                      selectedWidget = const Home();
                      break;
                    case 1:
                      selectedWidget = const ManageUsers();
                      break;
                    case 2:
                      selectedWidget = const ManageRoles();
                      break;
                    case 3:
                      selectedWidget = const ManageVehicles();
                      break;
                    case 4:
                      selectedWidget = const ManageSTS();
                      break;
                    case 5:
                      selectedWidget = const WasteCollection();
                      break;
                    case 6:
                      selectedWidget = const WasteDispose();
                      break;
                    case 8:
                      selectedWidget = const UserProfile();
                      break;
                    default:
                      selectedWidget = Container(); // or any default widget
                      break;
                  }

                  return selectedWidget;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:ecosync/features/billings/view/billings.dart';
import 'package:ecosync/features/stsvehicle/view/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/profile_card.dart';
import '../../features.dart';
import '../../profile/view/user_profile.dart';
import '../controller/menu_controller.dart';
import '../widgets/widgets.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key, required this.roleId, required this.userName});
  final int roleId;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(roleId: roleId),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SideMenu(
                roleId: roleId,
              ),
            ),
            Expanded(
              flex: 4,
              child: Builder(
                builder: (context) {
                  int currentSelection =
                      context.watch<MenuAppController>().currentSelection;
                  if (roleId == 2 && currentSelection == 0) {
                    currentSelection = 9;
                  }
                  if (roleId == 3 && currentSelection == 0) {
                    currentSelection = 6;
                  }
                  Widget selectedWidget;
                  switch (currentSelection) {
                    case 0:
                      selectedWidget = Home(
                        userName: userName,
                      );
                      break;
                    case 1:
                      selectedWidget = ManageUsers(
                        userName: userName,
                      );
                      break;
                    case 2:
                      selectedWidget = ManageRoles(
                        userName: userName,
                      );
                      break;
                    case 3:
                      selectedWidget = ManageVehicles(
                        userName: userName,
                      );
                      break;
                    case 4:
                      selectedWidget = ManageSTS(
                        userName: userName,
                      );
                      break;
                    case 5:
                      selectedWidget = WasteCollection(
                        userName: userName,
                      );
                      break;
                    case 6:
                      selectedWidget = WasteDispose(
                        userName: userName,
                      );
                      break;
                    case 7:
                      selectedWidget = Billings(
                        userName: userName,
                      );
                      break;
                    case 8:
                      selectedWidget = const UserProfile();
                      break;
                    case 9:
                      selectedWidget = STSVehicle(
                        userName: userName,
                      );
                      break;
                    default:
                      selectedWidget = Container();
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

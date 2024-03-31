import 'package:ecosync/features/billings/controller/get_bills_controller.dart';
import 'package:ecosync/features/manage_roles/controller/delete_rbac_roles_controller.dart';
import 'package:ecosync/features/manage_roles/controller/rbac_roles_controller.dart';
import 'package:ecosync/features/manage_sts/controller/create_sts_controller.dart';
import 'package:ecosync/features/manage_sts/controller/delete_sts_controller.dart';
import 'package:ecosync/features/manage_sts/controller/get_sts_controller.dart';
import 'package:ecosync/features/manage_sts/controller/update_sts_controller.dart';
import 'package:ecosync/features/manage_users/controller/update_user_controller.dart';
import 'package:ecosync/features/manage_vehicles/controller/vehicle_controller.dart';
import 'package:ecosync/features/dashboard/controller/logout_controller.dart';
import 'package:ecosync/features/waste_dispose/controller/get_waste_dispose_controller.dart';
import 'package:ecosync/features/waste_dispose/controller/regist_waste_dispose_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'features/dashboard/controller/menu_controller.dart';
import 'features/dashboard/map_view.dart';
import 'features/dashboard/view/dashboard.dart';
import 'features/login/controller/login_controller.dart';
import 'features/login/controller/login_data_store.dart';
import 'features/login/view/login.dart';
import 'features/manage_roles/controller/get_permission_by_role.dart';
import 'features/manage_roles/controller/get_permission_controller.dart';
import 'features/manage_sts/controller/get_user_by_role_controller.dart';
import 'features/manage_users/controller/controller.dart';
import 'features/manage_vehicles/controller/delete_vehicle_controller.dart';
import 'features/manage_vehicles/controller/regist_vehicle.dart';
import 'features/profile/controller/get_user_profile_controller.dart';
import 'features/stsvehicle/controller/sts_vehicle_controller.dart';
import 'features/waste_collection/controller/regist_waste_collection_controller.dart';
import 'features/waste_collection/controller/waste_collection_controller.dart';
import 'themes/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuAppController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginController(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetUsersController(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetRolesController(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegistUserController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DeleteUserController(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegistVehicleController(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetVehiclesController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DeleteVehicleController(),
        ),
        ChangeNotifierProvider(
          create: (context) => RoleUpdateController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LogoutController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UpdateUsersController(),
        ),
        ChangeNotifierProvider(
          create: (context) => RbacRoleController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DeleteRbacController(),
        ),
        ChangeNotifierProvider(
          create: (context) => PermissionController(),
        ),
        ChangeNotifierProvider(
          create: (context) => PermissionByRoleController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProfileController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DeleteSTSController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UpdateSTSController(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetSTScontroller(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegistSTSController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginDataSave(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetUsersByRoleController(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetWaasteDisposeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegistWasteDisposeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => WasteCollectionController(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegistWasteCollectionController(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetBillsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => STSVehicleController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  Future<Map<String, dynamic>?> getall() async {
    late Map<String, dynamic> data;
    String? x = await const FlutterSecureStorage().read(key: 'token');
    String? y = await const FlutterSecureStorage().read(key: 'role_id');
    String? z = await const FlutterSecureStorage().read(key: 'user_name');

    if (x != null && y != null && z != null) {
      data = {"token": x, "role_id": int.parse(y), "user_name": z};
      return data;
    } else {
      return null;
    }
  }

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF92D1C3)),
        useMaterial3: true,
        drawerTheme: drawerTheme,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      home: FutureBuilder(
        future: getall(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.hasData && snapshot.data != null
                ? Dashboard(
                    roleId: snapshot.data!['role_id'] ?? '',
                    userName: snapshot.data!['user_name'] ?? '',
                  )
                : const Login();
          } else {
            return const LinearProgressIndicator();
          }
        },
      ),
    );
  }
}

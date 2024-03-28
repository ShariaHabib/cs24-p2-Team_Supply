import 'package:ecosync/features/manage_users/controller/update_user_controller.dart';
import 'package:ecosync/features/manage_vehicles/controller/vehicle_controller.dart';
import 'package:ecosync/features/dashboard/controller/logout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'features/dashboard/controller/menu_controller.dart';
import 'features/dashboard/view/dashboard.dart';
import 'features/login/controller/login_controller.dart';
import 'features/login/view/login.dart';
import 'features/manage_users/controller/controller.dart';
import 'features/manage_vehicles/controller/delete_vehicle_controller.dart';
import 'features/manage_vehicles/controller/regist_vehicle.dart';
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
      ],
      child: const MyApp(),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
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
        future: const FlutterSecureStorage().read(key: 'token'),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.hasData && snapshot.data != null
                ? const Dashboard()
                : const Login();
          } else {
            return const LinearProgressIndicator();
          }
        },
      ),
    );
  }
}

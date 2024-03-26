import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/dashboard/controller/menu_controller.dart';
import 'features/dashboard/view/dashboard.dart';
import 'features/login/view/login.dart';
import 'themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF92D1C3)),
        useMaterial3: true,
        drawerTheme: drawerTheme,
      ),
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
        child: const Dashboard(),
      ),
    );
  }
}

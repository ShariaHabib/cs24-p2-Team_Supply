import 'package:ecosync/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../../business_logic/business_logic.dart';
import '../../../models/models.dart';
import 'login_data_store.dart';

class LoginController with ChangeNotifier {
  late LoginResponse data;
  late bool success;

  bool loading = false;

  getPostData(email, password, context) async {
    loading = true;
    notifyListeners();
    data = await LoginLogic.login(email, password);
    success = data.success;
    if (data.token.isNotEmpty) {
      await const FlutterSecureStorage().write(key: 'token', value: data.token);
      Provider.of<LoginDataSave>(context, listen: false).setData(data.userInfo);
    }
    Timer(
      const Duration(minutes: 20),
      () async {
        await const FlutterSecureStorage().deleteAll();
        showDialog(
          barrierDismissible: false,
          context: navigatorKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              icon: const Icon(
                Icons.warning_rounded,
                color: Colors.red,
                size: 50,
              ),
              title: const Text("Session has expired!"),
              content: const Text(
                "Please login again to continue access!",
                textAlign: TextAlign.center,
              ),
              actions: [
                FilledButton(
                    onPressed: () {
                      Navigator.popUntil(context,
                          ModalRoute.withName(Navigator.defaultRouteName));
                    },
                    child: const Text("Okay")),
              ],
            );
          },
        );
      },
    );
    loading = false;
    notifyListeners();
  }
}

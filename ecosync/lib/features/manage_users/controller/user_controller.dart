import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../business_logic/business_logic.dart';
import '../../../models/models.dart';

class GetUsersController with ChangeNotifier {
  late List<User> data;

  bool loading = false;

  getData(context) async {
    loading = true;
    String? token = await const FlutterSecureStorage().read(key: 'token');
    data = await GetUserLogic.getUser(token ?? '').then((value) => value.userList);
    loading = false;
    notifyListeners();
  }
}

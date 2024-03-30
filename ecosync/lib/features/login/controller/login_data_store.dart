import 'package:ecosync/models/models.dart';
import 'package:flutter/material.dart';

class LoginDataSave with ChangeNotifier {
  loginUser data = loginUser(role_id: 4, user_id: '', user_name: '');

  setData(loginUser updata) {
    data = updata;
    notifyListeners();
  }

  loginUser get getData => data;
}

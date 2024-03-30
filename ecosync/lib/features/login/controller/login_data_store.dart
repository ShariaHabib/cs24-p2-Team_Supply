import 'package:ecosync/models/models.dart';
import 'package:flutter/material.dart';

class LoginDataSave with ChangeNotifier {
  late loginUser data;

  setData(loginUser updata) {
    data = updata;
    notifyListeners();
  }

  loginUser get getData => data;
}

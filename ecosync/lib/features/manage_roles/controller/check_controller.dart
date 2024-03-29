import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../business_logic/business_logic.dart';
import '../../../models/models.dart';

class CheckController with ChangeNotifier {
  late List<bool> checked;

  List<bool> get getchecked => checked;

  setChecked(List<bool> che) {
    checked = che;
    notifyListeners();
  }
}

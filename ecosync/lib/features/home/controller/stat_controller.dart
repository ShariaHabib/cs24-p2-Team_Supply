import 'package:ecosync/business_logic/get_stat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../models/stats_model.dart';

class StatController with ChangeNotifier {
  late StatModel data;
  // late bool success;

  bool loading = false;

  getStat(context) async {
    loading = true;
    String? token = await const FlutterSecureStorage().read(key: 'token');
    data = await GetStat.getStat(token ?? '');
    // success = data.success;
    print(data.sts_waste_collected);
    loading = false;
    notifyListeners();
  }
}

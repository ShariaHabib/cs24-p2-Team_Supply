import 'package:ecosync/business_logic/get_bills_logic.dart';
import 'package:ecosync/models/billings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetBillsController with ChangeNotifier {
  List<BillingsModel> data = [];

  bool loading = false;
  getData(context) async {
    loading = true;
    String? token = await const FlutterSecureStorage().read(key: 'token');
    List<BillingsModel> out = await GetBillsLogic.getBill(token ?? '')
        .then((value) => value.billingSlipList);
    data = out;
    loading = false;
    notifyListeners();
  }
}

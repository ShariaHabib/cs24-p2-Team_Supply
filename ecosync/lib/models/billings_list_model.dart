import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ecosync/models/billings_model.dart';

class BillingListResponse {
  final bool success;
  final String? message;
  final List<BillingsModel> billingSlipList;
  BillingListResponse({
    required this.success,
    this.message,
    required this.billingSlipList,
  });

  BillingListResponse copyWith({
    bool? success,
    String? message,
    List<BillingsModel>? billingSlipList,
  }) {
    return BillingListResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      billingSlipList: billingSlipList ?? this.billingSlipList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'billingSlipList': billingSlipList.map((x) => x.toMap()).toList(),
    };
  }

  factory BillingListResponse.fromMap(Map<String, dynamic> map) {
    return BillingListResponse(
      success: map['success'] as bool,
      message: map['message'] != null ? map['message'] as String : null,
      billingSlipList: List<BillingsModel>.from(
        (map['billingSlipList'] as List<dynamic>).map<BillingsModel>(
          (x) => BillingsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory BillingListResponse.fromJson(String source) =>
      BillingListResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BillingListResponse(success: $success, message: $message, billingSlipList: $billingSlipList)';

  @override
  bool operator ==(covariant BillingListResponse other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        other.message == message &&
        listEquals(other.billingSlipList, billingSlipList);
  }

  @override
  int get hashCode =>
      success.hashCode ^ message.hashCode ^ billingSlipList.hashCode;
}

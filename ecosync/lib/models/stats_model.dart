// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class StatModel {
  bool success;
  final int? weekly_bills;
  final int? monthly_bills;
  final int? daily_bills;
  final int? total_waste_collected;
  final int? total_waste_disposed;
  final List<WasteCollected> sts_waste_collected;
  StatModel({
    required this.success,
    this.weekly_bills,
    this.monthly_bills,
    this.daily_bills,
    this.total_waste_collected,
    this.total_waste_disposed,
    required this.sts_waste_collected,
  });

  StatModel copyWith({
    bool? success,
    int? weekly_bills,
    int? monthly_bills,
    int? daily_bills,
    int? total_waste_collected,
    int? total_waste_disposed,
    List<WasteCollected>? sts_waste_collected,
  }) {
    return StatModel(
      success: success ?? this.success,
      weekly_bills: weekly_bills ?? this.weekly_bills,
      monthly_bills: monthly_bills ?? this.monthly_bills,
      daily_bills: daily_bills ?? this.daily_bills,
      total_waste_collected:
          total_waste_collected ?? this.total_waste_collected,
      total_waste_disposed: total_waste_disposed ?? this.total_waste_disposed,
      sts_waste_collected: sts_waste_collected ?? this.sts_waste_collected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'weekly_bills': weekly_bills,
      'monthly_bills': monthly_bills,
      'daily_bills': daily_bills,
      'total_waste_collected': total_waste_collected,
      'total_waste_disposed': total_waste_disposed,
      'sts_waste_collected': sts_waste_collected.map((x) => x.toMap()).toList(),
    };
  }

  factory StatModel.fromMap(Map<String, dynamic> map) {
    return StatModel(
      success: map['success'] as bool,
      weekly_bills:
          map['weekly_bills'] != null ? map['weekly_bills'] as int : null,
      monthly_bills:
          map['monthly_bills'] != null ? map['monthly_bills'] as int : null,
      daily_bills:
          map['daily_bills'] != null ? map['daily_bills'] as int : null,
      total_waste_collected: map['total_waste_collected'] != null
          ? map['total_waste_collected'] as int
          : null,
      total_waste_disposed: map['total_waste_disposed'] != null
          ? map['total_waste_disposed'] as int
          : null,
      sts_waste_collected: List<WasteCollected>.from(
        (map['sts_waste_collected'] as List<int>).map<WasteCollected>(
          (x) => WasteCollected.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory StatModel.fromJson(String source) =>
      StatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StatModel(success: $success, weekly_bills: $weekly_bills, monthly_bills: $monthly_bills, daily_bills: $daily_bills, total_waste_collected: $total_waste_collected, total_waste_disposed: $total_waste_disposed, sts_waste_collected: $sts_waste_collected)';
  }

  @override
  bool operator ==(covariant StatModel other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        other.weekly_bills == weekly_bills &&
        other.monthly_bills == monthly_bills &&
        other.daily_bills == daily_bills &&
        other.total_waste_collected == total_waste_collected &&
        other.total_waste_disposed == total_waste_disposed &&
        listEquals(other.sts_waste_collected, sts_waste_collected);
  }

  @override
  int get hashCode {
    return success.hashCode ^
        weekly_bills.hashCode ^
        monthly_bills.hashCode ^
        daily_bills.hashCode ^
        total_waste_collected.hashCode ^
        total_waste_disposed.hashCode ^
        sts_waste_collected.hashCode;
  }
}

class WasteCollected {
  final int sts_id;
  final int total_volume_collected;
  WasteCollected({
    required this.sts_id,
    required this.total_volume_collected,
  });

  WasteCollected copyWith({
    int? sts_id,
    int? total_volume_collected,
  }) {
    return WasteCollected(
      sts_id: sts_id ?? this.sts_id,
      total_volume_collected:
          total_volume_collected ?? this.total_volume_collected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sts_id': sts_id,
      'total_volume_collected': total_volume_collected,
    };
  }

  factory WasteCollected.fromMap(Map<String, dynamic> map) {
    return WasteCollected(
      sts_id: map['sts_id'] as int,
      total_volume_collected: map['total_volume_collected'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WasteCollected.fromJson(String source) =>
      WasteCollected.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WasteCollected(sts_id: $sts_id, total_volume_collected: $total_volume_collected)';

  @override
  bool operator ==(covariant WasteCollected other) {
    if (identical(this, other)) return true;

    return other.sts_id == sts_id &&
        other.total_volume_collected == total_volume_collected;
  }

  @override
  int get hashCode => sts_id.hashCode ^ total_volume_collected.hashCode;
}

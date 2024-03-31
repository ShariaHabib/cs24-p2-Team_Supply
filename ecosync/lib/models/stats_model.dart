import 'dart:convert';

class StatModel {
  bool success;
  final int? weekly_bills;
  final int? monthly_bills;
  final int? daily_bills;
  final int? total_waste_collected;
  final int? total_waste_disposed;
  StatModel({
    required this.success,
    this.weekly_bills,
    this.monthly_bills,
    this.daily_bills,
    this.total_waste_collected,
    this.total_waste_disposed,
  });

  StatModel copyWith({
    bool? success,
    int? weekly_bills,
    int? monthly_bills,
    int? daily_bills,
    int? total_waste_collected,
    int? total_waste_disposed,
  }) {
    return StatModel(
      success: success ?? this.success,
      weekly_bills: weekly_bills ?? this.weekly_bills,
      monthly_bills: monthly_bills ?? this.monthly_bills,
      daily_bills: daily_bills ?? this.daily_bills,
      total_waste_collected:
          total_waste_collected ?? this.total_waste_collected,
      total_waste_disposed: total_waste_disposed ?? this.total_waste_disposed,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory StatModel.fromJson(String source) =>
      StatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StatModel(success: $success, weekly_bills: $weekly_bills, monthly_bills: $monthly_bills, daily_bills: $daily_bills, total_waste_collected: $total_waste_collected, total_waste_disposed: $total_waste_disposed)';
  }

  @override
  bool operator ==(covariant StatModel other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        other.weekly_bills == weekly_bills &&
        other.monthly_bills == monthly_bills &&
        other.daily_bills == daily_bills &&
        other.total_waste_collected == total_waste_collected &&
        other.total_waste_disposed == total_waste_disposed;
  }

  @override
  int get hashCode {
    return success.hashCode ^
        weekly_bills.hashCode ^
        monthly_bills.hashCode ^
        daily_bills.hashCode ^
        total_waste_collected.hashCode ^
        total_waste_disposed.hashCode;
  }
}

import 'dart:convert';

class BillingsModel {
  final int billing_slip_id;
  final int landfill_entry_id;
  final int weight_of_waste;
  final double fuel_cost;
  final String generated_timestamp;
  BillingsModel({
    required this.billing_slip_id,
    required this.landfill_entry_id,
    required this.weight_of_waste,
    required this.fuel_cost,
    required this.generated_timestamp,
  });

  BillingsModel copyWith({
    int? billing_slip_id,
    int? landfill_entry_id,
    int? weight_of_waste,
    double? fuel_cost,
    String? generated_timestamp,
  }) {
    return BillingsModel(
      billing_slip_id: billing_slip_id ?? this.billing_slip_id,
      landfill_entry_id: landfill_entry_id ?? this.landfill_entry_id,
      weight_of_waste: weight_of_waste ?? this.weight_of_waste,
      fuel_cost: fuel_cost ?? this.fuel_cost,
      generated_timestamp: generated_timestamp ?? this.generated_timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'billing_slip_id': billing_slip_id,
      'landfill_entry_id': landfill_entry_id,
      'weight_of_waste': weight_of_waste,
      'fuel_cost': fuel_cost,
      'generated_timestamp': generated_timestamp,
    };
  }

  factory BillingsModel.fromMap(Map<String, dynamic> map) {
    return BillingsModel(
      billing_slip_id: map['billing_slip_id'] as int,
      landfill_entry_id: map['landfill_entry_id'] as int,
      weight_of_waste: map['weight_of_waste'] as int,
      fuel_cost: map['fuel_cost'] as double,
      generated_timestamp: map['generated_timestamp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BillingsModel.fromJson(String source) =>
      BillingsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BillingsModel(billing_slip_id: $billing_slip_id, landfill_entry_id: $landfill_entry_id, weight_of_waste: $weight_of_waste, fuel_cost: $fuel_cost, generated_timestamp: $generated_timestamp)';
  }

  @override
  bool operator ==(covariant BillingsModel other) {
    if (identical(this, other)) return true;

    return other.billing_slip_id == billing_slip_id &&
        other.landfill_entry_id == landfill_entry_id &&
        other.weight_of_waste == weight_of_waste &&
        other.fuel_cost == fuel_cost &&
        other.generated_timestamp == generated_timestamp;
  }

  @override
  int get hashCode {
    return billing_slip_id.hashCode ^
        landfill_entry_id.hashCode ^
        weight_of_waste.hashCode ^
        fuel_cost.hashCode ^
        generated_timestamp.hashCode;
  }
}

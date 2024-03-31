// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Vehicle {
  final String vehicle_number;
  final String vehicle_type;
  final int capacity;
  final int fuel_cost_loaded;
  final int fuel_cost_unloaded;
  final int sts_id;
  Vehicle({
    required this.vehicle_number,
    required this.vehicle_type,
    required this.capacity,
    required this.fuel_cost_loaded,
    required this.fuel_cost_unloaded,
    required this.sts_id,
  });

  Vehicle copyWith({
    String? vehicle_number,
    String? vehicle_type,
    int? capacity,
    int? fuel_cost_loaded,
    int? fuel_cost_unloaded,
    int? sts_id,
  }) {
    return Vehicle(
      vehicle_number: vehicle_number ?? this.vehicle_number,
      vehicle_type: vehicle_type ?? this.vehicle_type,
      capacity: capacity ?? this.capacity,
      fuel_cost_loaded: fuel_cost_loaded ?? this.fuel_cost_loaded,
      fuel_cost_unloaded: fuel_cost_unloaded ?? this.fuel_cost_unloaded,
      sts_id: sts_id ?? this.sts_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vehicle_number': vehicle_number,
      'vehicle_type': vehicle_type,
      'capacity': capacity,
      'fuel_cost_loaded': fuel_cost_loaded,
      'fuel_cost_unloaded': fuel_cost_unloaded,
      'sts_id': sts_id,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      vehicle_number: map['vehicle_number'] as String,
      vehicle_type: map['vehicle_type'] as String,
      capacity: map['capacity'] as int,
      fuel_cost_loaded: map['fuel_cost_loaded'] as int,
      fuel_cost_unloaded: map['fuel_cost_unloaded'] as int,
      sts_id: map['sts_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle.fromJson(String source) =>
      Vehicle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Vehicle(vehicle_number: $vehicle_number, vehicle_type: $vehicle_type, capacity: $capacity, fuel_cost_loaded: $fuel_cost_loaded, fuel_cost_unloaded: $fuel_cost_unloaded, sts_id: $sts_id)';
  }

  @override
  bool operator ==(covariant Vehicle other) {
    if (identical(this, other)) return true;

    return other.vehicle_number == vehicle_number &&
        other.vehicle_type == vehicle_type &&
        other.capacity == capacity &&
        other.fuel_cost_loaded == fuel_cost_loaded &&
        other.fuel_cost_unloaded == fuel_cost_unloaded &&
        other.sts_id == sts_id;
  }

  @override
  int get hashCode {
    return vehicle_number.hashCode ^
        vehicle_type.hashCode ^
        capacity.hashCode ^
        fuel_cost_loaded.hashCode ^
        fuel_cost_unloaded.hashCode ^
        sts_id.hashCode;
  }
}

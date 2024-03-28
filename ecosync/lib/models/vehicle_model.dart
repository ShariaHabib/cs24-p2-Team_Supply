import 'dart:convert';

class Vehicle {
  final String vehicle_number;
  final String vehicle_type;
  final int capacity;
  final int fuelCostLoaded;
  final int fuelCostUnloaded;
  Vehicle({
    required this.vehicle_number,
    required this.vehicle_type,
    required this.capacity,
    required this.fuelCostLoaded,
    required this.fuelCostUnloaded,
  });

  Vehicle copyWith({
    String? vehicle_number,
    String? vehicle_type,
    int? capacity,
    int? fuelCostLoaded,
    int? fuelCostUnloaded,
  }) {
    return Vehicle(
      vehicle_number: vehicle_number ?? this.vehicle_number,
      vehicle_type: vehicle_type ?? this.vehicle_type,
      capacity: capacity ?? this.capacity,
      fuelCostLoaded: fuelCostLoaded ?? this.fuelCostLoaded,
      fuelCostUnloaded: fuelCostUnloaded ?? this.fuelCostUnloaded,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vehicle_number': vehicle_number,
      'vehicle_type': vehicle_type,
      'capacity': capacity,
      'fuelCostLoaded': fuelCostLoaded,
      'fuelCostUnloaded': fuelCostUnloaded,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      vehicle_number: map['vehicle_number'] as String,
      vehicle_type: map['vehicle_type'] as String,
      capacity: map['capacity'] as int,
      fuelCostLoaded: map['fuelCostLoaded'] as int,
      fuelCostUnloaded: map['fuelCostUnloaded'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle.fromJson(String source) =>
      Vehicle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Vehicle(vehicle_number: $vehicle_number, vehicle_type: $vehicle_type, capacity: $capacity, fuelCostLoaded: $fuelCostLoaded, fuelCostUnloaded: $fuelCostUnloaded)';
  }

  @override
  bool operator ==(covariant Vehicle other) {
    if (identical(this, other)) return true;

    return other.vehicle_number == vehicle_number &&
        other.vehicle_type == vehicle_type &&
        other.capacity == capacity &&
        other.fuelCostLoaded == fuelCostLoaded &&
        other.fuelCostUnloaded == fuelCostUnloaded;
  }

  @override
  int get hashCode {
    return vehicle_number.hashCode ^
        vehicle_type.hashCode ^
        capacity.hashCode ^
        fuelCostLoaded.hashCode ^
        fuelCostUnloaded.hashCode;
  }
}

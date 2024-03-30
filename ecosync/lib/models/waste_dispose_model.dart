import 'dart:convert';

class WasteDisposeModel {
  final String vehicle_number;
  final int volume_waste;
  final String arrival_time;
  final String departure_time;
  WasteDisposeModel({
    required this.vehicle_number,
    required this.volume_waste,
    required this.arrival_time,
    required this.departure_time,
  });

  WasteDisposeModel copyWith({
    String? vehicle_number,
    int? volume_waste,
    String? arrival_time,
    String? departure_time,
  }) {
    return WasteDisposeModel(
      vehicle_number: vehicle_number ?? this.vehicle_number,
      volume_waste: volume_waste ?? this.volume_waste,
      arrival_time: arrival_time ?? this.arrival_time,
      departure_time: departure_time ?? this.departure_time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vehicle_number': vehicle_number,
      'volume_waste': volume_waste,
      'arrival_time': arrival_time,
      'departure_time': departure_time,
    };
  }

  factory WasteDisposeModel.fromMap(Map<String, dynamic> map) {
    return WasteDisposeModel(
      vehicle_number: map['vehicle_number'] as String,
      volume_waste: map['volume_waste'] as int,
      arrival_time: map['arrival_time'] as String,
      departure_time: map['departure_time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WasteDisposeModel.fromJson(String source) =>
      WasteDisposeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WasteDisposeModel(vehicle_number: $vehicle_number, volume_waste: $volume_waste, arrival_time: $arrival_time, departure_time: $departure_time)';
  }

  @override
  bool operator ==(covariant WasteDisposeModel other) {
    if (identical(this, other)) return true;

    return other.vehicle_number == vehicle_number &&
        other.volume_waste == volume_waste &&
        other.arrival_time == arrival_time &&
        other.departure_time == departure_time;
  }

  @override
  int get hashCode {
    return vehicle_number.hashCode ^
        volume_waste.hashCode ^
        arrival_time.hashCode ^
        departure_time.hashCode;
  }
}

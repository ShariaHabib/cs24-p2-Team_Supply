// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WasteCollectionModel {
  final int? sts_id;
  final String vehicle_number;
  final int volume_waste;
  final String arrival_time;
  final String departure_time;
  WasteCollectionModel({
    this.sts_id,
    required this.vehicle_number,
    required this.volume_waste,
    required this.arrival_time,
    required this.departure_time,
  });

  WasteCollectionModel copyWith({
    int? sts_id,
    String? vehicle_number,
    int? volume_waste,
    String? arrival_time,
    String? departure_time,
  }) {
    return WasteCollectionModel(
      sts_id: sts_id ?? this.sts_id,
      vehicle_number: vehicle_number ?? this.vehicle_number,
      volume_waste: volume_waste ?? this.volume_waste,
      arrival_time: arrival_time ?? this.arrival_time,
      departure_time: departure_time ?? this.departure_time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sts_id': sts_id,
      'vehicle_number': vehicle_number,
      'volume_waste': volume_waste,
      'arrival_time': arrival_time,
      'departure_time': departure_time,
    };
  }

  factory WasteCollectionModel.fromMap(Map<String, dynamic> map) {
    return WasteCollectionModel(
      sts_id: map['sts_id'] != null ? map['sts_id'] as int : null,
      vehicle_number: map['vehicle_number'] as String,
      volume_waste: map['volume_waste'] as int,
      arrival_time: map['arrival_time'] as String,
      departure_time: map['departure_time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WasteCollectionModel.fromJson(String source) =>
      WasteCollectionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WasteCollectionModel(sts_id: $sts_id, vehicle_number: $vehicle_number, volume_waste: $volume_waste, arrival_time: $arrival_time, departure_time: $departure_time)';
  }

  @override
  bool operator ==(covariant WasteCollectionModel other) {
    if (identical(this, other)) return true;

    return other.sts_id == sts_id &&
        other.vehicle_number == vehicle_number &&
        other.volume_waste == volume_waste &&
        other.arrival_time == arrival_time &&
        other.departure_time == departure_time;
  }

  @override
  int get hashCode {
    return sts_id.hashCode ^
        vehicle_number.hashCode ^
        volume_waste.hashCode ^
        arrival_time.hashCode ^
        departure_time.hashCode;
  }
}

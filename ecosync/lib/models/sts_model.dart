import 'dart:convert';

class STS {
  final int ward_no;
  final int sts_id;
  final double latitude;
  final double longitude;
  final String manager;
  final int capacity;
  STS({
    required this.ward_no,
    required this.sts_id,
    required this.latitude,
    required this.longitude,
    required this.manager,
    required this.capacity,
  });

  STS copyWith({
    int? ward_no,
    int? sts_id,
    double? latitude,
    double? longitude,
    String? manager,
    int? capacity,
  }) {
    return STS(
      ward_no: ward_no ?? this.ward_no,
      sts_id: sts_id ?? this.sts_id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      manager: manager ?? this.manager,
      capacity: capacity ?? this.capacity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ward_no': ward_no,
      'sts_id': sts_id,
      'latitude': latitude,
      'longitude': longitude,
      'manager': manager,
      'capacity': capacity,
    };
  }

  factory STS.fromMap(Map<String, dynamic> map) {
    return STS(
      ward_no: map['ward_no'] as int,
      sts_id: map['sts_id'] as int,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      manager: map['manager'] as String,
      capacity: map['capacity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory STS.fromJson(String source) =>
      STS.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'STS(ward_no: $ward_no, sts_id: $sts_id, latitude: $latitude, longitude: $longitude, manager: $manager, capacity: $capacity)';
  }

  @override
  bool operator ==(covariant STS other) {
    if (identical(this, other)) return true;

    return other.ward_no == ward_no &&
        other.sts_id == sts_id &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.manager == manager &&
        other.capacity == capacity;
  }

  @override
  int get hashCode {
    return ward_no.hashCode ^
        sts_id.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        manager.hashCode ^
        capacity.hashCode;
  }
}

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ecosync/models/vehicle_model.dart';

class VehicleListResponse {
  final bool success;
  final List<Vehicle> vehicleList;
  VehicleListResponse({
    required this.success,
    required this.vehicleList,
  });

  VehicleListResponse copyWith({
    bool? success,
    List<Vehicle>? vehicleList,
  }) {
    return VehicleListResponse(
      success: success ?? this.success,
      vehicleList: vehicleList ?? this.vehicleList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'vehicleList': vehicleList.map((x) => x.toMap()).toList(),
    };
  }

  factory VehicleListResponse.fromMap(Map<String, dynamic> map) {
    return VehicleListResponse(
      success: map['success'] as bool,
      vehicleList: List<Vehicle>.from(
        (map['vehicleList'] as List<int>).map<Vehicle>(
          (x) => Vehicle.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleListResponse.fromJson(String source) =>
      VehicleListResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'VehicleListResponse(success: $success, vehicleList: $vehicleList)';

  @override
  bool operator ==(covariant VehicleListResponse other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.success == success &&
        listEquals(other.vehicleList, vehicleList);
  }

  @override
  int get hashCode => success.hashCode ^ vehicleList.hashCode;
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:ecosync/models/vehicle_model.dart';

class VehicleListResponse {
  final bool success;
  final List<Vehicle> vehiclesList;
  VehicleListResponse({
    required this.success,
    required this.vehiclesList,
  });

  VehicleListResponse copyWith({
    bool? success,
    List<Vehicle>? vehiclesList,
  }) {
    return VehicleListResponse(
      success: success ?? this.success,
      vehiclesList: vehiclesList ?? this.vehiclesList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'vehiclesList': vehiclesList.map((x) => x.toMap()).toList(),
    };
  }

  factory VehicleListResponse.fromMap(Map<String, dynamic> map) {
    print(map['vehiclesList'].runtimeType);
    return VehicleListResponse(
      success: map['success'] as bool,
      vehiclesList: List<Vehicle>.from(
        (map['vehiclesList'] as List<dynamic>).map<Vehicle>(
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
      'VehicleListResponse(success: $success, vehiclesList: $vehiclesList)';
}

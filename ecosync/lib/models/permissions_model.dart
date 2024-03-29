// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class PermissionModel {
  final int permission_id;
  final String permission_name;
  PermissionModel({
    required this.permission_id,
    required this.permission_name,
  });

  PermissionModel copyWith({
    int? permission_id,
    String? permission_name,
  }) {
    return PermissionModel(
      permission_id: permission_id ?? this.permission_id,
      permission_name: permission_name ?? this.permission_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'permission_id': permission_id,
      'permission_name': permission_name,
    };
  }

  factory PermissionModel.fromMap(Map<String, dynamic> map) {
    return PermissionModel(
      permission_id: map['permission_id'] as int,
      permission_name: map['permission_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PermissionModel.fromJson(String source) =>
      PermissionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PermissionModel(permission_id: $permission_id, permission_name: $permission_name)';

  @override
  bool operator ==(covariant PermissionModel other) {
    if (identical(this, other)) return true;

    return other.permission_id == permission_id &&
        other.permission_name == permission_name;
  }

  @override
  int get hashCode => permission_id.hashCode ^ permission_name.hashCode;
}

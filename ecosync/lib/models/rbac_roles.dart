import 'dart:convert';

import 'package:flutter/foundation.dart';

class RbacRolesModel {
  final int role_id;
  final String role_name;
  final List<String> permissions;
  RbacRolesModel({
    required this.role_id,
    required this.role_name,
    required this.permissions,
  });

  RbacRolesModel copyWith({
    int? role_id,
    String? role_name,
    List<String>? permissions,
  }) {
    return RbacRolesModel(
      role_id: role_id ?? this.role_id,
      role_name: role_name ?? this.role_name,
      permissions: permissions ?? this.permissions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'role_id': role_id,
      'role_name': role_name,
      'permissions': permissions,
    };
  }

  factory RbacRolesModel.fromMap(Map<String, dynamic> map) {
    return RbacRolesModel(
        role_id: map['role_id'] as int,
        role_name: map['role_name'] as String,
        permissions: List<String>.from(
          (map['permissions'] as List<String>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory RbacRolesModel.fromJson(String source) =>
      RbacRolesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RbacRolesModel(role_id: $role_id, role_name: $role_name, permissions: $permissions)';

  @override
  bool operator ==(covariant RbacRolesModel other) {
    if (identical(this, other)) return true;

    return other.role_id == role_id &&
        other.role_name == role_name &&
        listEquals(other.permissions, permissions);
  }

  @override
  int get hashCode =>
      role_id.hashCode ^ role_name.hashCode ^ permissions.hashCode;
}

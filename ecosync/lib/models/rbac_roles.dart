import 'dart:convert';

import 'package:ecosync/models/models.dart';

class RbacRolesModel {
  final int role_id;
  final String role_name;
  final List<PermissionModel> permissions;

  RbacRolesModel({
    required this.role_id,
    required this.role_name,
    required this.permissions,
  });

  RbacRolesModel copyWith({
    int? role_id,
    String? role_name,
    List<PermissionModel>? permissions, //
  }) {
    return RbacRolesModel(
      role_id: role_id ?? this.role_id,
      role_name: role_name ?? this.role_name,
      permissions: permissions ?? this.permissions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role_id': role_id,
      'role_name': role_name,
      'permissions': permissions.map((x) => x.toMap()).toList(),
    };
  }

  factory RbacRolesModel.fromMap(Map<String, dynamic> map) {
    return RbacRolesModel(
      role_id: map['role_id'] as int,
      role_name: map['role_name'] as String,
      permissions: List<PermissionModel>.from(
        (map['permissions'] as List<dynamic>).map(
          (x) => PermissionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RbacRolesModel.fromJson(String source) =>
      RbacRolesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RbacRolesModel(role_id: $role_id, role_name: $role_name, permissions: $permissions)';
}

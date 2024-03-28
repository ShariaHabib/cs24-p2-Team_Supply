// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Role {
  final int roleId;
  final String? roleName;
  Role({
    required this.roleId,
    this.roleName,
  });

  Role copyWith({
    int? roleId,
    String? roleName,
  }) {
    return Role(
      roleId: roleId ?? this.roleId,
      roleName: roleName ?? this.roleName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'role_id': roleId,
      'role_name': roleName,
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      roleId: map['role_id'] as int,
      roleName: map['role_name'] != null ? map['role_name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Role.fromJson(String source) =>
      Role.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Role(roleId: $roleId, roleName: $roleName)';

  @override
  bool operator ==(covariant Role other) {
    if (identical(this, other)) return true;

    return other.roleId == roleId && other.roleName == roleName;
  }

  @override
  int get hashCode => roleId.hashCode ^ roleName.hashCode;
}

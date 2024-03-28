import 'dart:convert';

class Role {
  final int roleId;
  final String roleName;
  Role({
    required this.roleId,
    required this.roleName,
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
      'roleId': roleId,
      'roleName': roleName,
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      roleId: map['role_id'] as int,
      roleName: map['role_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Role.fromJson(String source) =>
      Role.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Role(role_id: $roleId, role_name: $roleName)';

  @override
  bool operator ==(covariant Role other) {
    if (identical(this, other)) return true;

    return other.roleId == roleId && other.roleName == roleName;
  }

  @override
  int get hashCode => roleId.hashCode ^ roleName.hashCode;
}

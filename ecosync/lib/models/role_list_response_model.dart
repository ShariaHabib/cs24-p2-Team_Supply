import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ecosync/models/role.model.dart';

class RoleListResponse {
  final List<Role> roleList;
  RoleListResponse({
    required this.roleList,
  });

  RoleListResponse copyWith({
    List<Role>? roleList,
  }) {
    return RoleListResponse(
      roleList: roleList ?? this.roleList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roleList': roleList.map((x) => x.toMap()).toList(),
    };
  }

  factory RoleListResponse.fromMap(Map<String, dynamic> map) {
    return RoleListResponse(
      roleList: List<Role>.from(
        (map['roleList'] as List<dynamic>).map<Role>(
          (x) => Role.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoleListResponse.fromJson(String source) =>
      RoleListResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RoleListResponse(roleList: $roleList)';

  @override
  bool operator ==(covariant RoleListResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.roleList, roleList);
  }

  @override
  int get hashCode => roleList.hashCode;
}

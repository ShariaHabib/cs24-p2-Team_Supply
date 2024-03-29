import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ecosync/models/rbac_roles.dart';

class RbacRolesResponse {
  final bool success;
  final String? message;
  final List<RbacRolesModel> roleList;
  RbacRolesResponse({
    required this.success,
    this.message,
    required this.roleList,
  });

  RbacRolesResponse copyWith({
    bool? success,
    String? message,
    List<RbacRolesModel>? roleList,
  }) {
    return RbacRolesResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      roleList: roleList ?? this.roleList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'roleList': roleList.map((x) => x.toMap()).toList(),
    };
  }

  factory RbacRolesResponse.fromMap(Map<String, dynamic> map) {
    return RbacRolesResponse(
      success: map['success'] as bool,
      message: map['message'] != null ? map['message'] as String : null,
      roleList: List<RbacRolesModel>.from(
        (map['roleList'] as List<dynamic>).map<RbacRolesModel>(
          (x) => RbacRolesModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RbacRolesResponse.fromJson(String source) =>
      RbacRolesResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RbacRolesResponse(success: $success, message: $message, roleList: $roleList)';

  @override
  bool operator ==(covariant RbacRolesResponse other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        other.message == message &&
        listEquals(other.roleList, roleList);
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ roleList.hashCode;
}

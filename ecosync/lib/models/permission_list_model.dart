// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ecosync/models/permissions_model.dart';

class PermissionListModel {
  final bool success;
  final List<PermissionModel> permissionList;
  final String? message;
  PermissionListModel({
    required this.success,
    required this.permissionList,
    this.message,
  });

  PermissionListModel copyWith({
    bool? success,
    List<PermissionModel>? permissionList,
    String? message,
  }) {
    return PermissionListModel(
      success: success ?? this.success,
      permissionList: permissionList ?? this.permissionList,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'permissionList': permissionList.map((x) => x.toMap()).toList(),
      'message': message,
    };
  }

  factory PermissionListModel.fromMap(Map<String, dynamic> map) {
    return PermissionListModel(
      success: map['success'] as bool,
      permissionList: List<PermissionModel>.from(
        (map['permissionList'] as List<dynamic>).map<PermissionModel>(
          (x) => PermissionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PermissionListModel.fromJson(String source) =>
      PermissionListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PermissionListModel(success: $success, permissionList: $permissionList, message: $message)';

  @override
  bool operator ==(covariant PermissionListModel other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        listEquals(other.permissionList, permissionList) &&
        other.message == message;
  }

  @override
  int get hashCode =>
      success.hashCode ^ permissionList.hashCode ^ message.hashCode;
}

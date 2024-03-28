import 'dart:convert';

import 'package:collection/collection.dart';

import 'models.dart';

class PermissionListModel {
  final bool success;
  final List<Permission> data;
  PermissionListModel({
    required this.success,
    required this.data,
  });

  PermissionListModel copyWith({
    bool? success,
    List<Permission>? data,
  }) {
    return PermissionListModel(
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory PermissionListModel.fromMap(Map<String, dynamic> map) {
    return PermissionListModel(
      success: map['success'] as bool,
      data: List<Permission>.from(
        (map['data'] as List<int>).map<Permission>(
          (x) => Permission.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PermissionListModel.fromJson(String source) =>
      PermissionListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PermissionListModel(success: $success, data: $data)';

  @override
  bool operator ==(covariant PermissionListModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.success == success && listEquals(other.data, data);
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode;
}

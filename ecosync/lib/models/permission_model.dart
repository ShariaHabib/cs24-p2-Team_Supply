import 'dart:convert';

class Permission {
  final String permission_id;
  final String permission_name;
  final bool success;
  Permission({
    required this.permission_id,
    required this.permission_name,
    required this.success,
  });

  Permission copyWith({
    String? permission_id,
    String? permission_name,
    bool? success,
  }) {
    return Permission(
      permission_id: permission_id ?? this.permission_id,
      permission_name: permission_name ?? this.permission_name,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'permission_id': permission_id,
      'permission_name': permission_name,
      'success': success,
    };
  }

  factory Permission.fromMap(Map<String, dynamic> map) {
    return Permission(
      permission_id: map['permission_id'] as String,
      permission_name: map['permission_name'] as String,
      success: map['success'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Permission.fromJson(String source) =>
      Permission.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Permission(permission_id: $permission_id, permission_name: $permission_name, success: $success)';

  @override
  bool operator ==(covariant Permission other) {
    if (identical(this, other)) return true;

    return other.permission_id == permission_id &&
        other.permission_name == permission_name &&
        other.success == success;
  }

  @override
  int get hashCode =>
      permission_id.hashCode ^ permission_name.hashCode ^ success.hashCode;
}

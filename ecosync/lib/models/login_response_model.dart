// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginResponse {
  final String message;
  final loginUser userInfo;
  final String token;
  final bool success;
  LoginResponse({
    required this.message,
    required this.userInfo,
    required this.token,
    required this.success,
  });

  LoginResponse copyWith({
    String? message,
    loginUser? userInfo,
    String? token,
    bool? success,
  }) {
    return LoginResponse(
      message: message ?? this.message,
      userInfo: userInfo ?? this.userInfo,
      token: token ?? this.token,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'userInfo': userInfo.toMap(),
      'token': token,
      'success': success,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      message: map['message'] as String,
      userInfo: loginUser.fromMap(map['userInfo'] as Map<String, dynamic>),
      token: map['token'] as String,
      success: map['success'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginResponse(message: $message, userInfo: $userInfo, token: $token, success: $success)';
  }

  @override
  bool operator ==(covariant LoginResponse other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.userInfo == userInfo &&
        other.token == token &&
        other.success == success;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        userInfo.hashCode ^
        token.hashCode ^
        success.hashCode;
  }
}

class loginUser {
  final int role_id;
  final String user_id;
  final String user_name;
  loginUser({
    required this.role_id,
    required this.user_id,
    required this.user_name,
  });

  loginUser copyWith({
    int? role_id,
    String? user_id,
    String? user_name,
  }) {
    return loginUser(
      role_id: role_id ?? this.role_id,
      user_id: user_id ?? this.user_id,
      user_name: user_name ?? this.user_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'role_id': role_id,
      'user_id': user_id,
      'user_name': user_name,
    };
  }

  factory loginUser.fromMap(Map<String, dynamic> map) {
    return loginUser(
      role_id: map['role_id'] as int,
      user_id: map['user_id'] as String,
      user_name: map['user_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory loginUser.fromJson(String source) =>
      loginUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'loginUser(role_id: $role_id, user_id: $user_id, user_name: $user_name)';

  @override
  bool operator ==(covariant loginUser other) {
    if (identical(this, other)) return true;

    return other.role_id == role_id &&
        other.user_id == user_id &&
        other.user_name == user_name;
  }

  @override
  int get hashCode => role_id.hashCode ^ user_id.hashCode ^ user_name.hashCode;
}

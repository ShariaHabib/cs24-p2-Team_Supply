import 'dart:convert';

class LoginResponse {
  final String message;
  final String userId;
  final String token;
  final bool success;
  LoginResponse({
    required this.success,
    required this.message,
    required this.userId,
    required this.token,
  });

  LoginResponse copyWith({
    bool? success,
    String? message,
    String? userId,
    String? token,
  }) {
    return LoginResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      userId: userId ?? this.userId,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'user_id': userId,
      'token': token,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      success: map['success'] as bool,
      message: map['message'] as String,
      userId: map['user_id'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LoginResponse(message: $message, user_id: $userId, token: $token, success: $success)';

  @override
  bool operator ==(covariant LoginResponse other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.userId == userId &&
        other.token == token;
  }

  @override
  int get hashCode => message.hashCode ^ userId.hashCode ^ token.hashCode;
}

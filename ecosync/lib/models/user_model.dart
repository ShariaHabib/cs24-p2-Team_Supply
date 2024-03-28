import 'dart:convert';

class User {
  final String? userId;
  final String email;
  final String userName;
  final String userRole;
  User({
    this.userId,
    required this.email,
    required this.userName,
    required this.userRole,
  });

  User copyWith({
    String? userId,
    String? email,
    String? userName,
    String? userRole,
  }) {
    return User(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      userRole: userRole ?? this.userRole,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'email': email,
      'user_name': userName,
      'user_role': userRole,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['user_id'] as String,
      email: map['email'] as String,
      userName: map['user_name'] as String,
      userRole: map['user_role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(user_id: $userId, email: $email, user_name: $userName, user_role: $userRole)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.email == email &&
        other.userName == userName &&
        other.userRole == userRole;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        email.hashCode ^
        userName.hashCode ^
        userRole.hashCode;
  }
}

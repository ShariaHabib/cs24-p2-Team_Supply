import 'dart:convert';

class User {
  final String? userId;
  final String? email;
  final String userName;
  final String? userRole;
  final String? password;
  User({
    this.userId,
    this.email,
    required this.userName,
    this.userRole,
    this.password,
  });

  User copyWith({
    String? userId,
    String? email,
    String? userName,
    String? userRole,
    String? password,
  }) {
    return User(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      userRole: userRole ?? this.userRole,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'email': email,
      'user_name': userName,
      'user_role': userRole,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['user_id'] != null ? map['user_id'] as String : null,
      email: map['email'] as String,
      userName: map['user_name'] as String,
      userRole: map['user_role'] as String,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(userId: $userId, email: $email, userName: $userName, userRole: $userRole, password: $password)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.email == email &&
        other.userName == userName &&
        other.userRole == userRole &&
        other.password == password;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        email.hashCode ^
        userName.hashCode ^
        userRole.hashCode ^
        password.hashCode;
  }
}

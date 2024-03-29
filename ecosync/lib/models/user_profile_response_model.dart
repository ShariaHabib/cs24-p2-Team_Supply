import 'dart:convert';

class UserProfileResponse {
  final bool success;
  final Map<String, String> userData;

  UserProfileResponse({
    required this.success,
    required this.userData,
  });

  factory UserProfileResponse.fromMap(Map<String, dynamic> map) {
    return UserProfileResponse(
      success: map['success'] as bool,
      userData:
          Map<String, String>.from(map['userData'] as Map<String, dynamic>),
    );
  }

  String toJson() {
    return json.encode({
      'success': success,
      'userData': userData,
    });
  }

  factory UserProfileResponse.fromJson(String source) {
    return UserProfileResponse.fromMap(
        json.decode(source) as Map<String, dynamic>);
  }

  @override
  String toString() {
    return 'UserProfileResponse(success: $success, userData: $userData)';
  }
}

import 'dart:convert';

class RegistGeneralResponse {
  final bool success;
  final String message;
  RegistGeneralResponse({
    required this.success,
    required this.message,
  });

  RegistGeneralResponse copyWith({
    bool? success,
    String? message,
  }) {
    return RegistGeneralResponse(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'message': message,
    };
  }

  factory RegistGeneralResponse.fromMap(Map<String, dynamic> map) {
    return RegistGeneralResponse(
      success: map['success'] as bool,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistGeneralResponse.fromJson(String source) =>
      RegistGeneralResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RegistGeneralResponse(success: $success, message: $message)';

  @override
  bool operator ==(covariant RegistGeneralResponse other) {
    if (identical(this, other)) return true;

    return other.success == success && other.message == message;
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode;
}

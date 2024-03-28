import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ecosync/models/models.dart';

class UserListResponse {
  final bool success;
  final List<User> userList;
  UserListResponse({
    required this.success,
    required this.userList,
  });

  UserListResponse copyWith({
    List<User>? userList,
  }) {
    return UserListResponse(
      success: success,
      userList: userList ?? this.userList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userList': userList.map((x) => x.toMap()).toList(),
    };
  }

  factory UserListResponse.fromMap(Map<String, dynamic> map) {
    return UserListResponse(
      success: map['success'] as bool,
      userList: List<User>.from(
        (map['userList'] as List<dynamic>).map<User>(
          (x) => User.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserListResponse.fromJson(String source) =>
      UserListResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserListResponse(userList: $userList)';

  @override
  bool operator ==(covariant UserListResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.userList, userList);
  }

  @override
  int get hashCode => userList.hashCode;
}

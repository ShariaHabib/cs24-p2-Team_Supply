import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'waste_collection_model.dart';

class WasteCollectionResponseModel {
  final bool success;
  final List<WasteCollectionModel> stsScheduleList;
  final String? message;
  WasteCollectionResponseModel({
    required this.success,
    required this.stsScheduleList,
    this.message,
  });

  WasteCollectionResponseModel copyWith({
    bool? success,
    List<WasteCollectionModel>? stsScheduleList,
    String? message,
  }) {
    return WasteCollectionResponseModel(
      success: success ?? this.success,
      stsScheduleList: stsScheduleList ?? this.stsScheduleList,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'stsScheduleList': stsScheduleList.map((x) => x.toMap()).toList(),
      'message': message,
    };
  }

  factory WasteCollectionResponseModel.fromMap(Map<String, dynamic> map) {
    return WasteCollectionResponseModel(
      success: map['success'] as bool,
      stsScheduleList: List<WasteCollectionModel>.from(
        (map['stsScheduleList'] as List<dynamic>).map<WasteCollectionModel>(
          (x) => WasteCollectionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WasteCollectionResponseModel.fromJson(String source) =>
      WasteCollectionResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WasteCollectionResponseModel(success: $success, stsScheduleList: $stsScheduleList, message: $message)';

  @override
  bool operator ==(covariant WasteCollectionResponseModel other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        listEquals(other.stsScheduleList, stsScheduleList) &&
        other.message == message;
  }

  @override
  int get hashCode =>
      success.hashCode ^ stsScheduleList.hashCode ^ message.hashCode;
}

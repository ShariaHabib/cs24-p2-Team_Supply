import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'waste_dispose_model.dart';

class WasteDisposeResponse {
  final bool success;
  final List<WasteDisposeModel> landfillEntryList;
  WasteDisposeResponse({
    required this.success,
    required this.landfillEntryList,
  });

  WasteDisposeResponse copyWith({
    bool? success,
    List<WasteDisposeModel>? landfillEntryList,
  }) {
    return WasteDisposeResponse(
      success: success ?? this.success,
      landfillEntryList: landfillEntryList ?? this.landfillEntryList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'landfillEntryList': landfillEntryList.map((x) => x.toMap()).toList(),
    };
  }

  factory WasteDisposeResponse.fromMap(Map<String, dynamic> map) {
    return WasteDisposeResponse(
      success: map['success'] as bool,
      landfillEntryList: List<WasteDisposeModel>.from(
        (map['landfillEntryList'] as List<dynamic>).map<WasteDisposeModel>(
          (x) => WasteDisposeModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory WasteDisposeResponse.fromJson(String source) =>
      WasteDisposeResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WasteDisposeResponse(success: $success, landfillEntryList: $landfillEntryList)';

  @override
  bool operator ==(covariant WasteDisposeResponse other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        listEquals(other.landfillEntryList, landfillEntryList);
  }

  @override
  int get hashCode => success.hashCode ^ landfillEntryList.hashCode;
}

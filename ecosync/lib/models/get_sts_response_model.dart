import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ecosync/models/sts_model.dart';

class GetSTSResponse {
  final bool success;
  final List<STS> stsList;
  GetSTSResponse({
    required this.success,
    required this.stsList,
  });

  GetSTSResponse copyWith({
    bool? success,
    List<STS>? stsList,
  }) {
    return GetSTSResponse(
      success: success ?? this.success,
      stsList: stsList ?? this.stsList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'stsList': stsList.map((x) => x.toMap()).toList(),
    };
  }

  factory GetSTSResponse.fromMap(Map<String, dynamic> map) {
    return GetSTSResponse(
      success: map['success'] as bool,
      stsList: List<STS>.from(
        (map['stsList'] as List<dynamic>).map<STS>(
          (x) => STS.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetSTSResponse.fromJson(String source) =>
      GetSTSResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GetSTSResponse(success: $success, stsList: $stsList)';

  @override
  bool operator ==(covariant GetSTSResponse other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.success == success && listEquals(other.stsList, stsList);
  }

  @override
  int get hashCode => success.hashCode ^ stsList.hashCode;
}

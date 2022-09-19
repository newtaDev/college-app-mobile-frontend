import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../data_class/class_time_table.dart';

class ClassTimeTableRes extends Equatable {
  final String? status;
  final List<ClassTimeTable>? responseData;

  const ClassTimeTableRes({this.status, this.responseData});

  factory ClassTimeTableRes.fromMap(Map<String, dynamic> data) {
    return ClassTimeTableRes(
      status: data['status'] as String?,
      responseData: (data['responseData'] as List<dynamic>?)
          ?.map((e) => ClassTimeTable.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'responseData': responseData?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ClassTimeTableRes].
  factory ClassTimeTableRes.fromJson(String data) {
    return ClassTimeTableRes.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ClassTimeTableRes] to a JSON string.
  String toJson() => json.encode(toMap());

  ClassTimeTableRes copyWith({
    String? status,
    List<ClassTimeTable>? responseData,
  }) {
    return ClassTimeTableRes(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
    );
  }

  @override
  List<Object?> get props => [status, responseData];
}

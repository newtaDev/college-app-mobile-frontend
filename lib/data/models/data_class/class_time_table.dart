import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../shared/extensions/extentions.dart';
import '../../../shared/global/enums.dart';
import 'class_with_details.dart';
import 'subject_model.dart';

class ClassTimeTable extends Equatable {
  final String? id;
  final Subject? subjectId;
  final ClassWithDetails? classId;
  final String? collegeId;
  final TeacherUser? teacherId;
  final TimeOfDay? endingTime;
  final TimeOfDay? startingTime;
  final Week? week;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const ClassTimeTable({
    this.id,
    this.subjectId,
    this.classId,
    this.collegeId,
    this.teacherId,
    this.endingTime,
    this.startingTime,
    this.week,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ClassTimeTable.fromMap(Map<String, dynamic> data) => ClassTimeTable(
        id: data['_id'] as String?,
        subjectId: data['subjectId'] == null
            ? null
            : Subject.fromMap(data['subjectId'] as Map<String, dynamic>),
        classId: data['classId'] == null
            ? null
            : ClassWithDetails.fromMap(data['classId'] as Map<String, dynamic>),
        collegeId: data['collegeId'] as String?,
        teacherId: data['teacherId'] == null
            ? null
            : TeacherUser.fromMap(data['teacherId'] as Map<String, dynamic>),
        endingTime: (data['endingTime'] as String).parseToTimeOfDay(),
        startingTime: (data['startingTime'] as String).parseToTimeOfDay(),
        week: Week.fromName(data['week'] as String),
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        v: data['__v'] as int?,
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'subjectId': subjectId?.toMap(),
        'classId': classId?.toMap(),
        'collegeId': collegeId,
        'teacherId': teacherId?.toMap(),
        'endingTime': endingTime,
        'startingTime': startingTime,
        'week': week?.value,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ClassTimeTable].
  factory ClassTimeTable.fromJson(String data) {
    return ClassTimeTable.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ClassTimeTable] to a JSON string.
  String toJson() => json.encode(toMap());

  ClassTimeTable copyWith({
    String? id,
    Subject? subjectId,
    ClassWithDetails? classId,
    String? collegeId,
    TeacherUser? teacherId,
    TimeOfDay? endingTime,
    TimeOfDay? startingTime,
    Week? week,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return ClassTimeTable(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      classId: classId ?? this.classId,
      collegeId: collegeId ?? this.collegeId,
      teacherId: teacherId ?? this.teacherId,
      endingTime: endingTime ?? this.endingTime,
      startingTime: startingTime ?? this.startingTime,
      week: week ?? this.week,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      subjectId,
      classId,
      collegeId,
      teacherId,
      endingTime,
      startingTime,
      week,
      createdAt,
      updatedAt,
      v,
    ];
  }
}

import 'dart:convert';

import '../../../domain/entities/user_entity.dart';
import '../../../utils/utils.dart';
import 'college_model.dart';
import 'course_model.dart';

class ClassWithDetails extends MyEquatable {
  final String? id;
  final String? name;
  final int? classNumber;
  final String? collegeId;
  final College? college;
  final String? courseId;
  final Course? course;
  final int? batch;
  final bool? isCollegeCompleted;
  final int? currentSem;
  final TeacherUser? assignedTo;
  final String? assignedToId;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ClassWithDetails({
    this.id,
    this.name,
    this.classNumber,
    this.college,
    this.course,
    this.courseId,
    this.collegeId,
    this.batch,
    this.isCollegeCompleted,
    this.currentSem,
    this.assignedTo,
    this.assignedToId,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory ClassWithDetails.fromMap(Map<String, dynamic> data) =>
      ClassWithDetails(
        id: data['_id'] as String?,
        name: data['name'] as String?,
        classNumber: data['classNumber'] as int?,
        collegeId: data['collegeId'] != null &&
                data['collegeId'] is Map<String, dynamic>
            ? data['collegeId']['_id']
            : data['collegeId'],
        courseId:
            data['courseId'] != null && data['courseId'] is Map<String, dynamic>
                ? data['courseId']['_id']
                : data['courseId'],
        college: data['collegeId'] != null &&
                data['collegeId'] is Map<String, dynamic>
            ? College.fromMap(data['collegeId'] as Map<String, dynamic>)
            : null,
        course:
            data['courseId'] != null && data['courseId'] is Map<String, dynamic>
                ? Course.fromMap(data['courseId'] as Map<String, dynamic>)
                : null,
        batch: data['batch'] as int?,
        isCollegeCompleted: data['isCollegeCompleted'] as bool?,
        currentSem: data['currentSem'] as int?,
        assignedTo: data['assignedToId'] != null &&
                data['assignedToId'] is Map<String, dynamic>
            ? TeacherUser.fromMap(
                data['assignedToId'] as Map<String, dynamic>,
              )
            : null,
        assignedToId: data['assignedToId'] != null &&
                data['assignedToId'] is Map<String, dynamic>
            ? data['assignedToId']['_id']
            : data['assignedToId'],
        v: data['__v'] as int?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String).toLocal(),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String).toLocal(),
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'classNumber': classNumber,
        'collegeId': collegeId,
        'courseId': courseId,
        'batch': batch,
        'isCollegeCompleted': isCollegeCompleted,
        'currentSem': currentSem,
        'assignedToId': assignedTo?.toMap(),
        '__v': v,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ClassWithDetails].
  factory ClassWithDetails.fromJson(String data) {
    return ClassWithDetails.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ClassWithDetails] to a JSON string.
  String toJson() => json.encode(toMap());

  ClassWithDetails copyWith({
    String? id,
    String? name,
    int? classNumber,
    String? collegeId,
    College? college,
    String? courseId,
    Course? course,
    int? batch,
    bool? isCollegeCompleted,
    int? currentSem,
    TeacherUser? assignedTo,
    int? v,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ClassWithDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      classNumber: classNumber ?? this.classNumber,
      collegeId: collegeId ?? this.collegeId,
      college: college ?? this.college,
      courseId: courseId ?? this.courseId,
      course: course ?? this.course,
      batch: batch ?? this.batch,
      isCollegeCompleted: isCollegeCompleted ?? this.isCollegeCompleted,
      currentSem: currentSem ?? this.currentSem,
      assignedTo: assignedTo ?? this.assignedTo,
      v: v ?? this.v,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      classNumber,
      college,
      course,
      courseId,
      collegeId,
      batch,
      isCollegeCompleted,
      currentSem,
      assignedTo,
      v,
      createdAt,
      updatedAt,
    ];
  }
}

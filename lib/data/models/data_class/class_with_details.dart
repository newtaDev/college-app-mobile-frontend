import 'dart:convert';


import '../../../utils/utils.dart';
import 'college_model.dart';
import 'course_model.dart';
import 'teacher_model.dart';

class ClassWithDetails extends MyEquatable {
  final String? id;
  final String? name;
  final int? classNumber;
  final College? college;
  final Course? course;
  final int? batch;
  final bool? isCollegeCompleted;
  final int? currentSem;
  final TeacherModel? assignedToId;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ClassWithDetails({
    this.id,
    this.name,
    this.classNumber,
    this.college,
    this.course,
    this.batch,
    this.isCollegeCompleted,
    this.currentSem,
    this.assignedToId,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory ClassWithDetails.fromMap(Map<String, dynamic> data) => ClassWithDetails(
        id: data['_id'] as String?,
        name: data['name'] as String?,
        classNumber: data['classNumber'] as int?,
        college: data['collegeId'] == null
            ? null
            : College.fromMap(data['collegeId'] as Map<String, dynamic>),
        course: data['courseId'] == null
            ? null
            : Course.fromMap(data['courseId'] as Map<String, dynamic>),
        batch: data['batch'] as int?,
        isCollegeCompleted: data['isCollegeCompleted'] as bool?,
        currentSem: data['currentSem'] as int?,
        assignedToId: data['assignedToId'] == null
            ? null
            : TeacherModel.fromMap(
                data['assignedToId'] as Map<String, dynamic>),
        v: data['__v'] as int?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'classNumber': classNumber,
        'collegeId': college?.toMap(),
        'courseId': course?.toMap(),
        'batch': batch,
        'isCollegeCompleted': isCollegeCompleted,
        'currentSem': currentSem,
        'assignedToId': assignedToId?.toMap(),
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
    College? college,
    Course? course,
    int? batch,
    bool? isCollegeCompleted,
    int? currentSem,
    TeacherModel? assignedToId,
    int? v,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ClassWithDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      classNumber: classNumber ?? this.classNumber,
      college: college ?? this.college,
      course: course ?? this.course,
      batch: batch ?? this.batch,
      isCollegeCompleted: isCollegeCompleted ?? this.isCollegeCompleted,
      currentSem: currentSem ?? this.currentSem,
      assignedToId: assignedToId ?? this.assignedToId,
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
      batch,
      isCollegeCompleted,
      currentSem,
      assignedToId,
      v,
      createdAt,
      updatedAt,
    ];
  }
}

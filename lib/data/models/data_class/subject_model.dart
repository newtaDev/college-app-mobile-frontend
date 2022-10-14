import 'dart:convert';

import '../../../domain/entities/user_entity.dart';
import '../../../utils/utils.dart';
import 'class_with_details.dart';
import 'course_model.dart';

class Subject extends MyEquatable {
  final String? id;
  final String? name;
  final String? collegeId;
  final String? courseId;
  final int? semester;
  final String? assignedToId;
  final TeacherUser? assignedTo;
  final Course? course;
  final ClassWithDetails? classDetails;
  final String? classId;
  final bool? isMainSubject;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Subject({
    this.id,
    this.name,
    this.collegeId,
    this.courseId,
    this.course,
    this.classDetails,
    this.semester,
    this.classId,
    this.assignedToId,
    this.assignedTo,
    this.isMainSubject,
    this.createdAt,
    this.updatedAt,
  });

  factory Subject.fromMap(Map<String, dynamic> data) => Subject(
        id: data['_id'] as String?,
        name: data['name'] as String?,
        collegeId: data['collegeId'] as String?,
        semester: data['semester'],
        assignedToId: data['assignedTo'] != null &&
                data['assignedTo'] is Map<String, dynamic>
            ? data['assignedTo']['_id']
            : data['assignedTo'],
        assignedTo: data['assignedTo'] == null ||
                data['assignedTo'] is! Map<String, dynamic>
            ? null
            : TeacherUser.fromMap(data['assignedTo'] as Map<String, dynamic>),
        classDetails: data['classId'] == null ||
                data['classId'] is! Map<String, dynamic>
            ? null
            : ClassWithDetails.fromMap(data['classId'] as Map<String, dynamic>),
        classId:
            data['classId'] != null && data['classId'] is Map<String, dynamic>
                ? data['classId']['_id']
                : data['classId'],
        course: data['courseId'] == null ||
                data['courseId'] is! Map<String, dynamic>
            ? null
            : Course.fromMap(data['courseId'] as Map<String, dynamic>),
        courseId:
            data['courseId'] != null && data['courseId'] is Map<String, dynamic>
                ? data['courseId']['_id']
                : data['courseId'],
        isMainSubject: data['isMainSubject'] as bool?,
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
        'collegeId': collegeId,
        'courseId': courseId,
        'isMainSubject': isMainSubject,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Subject].
  factory Subject.fromJson(String data) {
    return Subject.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Subject] to a JSON string.
  String toJson() => json.encode(toMap());

  Subject copyWith({
    String? id,
    String? name,
    String? collegeId,
    String? courseId,
    int? semester,
    String? assignedToId,
    TeacherUser? assignedTo,
    Course? course,
    ClassWithDetails? classDetails,
    String? classId,
    bool? isMainSubject,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
      collegeId: collegeId ?? this.collegeId,
      courseId: courseId ?? this.courseId,
      semester: semester ?? this.semester,
      assignedToId: assignedToId ?? this.assignedToId,
      assignedTo: assignedTo ?? this.assignedTo,
      course: course ?? this.course,
      classDetails: classDetails ?? this.classDetails,
      classId: classId ?? this.classId,
      isMainSubject: isMainSubject ?? this.isMainSubject,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      collegeId,
      courseId,
      semester,
      assignedToId,
      assignedTo,
      course,
      classDetails,
      classId,
      isMainSubject,
      createdAt,
      updatedAt,
    ];
  }
}

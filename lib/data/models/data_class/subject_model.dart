import 'dart:convert';

import '../../../utils/utils.dart';
import 'course_model.dart';

class Subject extends MyEquatable {
  final String? id;
  final String? name;
  final String? collegeId;
  final String? courseId;
  final Course? course;
  final bool? isMainSubject;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Subject({
    this.id,
    this.name,
    this.collegeId,
    this.courseId,
    this.course,
    this.isMainSubject,
    this.createdAt,
    this.updatedAt,
  });

  factory Subject.fromMap(Map<String, dynamic> data) => Subject(
        id: data['_id'] as String?,
        name: data['name'] as String?,
        collegeId: data['collegeId'] as String?,
        course: data['courseId'] == null ||
                data['courseId'] is! Map<String, dynamic>
            ? null
            : Course.fromMap(data['courseId'] as Map<String, dynamic>),
        courseId: data['courseId'] is String ? data['courseId'] : null,
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
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
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
    Course? course,
    bool? isMainSubject,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
      collegeId: collegeId ?? this.collegeId,
      courseId: courseId ?? this.courseId,
      course: course ?? this.course,
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
      course,
      courseId,
      isMainSubject,
      createdAt,
      updatedAt,
    ];
  }
}

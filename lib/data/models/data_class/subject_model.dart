
import 'dart:convert';

import '../../../utils/utils.dart';

class Subject extends MyEquatable {
  final String? id;
  final String? name;
  final String? collegeId;
  final String? courseId;
  final bool? isMainSubject;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Subject({
    this.id,
    this.name,
    this.collegeId,
    this.courseId,
    this.isMainSubject,
    this.createdAt,
    this.updatedAt,
  });

  factory Subject.fromMap(Map<String, dynamic> data) => Subject(
        id: data['_id'] as String?,
        name: data['name'] as String?,
        collegeId: data['collegeId'] as String?,
        courseId: data['courseId'] as String?,
        isMainSubject: data['isMainSubject'] as bool?,
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
    bool? isMainSubject,
    int? v,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
      collegeId: collegeId ?? this.collegeId,
      courseId: courseId ?? this.courseId,
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
      isMainSubject,
      createdAt,
      updatedAt,
    ];
  }
}

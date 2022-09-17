part of reports_entity;

class EachStudentReport extends MyEquatable {
  final StudentUser? student;
  final int? absentClasses;

  const EachStudentReport({this.student, this.absentClasses});

  factory EachStudentReport.fromMap(Map<String, dynamic> data) =>
      EachStudentReport(
        student: data['student'] == null
            ? null
            : StudentUser.fromMap(data['student'] as Map<String, dynamic>),
        absentClasses: data['absent_classes'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'student': student?.toMap(),
        'absent_classes': absentClasses,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [EachStudentReport].
  factory EachStudentReport.fromJson(String data) {
    return EachStudentReport.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [EachStudentReport] to a JSON string.
  String toJson() => json.encode(toMap());

  EachStudentReport copyWith({
    StudentUser? student,
    int? absentClasses,
  }) {
    return EachStudentReport(
      student: student ?? this.student,
      absentClasses: absentClasses ?? this.absentClasses,
    );
  }

  @override
  List<Object?> get props => [student, absentClasses];
}

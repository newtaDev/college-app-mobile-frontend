part of reports_entity;


class AbsentClassReportOfStudent extends MyEquatable {
  final int? absentClassCount;
  final int? totalAttendanceTaken;
  final Subject? subject;

  const AbsentClassReportOfStudent({
    this.absentClassCount,
    this.totalAttendanceTaken,
    this.subject,
  });

  factory AbsentClassReportOfStudent.fromMap(Map<String, dynamic> data) => AbsentClassReportOfStudent(
        absentClassCount: data['absent_class_count'] as int?,
        totalAttendanceTaken: data['total_attendance_taken'] as int?,
        subject: data['subject'] == null
            ? null
            : Subject.fromMap(data['subject'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'absent_class_count': absentClassCount,
        'total_attendance_taken': totalAttendanceTaken,
        'subject': subject?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AbsentClassReportOfStudent].
  factory AbsentClassReportOfStudent.fromJson(String data) {
    return AbsentClassReportOfStudent.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AbsentClassReportOfStudent] to a JSON string.
  String toJson() => json.encode(toMap());

  AbsentClassReportOfStudent copyWith({
    int? absentClassCount,
    int? totalAttendanceTaken,
    Subject? subject,
  }) {
    return AbsentClassReportOfStudent(
      absentClassCount: absentClassCount ?? this.absentClassCount,
      totalAttendanceTaken: totalAttendanceTaken ?? this.totalAttendanceTaken,
      subject: subject ?? this.subject,
    );
  }

  @override
  List<Object?> get props {
    return [
      absentClassCount,
      totalAttendanceTaken,
      subject,
    ];
  }
}

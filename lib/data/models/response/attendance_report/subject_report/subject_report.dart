part of reports_entity;

class SubjectReports extends Equatable {
  final int? totalAttendanceTaken;
  final int? minStudentAbsent;
  final int? maxStudentAbsent;
  final double? avgStudentAbsent;
  final int? minStudentPresent;
  final int? maxStudentPresent;
  final double? avgStudentPresent;
  final String? subjectId;
  final Subject? subject;

  const SubjectReports({
    this.totalAttendanceTaken,
    this.minStudentAbsent,
    this.maxStudentAbsent,
    this.avgStudentAbsent,
    this.minStudentPresent,
    this.maxStudentPresent,
    this.avgStudentPresent,
    this.subjectId,
    this.subject,
  });

  factory SubjectReports.fromMap(Map<String, dynamic> data) => SubjectReports(
        totalAttendanceTaken: data['total_attendance_taken'] as int?,
        minStudentAbsent: data['minStudentAbsent'] as int?,
        maxStudentAbsent: data['maxStudentAbsent'] as int?,
        avgStudentAbsent: (data['avgStudentAbsent'] as num?)?.toDouble(),
        minStudentPresent: data['minStudentPresent'] as int?,
        maxStudentPresent: data['maxStudentPresent'] as int?,
        avgStudentPresent: (data['avgStudentPresent'] as num?)?.toDouble(),
        subjectId: data['subjectId'] as String?,
        subject: data['subject'] == null
            ? null
            : Subject.fromMap(data['subject'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'total_attendance_taken': totalAttendanceTaken,
        'minStudentAbsent': minStudentAbsent,
        'maxStudentAbsent': maxStudentAbsent,
        'avgStudentAbsent': avgStudentAbsent,
        'minStudentPresent': minStudentPresent,
        'maxStudentPresent': maxStudentPresent,
        'avgStudentPresent': avgStudentPresent,
        'subjectId': subjectId,
        'subject': subject?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SubjectReports].
  factory SubjectReports.fromJson(String data) {
    return SubjectReports.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SubjectReports] to a JSON string.
  String toJson() => json.encode(toMap());

  SubjectReports copyWith({
    int? totalAttendanceTaken,
    int? minStudentAbsent,
    int? maxStudentAbsent,
    double? avgStudentAbsent,
    int? minStudentPresent,
    int? maxStudentPresent,
    double? avgStudentPresent,
    String? subjectId,
    Subject? subject,
  }) {
    return SubjectReports(
      totalAttendanceTaken: totalAttendanceTaken ?? this.totalAttendanceTaken,
      minStudentAbsent: minStudentAbsent ?? this.minStudentAbsent,
      maxStudentAbsent: maxStudentAbsent ?? this.maxStudentAbsent,
      avgStudentAbsent: avgStudentAbsent ?? this.avgStudentAbsent,
      minStudentPresent: minStudentPresent ?? this.minStudentPresent,
      maxStudentPresent: maxStudentPresent ?? this.maxStudentPresent,
      avgStudentPresent: avgStudentPresent ?? this.avgStudentPresent,
      subjectId: subjectId ?? this.subjectId,
      subject: subject ?? this.subject,
    );
  }

  @override
  List<Object?> get props {
    return [
      totalAttendanceTaken,
      minStudentAbsent,
      maxStudentAbsent,
      avgStudentAbsent,
      minStudentPresent,
      maxStudentPresent,
      avgStudentPresent,
      subjectId,
      subject,
    ];
  }
}

part of attendance_entity;

class AttendanceWithCount extends MyEquatable {
  final String? id;
  final String? collegeId;
  final String? classId;
  final String? subjectId;
  final TimeOfDay? classStartTime;
  final TimeOfDay? classEndTime;
  final List<String>? absentStudents;
  final int? currentSem;
  final DateTime? createdAt;
  final DateTime? attendanceTakenOn;
  final DateTime? updatedAt;
  final int? absentStudentCount;
  final int? presentStudentCount;
  final Subject? subject;

  const AttendanceWithCount({
    this.id,
    this.collegeId,
    this.classId,
    this.subjectId,
    this.classStartTime,
    this.classEndTime,
    this.absentStudents,
    this.currentSem,
    this.createdAt,
    this.attendanceTakenOn,
    this.updatedAt,
    this.absentStudentCount,
    this.presentStudentCount,
    this.subject,
  });

  factory AttendanceWithCount.fromMap(Map<String, dynamic> data) {
    return AttendanceWithCount(
      id: data['_id'] as String?,
      collegeId: data['collegeId'] as String?,
      classId: data['classId'] as String?,
      subjectId: data['subjectId'] as String?,
      classStartTime: (data['classStartTime'] as String).parseToTimeOfDay(),
      classEndTime: (data['classEndTime'] as String).parseToTimeOfDay(),
      absentStudents: data['absentStudents']
          .map<String>((dynamic e) => e.toString())
          .toList(),
      currentSem: data['currentSem'] as int?,
      attendanceTakenOn: data['attendanceTakenOn'] == null
          ? null
          : DateTime.parse(data['attendanceTakenOn'] as String),
      createdAt: data['createdAt'] == null
          ? null
          : DateTime.parse(data['createdAt'] as String),
      updatedAt: data['updatedAt'] == null
          ? null
          : DateTime.parse(data['updatedAt'] as String),
      absentStudentCount: data['absentStudentCount'] as int?,
      presentStudentCount: data['presentStudentCount'] as int?,
      subject: data['subject'] == null
          ? null
          : Subject.fromMap(data['subject'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        '_id': id,
        'collegeId': collegeId,
        'classId': classId,
        'subjectId': subjectId,
        'classStartTime': classStartTime,
        'classEndTime': classEndTime,
        'absentStudents': absentStudents,
        'currentSem': currentSem,
        'attendanceTakenOn': attendanceTakenOn?.toIso8601String(),
        'absentStudentCount': absentStudentCount,
        'presentStudentCount': presentStudentCount,
        'subject': subject?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AttendanceWithCount].
  factory AttendanceWithCount.fromJson(String data) {
    return AttendanceWithCount.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [AttendanceWithCount] to a JSON string.
  String toJson() => json.encode(toMap());

  AttendanceWithCount copyWith({
    String? id,
    String? collegeId,
    String? classId,
    String? subjectId,
    TimeOfDay? classStartTime,
    TimeOfDay? classEndTime,
    List<String>? absentStudents,
    int? currentSem,
    DateTime? createdAt,
    DateTime? attendanceTakenOn,
    DateTime? updatedAt,
    int? absentStudentCount,
    int? presentStudentCount,
    Subject? subject,
  }) {
    return AttendanceWithCount(
      id: id ?? this.id,
      collegeId: collegeId ?? this.collegeId,
      classId: classId ?? this.classId,
      subjectId: subjectId ?? this.subjectId,
      classStartTime: classStartTime ?? this.classStartTime,
      classEndTime: classEndTime ?? this.classEndTime,
      absentStudents: absentStudents ?? this.absentStudents,
      currentSem: currentSem ?? this.currentSem,
      createdAt: createdAt ?? this.createdAt,
      attendanceTakenOn: attendanceTakenOn ?? this.attendanceTakenOn,
      updatedAt: updatedAt ?? this.updatedAt,
      absentStudentCount: absentStudentCount ?? this.absentStudentCount,
      presentStudentCount: presentStudentCount ?? this.presentStudentCount,
      subject: subject ?? this.subject,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      collegeId,
      classId,
      subjectId,
      classStartTime,
      classEndTime,
      absentStudents,
      currentSem,
      createdAt,
      updatedAt,
      absentStudentCount,
      presentStudentCount,
      subject,
    ];
  }
}

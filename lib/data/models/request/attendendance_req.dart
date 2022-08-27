part of attendance_entity;

class AllAttendanceWithQueryReq extends MyEquatable {
  final String? classId;
  final int? currentSem;
  const AllAttendanceWithQueryReq({
    this.classId,
    this.currentSem,
  });
  @override
  List<Object?> get props => [classId, currentSem];

  Map<String, dynamic> toMap() {
    return {
      if (classId != null) 'classId': classId,
      if (currentSem != null) 'currentSem': currentSem,
    };
  }

  String toJson() => json.encode(toMap());
}

class CreateAttendanceReq extends MyEquatable {
  final String collegeId;
  final String classId;
  final String subjectId;
  final TimeOfDay classStartTime;
  final TimeOfDay classEndTime;
  final List<String> absentStudents;
  final int currentSem;
  final DateTime attendanceTakenOn;
  const CreateAttendanceReq({
    required this.collegeId,
    required this.classId,
    required this.subjectId,
    required this.classStartTime,
    required this.classEndTime,
    required this.absentStudents,
    required this.currentSem,
    required this.attendanceTakenOn,
  });

  Map<String, dynamic> toMap() => {
        'collegeId': collegeId,
        'classId': classId,
        'subjectId': subjectId,
        'classStartTime': '${classStartTime.hour}:${classStartTime.minute}',
        'classEndTime': '${classEndTime.hour}:${classEndTime.minute}',
        'absentStudents': absentStudents,
        'currentSem': currentSem,
        'attendanceTakenOn': attendanceTakenOn.toIso8601String(),
      };
  String toJson() => json.encode(toMap());
}

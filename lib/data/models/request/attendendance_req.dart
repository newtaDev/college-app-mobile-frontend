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
        'classStartTime':
            '${classStartTime.hour.toString().padLeft(2, '0')}:${classStartTime.minute.toString().padLeft(2, '0')}',
        'classEndTime':
            '${classEndTime.hour.toString().padLeft(2, '0')}:${classEndTime.minute.toString().padLeft(2, '0')}',
        'absentStudents': absentStudents,
        'currentSem': currentSem,
        'attendanceTakenOn': attendanceTakenOn.toIso8601String(),
      };
  String toJson() => json.encode(toMap());

  @override
  List<Object> get props {
    return [
      collegeId,
      classId,
      subjectId,
      classStartTime,
      classEndTime,
      absentStudents,
      currentSem,
      attendanceTakenOn,
    ];
  }
}

class UpdateAttendanceReq extends MyEquatable {
  final String attendanceId;
  final String? collegeId;
  final String? classId;
  final String? subjectId;
  final TimeOfDay? classStartTime;
  final TimeOfDay? classEndTime;
  final List<String>? absentStudents;
  final int? currentSem;
  final DateTime? attendanceTakenOn;
  const UpdateAttendanceReq({
    required this.attendanceId,
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
        if (collegeId != null) 'collegeId': collegeId,
        if (classId != null) 'classId': classId,
        if (subjectId != null) 'subjectId': subjectId,
        if (classStartTime != null)
          'classStartTime':
              '${classStartTime!.hour.toString().padLeft(2, '0')}:${classStartTime!.minute.toString().padLeft(2, '0')}',
        if (classEndTime != null)
          'classEndTime':
              '${classEndTime!.hour.toString().padLeft(2, '0')}:${classEndTime!.minute.toString().padLeft(2, '0')}',
        if (absentStudents != null) 'absentStudents': absentStudents,
        if (currentSem != null) 'currentSem': currentSem,
        if (attendanceTakenOn != null)
          'attendanceTakenOn': attendanceTakenOn!.toIso8601String(),
      };
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props {
    return [
      attendanceId,
      collegeId,
      classId,
      subjectId,
      classStartTime,
      classEndTime,
      absentStudents,
      currentSem,
      attendanceTakenOn,
    ];
  }
}

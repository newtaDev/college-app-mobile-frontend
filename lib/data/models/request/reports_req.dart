part of reports_entity;

class EachStudentReportReq {
  final String classId;
  final int currentSem;
  final String subjectId;
  EachStudentReportReq({
    required this.classId,
    required this.currentSem,
    required this.subjectId,
  });

  Map<String, dynamic> toMap() {
    return {
      'classId': classId,
      'currentSem': currentSem,
      'subjectId': subjectId,
    };
  }

  String toJson() => json.encode(toMap());
}

class AbsentClassReportOfStudentReq {
  final String classId;
  final int currentSem;
  final String studentId;
  AbsentClassReportOfStudentReq({
    required this.classId,
    required this.currentSem,
    required this.studentId,
  });

  Map<String, dynamic> toMap() {
    return {
      'classId': classId,
      'currentSem': currentSem,
    };
  }

  String toJson() => json.encode(toMap());
}

class SubjectReportReq {
  final String classId;
  final int currentSem;
  SubjectReportReq({
    required this.classId,
    required this.currentSem,
  });

  Map<String, dynamic> toMap() {
    return {
      'classId': classId,
      'currentSem': currentSem,
    };
  }

  String toJson() => json.encode(toMap());
}

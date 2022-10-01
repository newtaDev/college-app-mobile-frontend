part of 'create_attendance_cubit.dart';

enum CreateAttendanceStatus { initial, loading, success, error }

enum CreateAttendanceValidationStatus {
  success,
  issueInClassTimings,
  issueInSubjects
}

enum StudentsInClasStatus { initial, loading, success, error }

extension CreateAttendanceStatusX on CreateAttendanceStatus {
  bool get isInitial => this == CreateAttendanceStatus.initial;
  bool get isSuccess => this == CreateAttendanceStatus.success;
  bool get isError => this == CreateAttendanceStatus.error;
  bool get isLoading => this == CreateAttendanceStatus.loading;
}

extension StudentsInClasStatusX on StudentsInClasStatus {
  bool get isInitial => this == StudentsInClasStatus.initial;
  bool get isSuccess => this == StudentsInClasStatus.success;
  bool get isError => this == StudentsInClasStatus.error;
  bool get isLoading => this == StudentsInClasStatus.loading;
}

class CreateAttendanceState extends MyEquatable {
  final CreateAttendanceStatus createStatus;
  final StudentsInClasStatus studentsInClasStatus;
  final List<StudentUser> studentsInClass;
  final Subject? selectedSubject;
  final List<String> absentStudentIds;
  final TimeOfDay classStartTime;
  final TimeOfDay classEndTime;
  final DateTime attendanceTakenOn;
  final String classId;
  final String collegeId;
  final String attendanceId;
  final int currentSem;
  final bool? isCreated;
  final ApiErrorRes? error;

  const CreateAttendanceState({
    required this.createStatus,
    required this.studentsInClasStatus,
    required this.studentsInClass,
    this.selectedSubject,
    required this.absentStudentIds,
    required this.classStartTime,
    required this.classEndTime,
    required this.attendanceTakenOn,
    required this.classId,
    required this.collegeId,
    required this.attendanceId,
    required this.currentSem,
    this.isCreated,
    this.error,
  });

  CreateAttendanceState.init()
      : createStatus = CreateAttendanceStatus.initial,
        studentsInClasStatus = StudentsInClasStatus.initial,
        studentsInClass = const [],
        absentStudentIds = const [],
        selectedSubject = null,
        attendanceId = '',
        classId = '',
        currentSem = 0,
        collegeId = '',
        classStartTime = TimeOfDay.now(),
        classEndTime = TimeOfDay.fromDateTime(
          DateTime.now().add(const Duration(hours: 1)),
        ),
        attendanceTakenOn = DateTime.now(),
        error = null,
        isCreated = null;

  @override
  List<Object?> get props {
    return [
      createStatus,
      studentsInClasStatus,
      studentsInClass,
      selectedSubject,
      absentStudentIds,
      classStartTime,
      classEndTime,
      attendanceId,
      isCreated,
      error,
      attendanceTakenOn,
      classId,
      currentSem,
      collegeId,
    ];
  }

  CreateAttendanceState copyWith({
    CreateAttendanceStatus? createStatus,
    StudentsInClasStatus? studentsInClasStatus,
    List<StudentUser>? studentsInClass,
    Subject? selectedSubject,
    List<String>? absentStudentIds,
    TimeOfDay? classStartTime,
    TimeOfDay? classEndTime,
    DateTime? attendanceTakenOn,
    String? classId,
    String? collegeId,
    String? attendanceId,
    int? currentSem,
    bool? isCreated,
    ApiErrorRes? error,
  }) {
    return CreateAttendanceState(
      createStatus: createStatus ?? this.createStatus,
      studentsInClasStatus: studentsInClasStatus ?? this.studentsInClasStatus,
      studentsInClass: studentsInClass ?? this.studentsInClass,
      selectedSubject: selectedSubject ?? this.selectedSubject,
      absentStudentIds: absentStudentIds ?? this.absentStudentIds,
      classStartTime: classStartTime ?? this.classStartTime,
      classEndTime: classEndTime ?? this.classEndTime,
      attendanceTakenOn: attendanceTakenOn ?? this.attendanceTakenOn,
      classId: classId ?? this.classId,
      collegeId: collegeId ?? this.collegeId,
      attendanceId: attendanceId ?? this.attendanceId,
      currentSem: currentSem ?? this.currentSem,
      isCreated: isCreated ?? this.isCreated,
      error: error ?? this.error,
    );
  }
}

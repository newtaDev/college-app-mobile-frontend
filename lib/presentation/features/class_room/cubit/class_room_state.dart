part of 'class_room_cubit.dart';

enum ClassRoomStatus { initial, loading, success, error }

extension ClassRoomStatusX on ClassRoomStatus {
  bool get isInitial => this == ClassRoomStatus.initial;
  bool get isSuccess => this == ClassRoomStatus.success;
  bool get isError => this == ClassRoomStatus.error;
  bool get isLoading => this == ClassRoomStatus.loading;
}

class ClassRoomState extends Equatable {
  final ApiErrorRes? error;
  final ClassRoomStatus mySubjectStatus;
  final ClassRoomStatus allSubjectResourcesStatus;
  final ClassRoomStatus subjectResourceDetailsStatus;
  final List<Subject> mySubjects;
  final List<SubjectResource> allSubjectResources;
  final SubjectResource? subjectResourceDetails;

  const ClassRoomState({
    this.error,
    required this.mySubjectStatus,
    required this.allSubjectResourcesStatus,
    required this.subjectResourceDetailsStatus,
    required this.mySubjects,
    required this.allSubjectResources,
    required this.subjectResourceDetails,
  });

  const ClassRoomState.init()
      : mySubjectStatus = ClassRoomStatus.initial,
        allSubjectResourcesStatus = ClassRoomStatus.initial,
        subjectResourceDetailsStatus = ClassRoomStatus.initial,
        mySubjects = const [],
        allSubjectResources = const [],
        subjectResourceDetails = null,
        error = null;

  @override
  List<Object?> get props {
    return [
      error,
      mySubjectStatus,
      allSubjectResourcesStatus,
      subjectResourceDetailsStatus,
      mySubjects,
      allSubjectResources,
      subjectResourceDetails,
    ];
  }

  ClassRoomState copyWith({
    ApiErrorRes? error,
    ClassRoomStatus? mySubjectStatus,
    ClassRoomStatus? allSubjectResourcesStatus,
    ClassRoomStatus? subjectResourceDetailsStatus,
    List<Subject>? mySubjects,
    List<SubjectResource>? allSubjectResources,
    SubjectResource? subjectResourceDetails,
  }) {
    return ClassRoomState(
      error: error ?? this.error,
      mySubjectStatus: mySubjectStatus ?? this.mySubjectStatus,
      allSubjectResourcesStatus:
          allSubjectResourcesStatus ?? this.allSubjectResourcesStatus,
      subjectResourceDetailsStatus:
          subjectResourceDetailsStatus ?? this.subjectResourceDetailsStatus,
      mySubjects: mySubjects ?? this.mySubjects,
      allSubjectResources: allSubjectResources ?? this.allSubjectResources,
      subjectResourceDetails:
          subjectResourceDetails ?? this.subjectResourceDetails,
    );
  }
}

part of 'class_room_cubit.dart';

enum ClassRoomStatus { initial, loading, success, error }

enum UploadingResourcesStatus { initial, uploading, uploaded, error }

extension ClassRoomStatusX on ClassRoomStatus {
  bool get isInitial => this == ClassRoomStatus.initial;
  bool get isSuccess => this == ClassRoomStatus.success;
  bool get isError => this == ClassRoomStatus.error;
  bool get isLoading => this == ClassRoomStatus.loading;
}

extension UploadingResourcesStatusX on UploadingResourcesStatus {
  bool get isInitial => this == UploadingResourcesStatus.initial;
  bool get isUploaded => this == UploadingResourcesStatus.uploaded;
  bool get isError => this == UploadingResourcesStatus.error;
  bool get isUploading => this == UploadingResourcesStatus.uploading;
}

class ClassRoomState extends Equatable {
  final ApiErrorRes? error;
  final ClassRoomStatus mySubjectStatus;
  final ClassRoomStatus allSubjectResourcesStatus;
  final ClassRoomStatus subjectResourceDetailsStatus;
  final UploadingResourcesStatus uploadingResourcesStatus;
  final ClassRoomStatus commentStatus;
  final List<Subject> mySubjects;
  final List<PlatformFile> uploadingAttachments;
  final List<SubjectResource> allSubjectResources;
  final List<DowloadingAttachment> downloadingAttachments;
  final SubjectResource? subjectResourceDetails;

  const ClassRoomState({
    this.error,
    required this.mySubjectStatus,
    required this.allSubjectResourcesStatus,
    required this.subjectResourceDetailsStatus,
    required this.uploadingResourcesStatus,
    required this.commentStatus,
    required this.mySubjects,
    required this.uploadingAttachments,
    required this.allSubjectResources,
    required this.downloadingAttachments,
    required this.subjectResourceDetails,
  });

  const ClassRoomState.init()
      : mySubjectStatus = ClassRoomStatus.initial,
        allSubjectResourcesStatus = ClassRoomStatus.initial,
        subjectResourceDetailsStatus = ClassRoomStatus.initial,
        uploadingResourcesStatus = UploadingResourcesStatus.initial,
        commentStatus = ClassRoomStatus.initial,
        mySubjects = const [],
        uploadingAttachments = const [],
        downloadingAttachments = const [],
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
      uploadingResourcesStatus,
      commentStatus,
      mySubjects,
      uploadingAttachments,
      allSubjectResources,
      downloadingAttachments,
      subjectResourceDetails,
    ];
  }

  ClassRoomState copyWith({
    ApiErrorRes? error,
    ClassRoomStatus? mySubjectStatus,
    ClassRoomStatus? allSubjectResourcesStatus,
    ClassRoomStatus? subjectResourceDetailsStatus,
    UploadingResourcesStatus? uploadingResourcesStatus,
    ClassRoomStatus? commentStatus,
    List<Subject>? mySubjects,
    List<PlatformFile>? uploadingAttachments,
    List<SubjectResource>? allSubjectResources,
    List<DowloadingAttachment>? downloadingAttachments,
    SubjectResource? subjectResourceDetails,
  }) {
    return ClassRoomState(
      error: error ?? this.error,
      mySubjectStatus: mySubjectStatus ?? this.mySubjectStatus,
      allSubjectResourcesStatus: allSubjectResourcesStatus ?? this.allSubjectResourcesStatus,
      subjectResourceDetailsStatus: subjectResourceDetailsStatus ?? this.subjectResourceDetailsStatus,
      uploadingResourcesStatus: uploadingResourcesStatus ?? this.uploadingResourcesStatus,
      commentStatus: commentStatus ?? this.commentStatus,
      mySubjects: mySubjects ?? this.mySubjects,
      uploadingAttachments: uploadingAttachments ?? this.uploadingAttachments,
      allSubjectResources: allSubjectResources ?? this.allSubjectResources,
      downloadingAttachments: downloadingAttachments ?? this.downloadingAttachments,
      subjectResourceDetails: subjectResourceDetails ?? this.subjectResourceDetails,
    );
  }
}

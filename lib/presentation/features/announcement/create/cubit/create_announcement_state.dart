part of 'create_announcement_cubit.dart';

enum CreateAnnouncementStatus { initial, loading, success, error }

enum CreateAnnouncementValidationStatus {
  success,
  issueInMultiImage,
  issueInSingleImage,
  issueInAnounceToClasses
}

extension CreateAnnouncementStatusX on CreateAnnouncementStatus {
  bool get isInitial => this == CreateAnnouncementStatus.initial;
  bool get isSuccess => this == CreateAnnouncementStatus.success;
  bool get isError => this == CreateAnnouncementStatus.error;
  bool get isLoading => this == CreateAnnouncementStatus.loading;
}

class CreateAnnouncementState extends Equatable {
  final AnnouncementLayoutType layoutType;
  final AnounceTo anounceTo;
  final List<ClassWithDetails> selectedClasses;
  final String? title;
  final String? description;
  final List<File> multiImages;
  final File? image;
  final CreateAnnouncementStatus status;
  final ApiErrorRes? error;

  const CreateAnnouncementState({
    required this.layoutType,
    required this.anounceTo,
    required this.selectedClasses,
    this.title,
    this.description,
    required this.multiImages,
    this.image,
    required this.status,
    this.error,
  });

  const CreateAnnouncementState.init()
      : anounceTo = AnounceTo.students,
        status = CreateAnnouncementStatus.initial,
        selectedClasses = const [],
        title = null,
        description = null,
        multiImages = const [],
        image = null,
        error = null,
        layoutType = AnnouncementLayoutType.onlyText;

  @override
  List<Object?> get props => [
        layoutType,
        anounceTo,
        selectedClasses,
        title,
        description,
        multiImages,
        image,
        status,
        error,
      ];

  CreateAnnouncementState copyWith({
    AnnouncementLayoutType? layoutType,
    AnounceTo? anounceTo,
    List<ClassWithDetails>? selectedClasses,
    String? title,
    String? description,
    List<File>? multiImages,
    File? image,
    CreateAnnouncementStatus? status,
    ApiErrorRes? error,
  }) {
    return CreateAnnouncementState(
      layoutType: layoutType ?? this.layoutType,
      anounceTo: anounceTo ?? this.anounceTo,
      selectedClasses: selectedClasses ?? this.selectedClasses,
      title: title ?? this.title,
      description: description ?? this.description,
      multiImages: multiImages ?? this.multiImages,
      image: image ?? this.image,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  CreateAnnouncementState removeSingleImage() {
    return CreateAnnouncementState(
      layoutType: layoutType,
      anounceTo: anounceTo,
      selectedClasses: selectedClasses,
      title: title,
      description: description,
      multiImages: multiImages,
      // image: null,
      status: status,
      error: error,
    );
  }
}

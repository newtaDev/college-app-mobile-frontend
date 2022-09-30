part of 'create_anouncement_cubit.dart';

enum CreateAnouncementStatus { initial, loading, success, error }

enum CreateAnouncementValidationStatus {
  success,
  issueInMultiImage,
  issueInSingleImage,
  issueInAnounceToClasses
}

extension CreateAnouncementStatusX on CreateAnouncementStatus {
  bool get isInitial => this == CreateAnouncementStatus.initial;
  bool get isSuccess => this == CreateAnouncementStatus.success;
  bool get isError => this == CreateAnouncementStatus.error;
  bool get isLoading => this == CreateAnouncementStatus.loading;
}

class CreateAnouncementState extends Equatable {
  final AnouncementLayoutType layoutType;
  final AnounceTo anounceTo;
  final List<ClassWithDetails> selectedClasses;
  final String? title;
  final String? description;
  final List<File> multiImages;
  final File? image;
  final CreateAnouncementStatus status;
  final ApiErrorRes? error;

  const CreateAnouncementState({
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

  const CreateAnouncementState.init()
      : anounceTo = AnounceTo.students,
        status = CreateAnouncementStatus.initial,
        selectedClasses = const [],
        title = null,
        description = null,
        multiImages = const [],
        image = null,
        error = null,
        layoutType = AnouncementLayoutType.onlyText;

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

  CreateAnouncementState copyWith({
    AnouncementLayoutType? layoutType,
    AnounceTo? anounceTo,
    List<ClassWithDetails>? selectedClasses,
    String? title,
    String? description,
    List<File>? multiImages,
    File? image,
    CreateAnouncementStatus? status,
    ApiErrorRes? error,
  }) {
    return CreateAnouncementState(
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

  CreateAnouncementState removeSingleImage() {
    return CreateAnouncementState(
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

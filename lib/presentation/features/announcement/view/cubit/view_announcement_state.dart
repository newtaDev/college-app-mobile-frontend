part of 'view_announcement_cubit.dart';

enum ViewAnnouncementStatus { initial, loading, success, error }

extension ViewAnnouncementStatusX on ViewAnnouncementStatus {
  bool get isInitial => this == ViewAnnouncementStatus.initial;
  bool get isSuccess => this == ViewAnnouncementStatus.success;
  bool get isError => this == ViewAnnouncementStatus.error;
  bool get isLoading => this == ViewAnnouncementStatus.loading;
}

class ViewAnnouncementState extends MyEquatable {
  final List<AnnouncementModel> allAnnouncementModels;
  final List<AnnouncementModel> myAnnouncementModels;
  final ViewAnnouncementStatus allStatus;
  final ViewAnnouncementStatus myStatus;
  final ApiErrorRes? error;

  const ViewAnnouncementState({
    required this.allAnnouncementModels,
    required this.myAnnouncementModels,
    required this.allStatus,
    required this.myStatus,
    this.error,
  });
  const ViewAnnouncementState.init()
      : allAnnouncementModels = const [],
        myAnnouncementModels = const [],
        allStatus = ViewAnnouncementStatus.initial,
        myStatus = ViewAnnouncementStatus.initial,
        error = null;

  @override
  List<Object?> get props => [
        allAnnouncementModels,
        allStatus,
        myStatus,
        error,
        myAnnouncementModels,
      ];

  ViewAnnouncementState copyWith({
    List<AnnouncementModel>? allAnnouncementModels,
    List<AnnouncementModel>? myAnnouncementModels,
    ViewAnnouncementStatus? allStatus,
    ViewAnnouncementStatus? myStatus,
    ApiErrorRes? error,
  }) {
    return ViewAnnouncementState(
      allAnnouncementModels: allAnnouncementModels ?? this.allAnnouncementModels,
      myAnnouncementModels: myAnnouncementModels ?? this.myAnnouncementModels,
      allStatus: allStatus ?? this.allStatus,
      myStatus: myStatus ?? this.myStatus,
      error: error ?? this.error,
    );
  }
}

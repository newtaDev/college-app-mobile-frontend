part of 'view_anouncement_cubit.dart';

enum ViewAnouncementStatus { initial, loading, success, error }

extension ViewAnouncementStatusX on ViewAnouncementStatus {
  bool get isInitial => this == ViewAnouncementStatus.initial;
  bool get isSuccess => this == ViewAnouncementStatus.success;
  bool get isError => this == ViewAnouncementStatus.error;
  bool get isLoading => this == ViewAnouncementStatus.loading;
}
class ViewAnouncementState extends MyEquatable {
  final List<AnouncementModel> allAnouncementModels;
  final List<AnouncementModel> myAnouncementModels;
  final ViewAnouncementStatus allStatus;
  final ViewAnouncementStatus myStatus;
  final ApiErrorRes? error;

  const ViewAnouncementState({
    required this.allAnouncementModels,
    required this.myAnouncementModels,
    required this.allStatus,
    required this.myStatus,
    this.error,
  });
  const ViewAnouncementState.init()
      : allAnouncementModels = const [],
        myAnouncementModels = const [],
        allStatus = ViewAnouncementStatus.initial,
        myStatus = ViewAnouncementStatus.initial,
        error = null;

  @override
  List<Object?> get props => [
        allAnouncementModels,
        allStatus,
        myStatus,
        error,
        myAnouncementModels,
      ];

  ViewAnouncementState copyWith({
    List<AnouncementModel>? allAnouncementModels,
    List<AnouncementModel>? myAnouncementModels,
    ViewAnouncementStatus? allStatus,
    ViewAnouncementStatus? myStatus,
    ApiErrorRes? error,
  }) {
    return ViewAnouncementState(
      allAnouncementModels: allAnouncementModels ?? this.allAnouncementModels,
      myAnouncementModels: myAnouncementModels ?? this.myAnouncementModels,
      allStatus: allStatus ?? this.allStatus,
      myStatus: myStatus ?? this.myStatus,
      error: error ?? this.error,
    );
  }
}

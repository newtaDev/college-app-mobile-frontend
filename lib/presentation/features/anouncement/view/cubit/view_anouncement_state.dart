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
  final ViewAnouncementStatus status;
  final ApiErrorRes? error;

  const ViewAnouncementState({
    required this.allAnouncementModels,
    required this.myAnouncementModels,
    required this.status,
    this.error,
  });
  const ViewAnouncementState.init()
      : allAnouncementModels = const [],
        myAnouncementModels = const [],
        status = ViewAnouncementStatus.initial,
        error = null;

  @override
  List<Object?> get props => [
        allAnouncementModels,
        status,
        error,
        myAnouncementModels,
      ];

  ViewAnouncementState copyWith({
    List<AnouncementModel>? allAnouncementModels,
    List<AnouncementModel>? myAnouncementModels,
    ViewAnouncementStatus? status,
    ApiErrorRes? error,
  }) {
    return ViewAnouncementState(
      allAnouncementModels: allAnouncementModels ?? this.allAnouncementModels,
      myAnouncementModels: myAnouncementModels ?? this.myAnouncementModels,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

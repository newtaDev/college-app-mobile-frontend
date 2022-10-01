part of 'view_anouncement_cubit.dart';

enum ViewAnouncementStatus { initial, loading, success, error }

class ViewAnouncementState extends MyEquatable {
  final List<AnouncementModel> anouncementModels;
  final ViewAnouncementStatus status;
  final ApiErrorRes? error;

  const ViewAnouncementState({
    required this.anouncementModels,
    required this.status,
    this.error,
  });
  const ViewAnouncementState.init()
      : anouncementModels = const [],
        status = ViewAnouncementStatus.initial,
        error = null;

  @override
  List<Object?> get props => [anouncementModels, status, error];

  ViewAnouncementState copyWith({
    List<AnouncementModel>? anouncementModels,
    ViewAnouncementStatus? status,
    ApiErrorRes? error,
  }) {
    return ViewAnouncementState(
      anouncementModels: anouncementModels ?? this.anouncementModels,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

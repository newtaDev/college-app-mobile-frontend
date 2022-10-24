part of 'downloads_cubit.dart';

enum DownloadsStatus { initial, loading, success, error }

extension DownloadsStatusX on DownloadsStatus {
  bool get isInitial => this == DownloadsStatus.initial;
  bool get isSuccess => this == DownloadsStatus.success;
  bool get isError => this == DownloadsStatus.error;
  bool get isLoading => this == DownloadsStatus.loading;
}

class DownloadsState extends Equatable {
  final List<Downloads> downloads;
  final DownloadsStatus status;
  final ApiErrorRes? error;
  const DownloadsState({
    required this.downloads,
    required this.status,
    this.error,
  });
  const DownloadsState.init()
      : downloads = const [],
        status = DownloadsStatus.initial,
        error = null;

  @override
  List<Object?> get props => [downloads, status, error];

  DownloadsState copyWith({
    List<Downloads>? downloads,
    DownloadsStatus? status,
    ApiErrorRes? error,
  }) {
    return DownloadsState(
      downloads: downloads ?? this.downloads,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

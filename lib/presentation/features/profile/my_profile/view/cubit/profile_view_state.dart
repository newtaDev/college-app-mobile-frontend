part of 'profile_view_cubit.dart';

enum ProfileViewStatus { initial, loading, success, error }

extension ProfileViewStatusX on ProfileViewStatus {
  bool get isInitial => this == ProfileViewStatus.initial;
  bool get isSuccess => this == ProfileViewStatus.success;
  bool get isError => this == ProfileViewStatus.error;
  bool get isLoading => this == ProfileViewStatus.loading;
}

class ProfileViewState extends MyEquatable {
  final UserDetails? userDetails;
  final ProfileViewStatus status;
  final ApiErrorRes? error;
  const ProfileViewState({
    required this.status,
    this.userDetails,
    this.error,
  });
  const ProfileViewState.init()
      : userDetails = null,
        error = null,
        status = ProfileViewStatus.initial;

  ProfileViewState copyWith({
    UserDetails? userDetails,
    ProfileViewStatus? status,
    ApiErrorRes? error,
  }) {
    return ProfileViewState(
      userDetails: userDetails ?? this.userDetails,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
  @override
  List<Object?> get props => [userDetails, status, error];
}

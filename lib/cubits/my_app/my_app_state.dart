part of 'my_app_cubit.dart';

enum SplashStatus {
  loading,
  sessionExpired,
  failed,
  neverLogedIn,
  loginSuccess
}

class MyAppState extends Equatable {
  final SplashStatus splashStatus;

  const MyAppState(this.splashStatus);
  const MyAppState.init() : splashStatus = SplashStatus.loading;

  @override
  List<Object> get props => [splashStatus];

  MyAppState copyWith({
    SplashStatus? splashStatus,
  }) {
    return MyAppState(
      splashStatus ?? this.splashStatus,
    );
  }
}

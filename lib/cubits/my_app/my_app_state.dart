part of 'my_app_cubit.dart';

enum SplashStatus {
  loading,
  sessionExpired,
  invalidUser,
  failed,
  neverLogedIn,
  loginSuccess
}

enum PageRefresherStatus { initial, refreshViewAttendancePage }

class MyAppState extends MyEquatable {
  final SplashStatus splashStatus;
  final PageRefresherStatus pageRefresherStatus;

  const MyAppState(
    this.splashStatus,
    this.pageRefresherStatus,
  );
  const MyAppState.init()
      : splashStatus = SplashStatus.loading,
        pageRefresherStatus = PageRefresherStatus.initial;

  @override
  List<Object> get props => [splashStatus, pageRefresherStatus];

  MyAppState copyWith({
    SplashStatus? splashStatus,
    PageRefresherStatus? pageRefresherStatus,
  }) {
    return MyAppState(
      splashStatus ?? this.splashStatus,
      pageRefresherStatus ?? this.pageRefresherStatus,
    );
  }
}

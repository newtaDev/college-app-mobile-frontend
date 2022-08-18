part of 'auth_cubit.dart';

enum AuthStatus {
  initial,
  loading,
  logedIn,
  logedOut,
  failure,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthRes? authRes;
  final ApiErrorRes? error;
  const AuthState(
    this.status,
    this.authRes,
    this.error,
  );
  const AuthState.init()
      : authRes = null,
        error = null,
        status = AuthStatus.initial;
  @override
  List<Object?> get props => [status, authRes, error];

  AuthState copyWith({
    AuthStatus? status,
    AuthRes? authRes,
    ApiErrorRes? error,
  }) {
    return AuthState(
      status ?? this.status,
      authRes ?? this.authRes,
      error ?? this.error,
    );
  }
}

part of 'signin_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitialState extends SignInState {
  const SignInInitialState();
}

class SignInLoadingState extends SignInState {
  const SignInLoadingState();
}

class SignInSuccessState extends SignInState {
  final AuthRes data;
  const SignInSuccessState({
    required this.data,
  });
  @override
  List<Object> get props => [data];
}

class SignInErrorState extends SignInState {
  final ApiErrorRes error;
  const SignInErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

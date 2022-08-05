part of 'signup_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitialState extends SignUpState {
  const SignUpInitialState();
}

class SignUpLoadingState extends SignUpState {
  const SignUpLoadingState();
}

class SignUpSuccessState extends SignUpState {
  final AuthRes data;
  const SignUpSuccessState({
    required this.data,
  });
  @override
  List<Object> get props => [data];
}

class SignUpErrorState extends SignUpState {
  final ApiErrorRes error;
  const SignUpErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

part of 'my_app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class SplashLoading extends AppState {}

class SplashLoadingDone extends AppState {}

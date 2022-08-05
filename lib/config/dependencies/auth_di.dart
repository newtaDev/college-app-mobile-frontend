part of app_dependencies;

void registerAuthDependencies() {
  getIt
    ..registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSource())
    ..registerSingleton<AuthRepository>(AuthRepoImpl())
    ..registerSingleton<AuthUseCase>(
      AuthUseCase(authRepo: getIt<AuthRepository>()),
    )
    ..registerFactory<SignInCubit>(
      () => SignInCubit(useCase: getIt<AuthUseCase>()),
    )
    ..registerFactory<SignUpCubit>(
      () => SignUpCubit(useCase: getIt<AuthUseCase>()),
    );
}

part of app_dependencies;

void registerAuthDependencies() {
  getIt
    ..registerFactory<AuthCubit>(AuthCubit.new)
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

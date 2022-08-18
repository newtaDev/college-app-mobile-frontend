part of app_dependencies;

void registerAuthDependencies() {
  getIt

    /// repos
    ..registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSource())
    ..registerSingleton<AuthLocalDataSource>(AuthLocalDataSource())
    ..registerSingleton<AuthRepository>(
      AuthRepoImpl(
        authLds: getIt<AuthLocalDataSource>(),
        authRds: getIt<AuthRemoteDataSource>(),
      ),
    )
    ..registerSingleton<TokenRemoteDataSource>(TokenRemoteDataSource())
    ..registerSingleton<TokenRepository>(
      TokenRepoImpl(
        tokenRds: getIt<TokenRemoteDataSource>(),
        authLds: getIt<AuthLocalDataSource>(),
      ),
    )

    /// usecases
    ..registerSingleton<AuthUseCase>(
      AuthUseCase(authRepo: getIt<AuthRepository>()),
    )

    /// Cubits
    ..registerFactory<AuthCubit>(
      () => AuthCubit(usecase: getIt<AuthUseCase>()),
    );
}

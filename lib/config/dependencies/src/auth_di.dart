part of app_dependencies;

void registerAuthAndProfileDependencies() {
  getIt

    /// repos
    ..registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSource())
    ..registerSingleton<AuthLocalDataSource>(AuthLocalDataSource())
    ..registerSingleton<AuthRepoImpl>(
      AuthRepoImpl(
        authLds: getIt<AuthLocalDataSource>(),
        authRds: getIt<AuthRemoteDataSource>(),
      ),
    )
    ..registerSingleton<TokenRemoteDataSource>(TokenRemoteDataSource())
    ..registerSingleton<TokenRepoImpl>(
      TokenRepoImpl(
        tokenRds: getIt<TokenRemoteDataSource>(),
        authLds: getIt<AuthLocalDataSource>(),
      ),
    );

  /// profile dependency
  registerProfileDependencies();

  /// Cubits
  getIt.registerSingleton<AuthCubit>(
    AuthCubit(
      authRepo: getIt<AuthRepoImpl>(),
      myProfileCubit: getIt<MyProfileCubit>(),
    ),
  );
}

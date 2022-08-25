part of app_dependencies;

void registerHomeDependecies() {
  getIt
    ..registerSingleton<HomeCubit>(HomeCubit())
    ..registerSingleton<MyAppCubit>(
      MyAppCubit(
        tokenRepo: getIt<TokenRepoImpl>(),
        userCubit: getIt<UserCubit>(),
        authLds: getIt<AuthLocalDataSource>(),
      ),
    );
}

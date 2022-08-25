part of app_dependencies;

void registerHomeDependecies() {
  getIt
    ..registerSingleton<HomeCubit>(HomeCubit())
    ..registerSingleton<MyAppCubit>(
      MyAppCubit(
        tokenRepo: getIt<TokenRepoImpl>(),
        profileRepo: getIt<ProfileRepoImpl>(),
        profileCubit: getIt<MyProfileCubit>(),
        authLds: getIt<AuthLocalDataSource>(),
      ),
    );
}

part of app_dependencies;

void registerUserDependencies() {
  getIt
    ..registerSingleton<UserRemoteDataSource>(UserRemoteDataSource())
    ..registerSingleton<UserRepoImpl>(
      UserRepoImpl(userRds: getIt<UserRemoteDataSource>()),
    )
    ..registerSingleton<UserCubit>(
      UserCubit(
        userRepo: getIt<UserRepoImpl>(),
      ),
    );
}

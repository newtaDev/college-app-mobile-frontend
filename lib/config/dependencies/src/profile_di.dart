part of app_dependencies;

void registerProfileDependencies() {
  getIt
    ..registerSingleton<ProfileRemoteDataSource>(ProfileRemoteDataSource())
    ..registerSingleton<ProfileRepoImpl>(
      ProfileRepoImpl(profileRds: getIt<ProfileRemoteDataSource>()),
    )
    ..registerSingleton<MyProfileCubit>(
      MyProfileCubit(
        authLds: getIt<AuthLocalDataSource>(),
        profileRepo: getIt<ProfileRepoImpl>(),
      ),
    );
}

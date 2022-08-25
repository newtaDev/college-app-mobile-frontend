part of app_dependencies;

void registerCommonDependencies() {
  getIt
    ..registerSingleton<CommonRemoteDataSource>(CommonRemoteDataSource())
    ..registerSingleton<CommonRepoImpl>(
      CommonRepoImpl(commonRds: getIt<CommonRemoteDataSource>()),
    )
    ..registerSingleton<SelectClassAndSemCubit>(
      SelectClassAndSemCubit(commonRepo: getIt<CommonRepoImpl>()),
    );
}

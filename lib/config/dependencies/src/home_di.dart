part of app_dependencies;

void registerHomeDependecies() {
  getIt
    ..registerFactory<HomeCubit>(HomeCubit.new)
    ..registerFactory<MyAppCubit>(
      () => MyAppCubit(
        tokenRepo: getIt<TokenRepoImpl>(),
      ),
    );
}

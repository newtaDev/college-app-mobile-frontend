part of app_dependencies;

void registerCommonDependencies() {
  getIt.registerFactory<SelectClassAndSemCubit>(SelectClassAndSemCubit.new);
}

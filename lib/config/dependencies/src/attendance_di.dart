part of app_dependencies;

void registerReportsDependencies() {
  getIt
    ..registerSingleton(ReportsRemoteDataSource())
    ..registerSingleton<ReportsRepoImpl>(
      ReportsRepoImpl(
        attendanceRds: getIt<ReportsRemoteDataSource>(),
      ),
    )
    ..registerFactory(
      () => AttendanceReportCubit(
        attendanceRepo: getIt<ReportsRepoImpl>(),
      ),
    );
}

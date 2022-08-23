part of app_dependencies;

void registerReportsDependencies() {
  getIt
    ..registerSingleton(AttendannceRemoteDataSource())
    ..registerSingleton<AttendanceRepoImpl>(
      AttendanceRepoImpl(
        attendanceRds: getIt<AttendannceRemoteDataSource>(),
      ),
    )
    ..registerFactory(
      () => AttendanceReportCubit(
        attendanceRepo: getIt<AttendanceRepoImpl>(),
      ),
    )
    ..registerFactory(
      () => AttendanceViewCubit(attendanceRepo: getIt<AttendanceRepoImpl>()),
    );
}

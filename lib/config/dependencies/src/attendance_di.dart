part of app_dependencies;

void registerAttendanceDependencies() {
  getIt
    ..registerSingleton(AttendanceRemoteDataSource())
    ..registerSingleton<AttendanceRepoImpl>(
      AttendanceRepoImpl(
        attendanceRds: getIt<AttendanceRemoteDataSource>(),
      ),
    )
    ..registerFactory(
      () => AttendanceReportCubit(
        attendanceRepo: getIt<AttendanceRepoImpl>(),
      ),
    );
}

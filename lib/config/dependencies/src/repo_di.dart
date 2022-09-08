part of app_dependencies;

void registerRepositoryDependencies() {
  getIt

    /// Auth
    ..registerSingleton<TokenRepoImpl>(
      TokenRepoImpl(
        tokenRds: getIt<TokenRemoteDataSource>(),
        authLds: getIt<AuthLocalDataSource>(),
      ),
    )
    ..registerSingleton<AuthRepoImpl>(
      AuthRepoImpl(
        authLds: getIt<AuthLocalDataSource>(),
        authRds: getIt<AuthRemoteDataSource>(),
      ),
    )

    /// Attendance
    ..registerSingleton<AttendanceRepoImpl>(
      AttendanceRepoImpl(
        attendanceRds: getIt<AttendannceRemoteDataSource>(),
        studentRds: getIt<UserRemoteDataSource>(),
      ),
    )

    /// Common
    ..registerSingleton<CommonRepoImpl>(
      CommonRepoImpl(
        commonRds: getIt<CommonRemoteDataSource>(),
        userRds: getIt<UserRemoteDataSource>(),
      ),
    )

    /// Profile
    ..registerSingleton<ProfileRepoImpl>(
      ProfileRepoImpl(
        userRds: getIt<UserRemoteDataSource>(),
      ),
    );
}

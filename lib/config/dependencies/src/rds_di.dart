part of app_dependencies;

void registerRemoteDataSourceDependencies() {
  getIt

    /// Attendance
    ..registerSingleton(AttendannceRemoteDataSource())

    /// Token
    ..registerSingleton<TokenRemoteDataSource>(TokenRemoteDataSource())

    /// Common
    ..registerSingleton<CommonRemoteDataSource>(CommonRemoteDataSource())

    /// Common
    ..registerSingleton<StudentRemoteDataSource>(StudentRemoteDataSource())

    /// Auth
    ..registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSource())
    ..registerSingleton<AuthLocalDataSource>(AuthLocalDataSource());
}

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
    ..registerSingleton<UserRemoteDataSource>(UserRemoteDataSource())

    /// Auth
    ..registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSource())
    ..registerSingleton<AuthLocalDataSource>(AuthLocalDataSource())

    // Time table
    ..registerSingleton<TimeTableRemoteDataSource>(TimeTableRemoteDataSource())
    // Announcements
    ..registerSingleton<AnnouncementRemoteDataSource>(
      AnnouncementRemoteDataSource(),
    );
}

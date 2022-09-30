part of app_dependencies;

void registerCubitsDependencies() {
  getIt

    /// Common
    ..registerSingleton<UserCubit>(
      UserCubit(commonRepo: getIt<CommonRepoImpl>()),
    )
    ..registerSingleton<SelectionCubit>(
      SelectionCubit(commonRepo: getIt<CommonRepoImpl>()),
    )

    /// Auth
    ..registerSingleton<AuthCubit>(
      AuthCubit(
        authRepo: getIt<AuthRepoImpl>(),
        userCubit: getIt<UserCubit>(),
      ),
    )

    /// Attendance
    ..registerFactory(
      () => ClassAttendanceReportCubit(
        attendanceRepo: getIt<AttendanceRepoImpl>(),
      ),
    )
    ..registerFactory(
      () => StudentAttendanceReportCubit(
        attendanceRepo: getIt<AttendanceRepoImpl>(),
      ),
    )
    ..registerFactory(
      () => ViewAttendanceCubit(attendanceRepo: getIt<AttendanceRepoImpl>()),
    )
    ..registerFactory(
      () => CreateAttendanceCubit(attendanceRepo: getIt<AttendanceRepoImpl>()),
    )

    /// home
    ..registerSingleton<HomeCubit>(HomeCubit())
    ..registerSingleton<MyAppCubit>(
      MyAppCubit(
        tokenRepo: getIt<TokenRepoImpl>(),
        userCubit: getIt<UserCubit>(),
        authLds: getIt<AuthLocalDataSource>(),
      ),
    )

    /// Profile
    ..registerFactory(
      () => MyProfileEditCubit(
        profileRepo: getIt<ProfileRepoImpl>(),
        userCubit: getIt<UserCubit>(),
      ),
    )
    ..registerFactory(
      () => ProfileViewCubit(
        userCubit: getIt<UserCubit>(),
        profileRepo: getIt<ProfileRepoImpl>(),
      ),
    )

    /// Time table
    ..registerFactory(
      () => ClassTimeTableCubit(
        timeTableRepo: getIt<TimeTableRepoImpl>(),
      ),
    )

    /// Anouncement
    ..registerFactory(
      () => CreateAnouncementCubit(
        anouncementRepo: getIt<AnouncementRepoImpl>(),
        userCubit: getIt<UserCubit>(),

      ),
    );
}

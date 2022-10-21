part of app_dependencies;

void registerCubitsDependencies() {
  getIt

    /// Common
    ..registerSingleton<UserCubit>(
      UserCubit(commonRepo: getIt<CommonRepoImpl>()),
    )
    ..registerSingleton<SelectionCubit>(
      SelectionCubit(
        commonRepo: getIt<CommonRepoImpl>(),
        userCubit: getIt<UserCubit>(),
      ),
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
        selectionCubit: getIt<SelectionCubit>(),
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
      () => CreateAttendanceCubit(
        attendanceRepo: getIt<AttendanceRepoImpl>(),
        selectionCubit: getIt<SelectionCubit>(),
      ),
    )

    /// home
    ..registerSingleton<HomeCubit>(HomeCubit())
    ..registerSingleton<MyAppCubit>(
      MyAppCubit(
        tokenRepo: getIt<TokenRepoImpl>(),
        userCubit: getIt<UserCubit>(),
        selectionCubit: getIt<SelectionCubit>(),
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
    ..registerFactory(
      () => SearchUserProfileCubit(
        profileRepo: getIt<ProfileRepoImpl>(),
      ),
    )

    /// Time table
    ..registerFactory(
      () => ClassTimeTableCubit(
        timeTableRepo: getIt<TimeTableRepoImpl>(),
      ),
    )

    /// Announcement
    ..registerFactory(
      () => CreateAnnouncementCubit(
        announcementRepo: getIt<AnnouncementRepoImpl>(),
        userCubit: getIt<UserCubit>(),
      ),
    )
    ..registerFactory(
      () => ClassRoomCubit(
        userCubit: getIt<UserCubit>(),
        classRoomRepo: getIt<ClassRoomRepoImpl>(),
        commonRepo: getIt<CommonRepoImpl>(),
      ),
    )
    ..registerFactory(
      () => ViewAnnouncementCubit(
        announcementRepo: getIt<AnnouncementRepoImpl>(),
        userCubit: getIt<UserCubit>(),
      ),
    );
}

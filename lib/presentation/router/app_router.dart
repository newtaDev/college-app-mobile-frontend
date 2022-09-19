import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_config.dart';
import '../../cubits/user/user_cubit.dart';
import '../../domain/entities/attendance_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../shared/global/enums.dart';
import '../features/_init_/T&W_showcase/colors_page.dart';
import '../features/_init_/T&W_showcase/t_w_showcase_page.dart';
import '../features/_init_/T&W_showcase/typography_page.dart';
import '../features/_init_/T&W_showcase/widgets_page.dart';
import '../features/_init_/splash/splash_screen.dart';
import '../features/attendance/create_attendance/cubit/create_attendance_cubit.dart';
import '../features/attendance/create_attendance/page/create_attendance_page.dart';
import '../features/attendance/view_attendance/cubit/view_attendance_cubit.dart';
import '../features/attendance/view_attendance/view_attendance_page.dart';
import '../features/auth/sign_in/sign_in_page.dart';
import '../features/class_time_table/class_time_table_page.dart';
import '../features/class_time_table/cubit/class_time_table_cubit.dart';
import '../features/dashboard/dashboard_page.dart';
import '../features/profile/edit/edit_profile_page.dart';
import '../features/profile/view/cubit/profile_view_cubit.dart';
import '../features/profile/view/profile_view_page.dart';
import '../features/qr/viewer/qr_viewer_page.dart';
import '../features/qr/scanner/qr_scanner_page.dart';
import '../features/reports/attendance/class_report/class_attendance_report_page.dart';
import '../features/reports/attendance/class_report/cubit/class_attendance_report_cubit.dart';
import '../features/reports/attendance/student_report/cubit/student_attendance_report_cubit.dart';
import '../features/reports/attendance/student_report/student_attendnce_report_page.dart';
import '../features/reports/reports_screen.dart';
import '../features/select_class_and_sem/select_class_and_sem_page.dart';
import 'routes.dart';

/// Dont add to `getIt` bcz we are only using static properties
class AppRouter {
  // static AuthCubit authCubit = getIt<AuthCubit>();
  // static AppCubit appCubit = getIt<AppCubit>();
  static final router = GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: Routes.splashScreen.name,
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: Routes.dashboardScreen.name,
        path: '/',
        redirect: (state) => '/dashboard/home',
      ),
      GoRoute(
        path: '/dashboard/:tab_name',
        builder: (context, state) {
          final tabName = DashboardPageTabs.fromName(
                state.params['tab_name']!.toLowerCase(),
              ) ??
              RouteParams.selectedDashboardTab;

          /// Setting up selected tab
          RouteParams.selectedDashboardTab = tabName;
          return DashboardPage(tabName: tabName);
        },
        routes: _dashboardRoutes,
      ),
      GoRoute(
        name: Routes.myProfileEditScreen.name,
        path: '/edit_profile',
        builder: (context, state) {
          assert(state.extra != null, 'Pass [ Extra ] to go_router');
          return MyProfileEditPage(
            params: state.extra! as MyProfileEditPageParam,
          );
        },
      ),
      GoRoute(
        name: Routes.signInScreen.name,
        path: '/sign_in',
        builder: (context, state) => const SignInPage(),
      ),

      GoRoute(
        name: Routes.selectClassAndSemScreen.name,
        path: '/select_class_and_sem',
        builder: (context, state) {
          final appBarName = state.extra.toString();
          return SelectClassAndSemPage(
            appBarName: appBarName,
          );
        },
      ),
      // GoRoute(
      //   name: RouteNames.signUpScreen,
      //   path: '/sign_up',
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => getIt<SignUpCubit>(),
      //     child: const SignUpPage(),
      //   ),
      // ),

      /// Showcase Widgets and thems
      GoRoute(
        name: Routes.schowcaseThemeAndWidgetsScreen.name,
        path: '/t_w_showcase',
        builder: (context, state) => const ThemeAndWidgetsShaowcasePage(),
        routes: [
          GoRoute(
            name: Routes.showcaseWidgetsScreen.name,
            path: 'widgets',
            builder: (context, state) => const WidgetsShowcasePage(),
          ),
          GoRoute(
            name: Routes.showcaseTypographyScreen.name,
            path: 'typography',
            builder: (context, state) => const TypographyPage(),
          ),
          GoRoute(
            name: Routes.showcaseColorsScreen.name,
            path: 'colors',
            builder: (context, state) => const ColorsPage(),
          ),
        ],
      ),
    ],
  );

  static List<GoRoute> get _dashboardRoutes {
    return [
      GoRoute(
        name: Routes.viewAttendanceScreen.name,
        path: 'attendance',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => getIt<ViewAttendanceCubit>(),
            child: const ViewAttendancePage(),
          );
        },
        routes: [
          GoRoute(
            name: Routes.createAttendanceScreen.name,
            path: 'create',
            builder: (context, state) => BlocProvider(
              create: (context) => getIt<CreateAttendanceCubit>(),
              child: CreateAttendancePage(
                appBarName: 'Create Attendance',
                updationData: state.extra as AttendanceWithCount?,
              ),
            ),
          ),
          GoRoute(
            name: Routes.updateAttendanceScreen.name,
            path: 'update',
            builder: (context, state) => BlocProvider(
              create: (context) => getIt<CreateAttendanceCubit>(),
              child: CreateAttendancePage(
                appBarName: 'Update Attendance',
                isUpdate: true,
                updationData: state.extra as AttendanceWithCount?,
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        name: Routes.reportsScreen.name,
        path: 'reports',
        builder: (context, state) => const ReportsScreen(),
        routes: [
          GoRoute(
            name: Routes.attendanceClassReportScreen.name,
            path: 'teacher/class_report',
            builder: (context, state) => BlocProvider(
              create: (context) => getIt<ClassAttendanceReportCubit>(),
              child: const ClassAttendanceReportPage(),
            ),
          ),
          GoRoute(
            name: Routes.attendanceSubjectReportScreen.name,
            path: 'student/subject_report',
            builder: (context, state) => BlocProvider(
              create: (context) => getIt<StudentAttendanceReportCubit>(),
              child: StudentAttendanceReportPage(
                user: state.extra! as StudentUser,
              ),
            ),
          )
        ],
      ),
      GoRoute(
        name: Routes.qrViewerScreen.name,
        path: 'qr_viewer',
        builder: (context, state) {
          assert(state.extra != null, 'Pass [ Extra ] to go_router');
          return QrViewerPage(user: state.extra! as UserDetails);
        },
      ),
      GoRoute(
        name: Routes.classTimeTable.name,
        path: 'class_time_table',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => getIt<ClassTimeTableCubit>(),
            child: const ClassTimeTablePage(),
          );
        },
      ),
      GoRoute(
        name: Routes.qrScannerScreen.name,
        path: 'qr_scanner',
        builder: (context, state) => const QrScannerPage(),
      ),
      GoRoute(
        name: Routes.profileScreen.name,
        path: 'profile/:profile_id',
        builder: (context, state) {
          final userType = UserType.fromName(state.queryParams['userType']!);
          assert(userType != null, '[ userType ] is invalid');
          final id = state.params['profile_id']!;
          if (userType == null) throw Exception('Invalid usertype');
          return BlocProvider(
            create: (context) =>
                getIt<ProfileViewCubit>()..setDataIfMyProfile(id),
            child: ProfileViewPage(userId: id, userType: userType),
          );
        },
      ),
    ];
  }
}

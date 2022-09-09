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
import '../features/dashboard/dashboard_page.dart';
import '../features/profile/my_profile/edit/cubit/my_profile_edit_cubit.dart';
import '../features/profile/my_profile/edit/edit_profile_page.dart';
import '../features/profile/my_profile/view/my_profile_view_page.dart';
import '../features/profile/others_profile/profile_page.dart';
import '../features/qr/viewer/qr_viewer_page.dart';
import '../features/qr/scanner/qr_scanner_page.dart';
import '../features/reports/attendance/attendance_report_page.dart';
import '../features/reports/attendance/cubit/attendance_report_cubit.dart';
import '../features/reports/reports_screen.dart';
import '../features/select_class_and_sem/select_class_and_sem_page.dart';
import 'route_names.dart';

/// Dont add to `getIt` bcz we are only using static properties
class AppRouter {
  // static AuthCubit authCubit = getIt<AuthCubit>();
  // static AppCubit appCubit = getIt<AppCubit>();

  static final router = GoRouter(
    // initialLocation: '/dashboard/home/attendance', //TODO: change location to /splash
    initialLocation: '/splash', //TODO: change location to /splash
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: RouteNames.splashScreen,
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: RouteNames.dashboardScreen,
        path: '/',
        redirect: (state) => '/dashboard/home',
      ),
      GoRoute(
        path: '/dashboard/:tab_name',
        builder: (context, state) {
          final tabName = DashboardPageTabs.fromName(
            state.params['tab_name']!.toLowerCase(),
          );
          return DashboardPage(tabName: tabName ?? DashboardPageTabs.home);
        },
        routes: [
          GoRoute(
            name: RouteNames.viewAttendanceScreen,
            path: 'attendance',
            builder: (context, state) {
              return BlocProvider(
                create: (context) => getIt<ViewAttendanceCubit>(),
                child: const ViewAttendancePage(),
              );
            },
            routes: [
              GoRoute(
                name: RouteNames.createAttendanceScreen,
                path: 'create',
                builder: (context, state) => BlocProvider(
                  create: (context) => getIt<CreateAttendanceCubit>(),
                  child: const CreateAttendancePage(
                    appBarName: 'Create Attendance',
                  ),
                ),
              ),
              GoRoute(
                name: RouteNames.updateAttendanceScreen,
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
            name: RouteNames.reportsScreen,
            path: 'reports',
            builder: (context, state) => const ReportsScreen(),
            routes: [
              GoRoute(
                name: RouteNames.attendanceReportScreen,
                path: 'attendance',
                builder: (context, state) => BlocProvider(
                  create: (context) => getIt<AttendanceReportCubit>(),
                  child: const AttendanceReportPage(),
                ),
              )
            ],
          ),
        ],
      ),
      GoRoute(
        name: RouteNames.signInScreen,
        path: '/sign_in',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        name: RouteNames.qrViewerScreen,
        path: '/qr',
        builder: (context, state) {
          assert(state.extra != null, 'Pass [ Extra ] to go_router');
          return QrViewerPage(user: state.extra! as UserDetails);
        },
        routes: [
          GoRoute(
            name: RouteNames.qrScannerScreen,
            path: 'scanner',
            builder: (context, state) => const QrScannerPage(),
          ),
        ],
      ),

      GoRoute(
        name: RouteNames.myProfileViewScreen,
        path: '/my_profile',
        builder: (context, state) => const MyProfileViewPage(),
      ),
      GoRoute(
        name: RouteNames.myProfileEditScreen,
        path: '/my_profile/edit',
        builder: (context, state) {
          assert(state.extra != null, 'Pass [ Extra ] to go_router');
          return MyProfileEditPage(
            params: state.extra! as MyProfileEditPageParam,
          );
        },
      ),

      GoRoute(
        name: RouteNames.profileScreen,
        path: '/profile/:profile_id',
        builder: (context, state) =>
            OthersProfileScreen(profileId: state.params['profile_id']!),
      ),

      GoRoute(
        name: RouteNames.selectClassAndSemScreen,
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
        name: RouteNames.schowcaseThemeAndWidgetsScreen,
        path: '/t_w_showcase',
        builder: (context, state) => const ThemeAndWidgetsShaowcasePage(),
        routes: [
          GoRoute(
            name: RouteNames.showcaseWidgetsScreen,
            path: 'widgets',
            builder: (context, state) => const WidgetsShowcasePage(),
          ),
          GoRoute(
            name: RouteNames.showcaseTypographyScreen,
            path: 'typography',
            builder: (context, state) => const TypographyPage(),
          ),
          GoRoute(
            name: RouteNames.showcaseColorsScreen,
            path: 'colors',
            builder: (context, state) => const ColorsPage(),
          ),
        ],
      ),
    ],
  );
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_config.dart';
import '../../shared/global/enums.dart';
import '../features/_init_/T&W_showcase/colors_page.dart';
import '../features/_init_/T&W_showcase/t_w_showcase_page.dart';
import '../features/_init_/T&W_showcase/typography_page.dart';
import '../features/_init_/T&W_showcase/widgets_page.dart';
import '../features/_init_/splash/splash_screen.dart';
import '../features/auth/sign_in/sign_in_page.dart';
import '../features/dashboard/dashboard_page.dart';
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
        name: RouteNames.selectableScreen,
        path: '/selectables',
        builder: (context, state) {
          return const SelectClassAndSemPage();
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

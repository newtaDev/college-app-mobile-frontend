import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_config.dart';
import '../../shared/global/enums.dart';
import '../features/_init_/T&W_showcase/colors_page.dart';
import '../features/_init_/T&W_showcase/t_w_showcase_page.dart';
import '../features/_init_/T&W_showcase/typography_page.dart';
import '../features/_init_/T&W_showcase/widgets_page.dart';
import '../features/_init_/splash/splash_screen.dart';
import '../features/auth/sign_in/cubit/signin_cubit.dart';
import '../features/auth/sign_in/sign_in_page.dart';
import '../features/auth/sign_up/cubit/signup_cubit.dart';
import '../features/auth/sign_up/sign_up_page.dart';
import '../features/dashboard/dashboard_page.dart';
import 'route_names.dart';

/// Dont add to `getIt` bcz we are only using static properties
class AppRouter {
  // static AuthCubit authCubit = getIt<AuthCubit>();
  // static AppCubit appCubit = getIt<AppCubit>();

  static final router = GoRouter(
    initialLocation: '/dashboard/home', //TODO: change location to /splash
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
          ///
        ],
      ),
      GoRoute(
        name: RouteNames.signInScreen,
        path: '/sign_in',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<SignInCubit>(),
          child: const SignInPage(),
        ),
      ),
      GoRoute(
        name: RouteNames.signUpScreen,
        path: '/sign_up',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<SignUpCubit>(),
          child: const SignUpPage(),
        ),
      ),

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

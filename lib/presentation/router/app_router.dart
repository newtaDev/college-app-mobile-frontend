import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_config.dart';
import '../features/_init_/splash/splash_screen.dart';
import '../features/auth/sign_in/cubit/signin_cubit.dart';
import '../features/auth/sign_in/sign_in_page.dart';
import '../features/auth/sign_up/cubit/signup_cubit.dart';
import '../features/auth/sign_up/sign_up_page.dart';
import '../features/home/home_page.dart';

/// Dont add to `getIt` bcz we are only using static properties
class AppRouter {
  // static AuthCubit authCubit = getIt<AuthCubit>();
  // static AppCubit appCubit = getIt<AppCubit>();

  static final router = GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: [
          ///
        ],
      ),
      GoRoute(
        path: '/sign_in',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<SignInCubit>(),
          child: const SignInPage(),
        ),
      ),
      GoRoute(
        path: '/sign_up',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<SignUpCubit>(),
          child: const SignUpPage(),
        ),
      ),
    ],
  );
}

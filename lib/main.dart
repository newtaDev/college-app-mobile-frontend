import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styles_lib/theme/themes.dart';

import 'config/app_config.dart';
import 'cubits/auth/auth_cubit.dart';
import 'cubits/home/home_cubit.dart';
import 'cubits/my_app/my_app_cubit.dart';
import 'cubits/my_profile/my_profile_cubit.dart';
import 'cubits/select_class_and_sem/select_class_and_sem_cubit.dart';
import 'presentation/router/app_router.dart';
import 'utils/utils.dart';

void main() async {
  await appConfig.config();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (context) => getIt<AuthCubit>()),
        BlocProvider(lazy: false, create: (context) => getIt<MyAppCubit>()),
        BlocProvider(create: (context) => getIt<HomeCubit>()),
        BlocProvider(create: (context) => getIt<SelectClassAndSemCubit>()),
        BlocProvider(create: (context) => getIt<MyProfileCubit>()),
      ],
      child: MaterialApp.router(
        title: 'College App',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routerDelegate: AppRouter.router.routerDelegate,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
      ),
    );
  }
}

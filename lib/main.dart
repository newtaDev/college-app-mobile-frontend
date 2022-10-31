import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styles_lib/theme/themes.dart';

import 'config/app_config.dart';
import 'cubits/auth/auth_cubit.dart';
import 'cubits/my_app/my_app_cubit.dart';
import 'cubits/selection/selection_cubit.dart';
import 'cubits/user/user_cubit.dart';
import 'presentation/router/app_router.dart';
import 'shared/global/global_keys.dart';
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
        BlocProvider(create: (context) => getIt<SelectionCubit>()),
        BlocProvider(create: (context) => getIt<UserCubit>()),
      ],
      child: MaterialApp.router(
        title: 'College App',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        scaffoldMessengerKey: GlobalKeys.scaffoldMessengerKey,
        builder: BotToastInit(),
        routeInformationParser: AppRouter.router.routeInformationParser,
        routerDelegate: AppRouter.router.routerDelegate,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
      ),
    );
  }
}

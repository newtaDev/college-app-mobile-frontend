import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/app_config.dart';
import 'presentation/views/auth/sign_in/cubit/signin_cubit.dart';
import 'presentation/views/auth/sign_in/sign_in_page.dart';
import 'presentation/views/auth/sign_up/cubit/signup_cubit.dart';
import 'presentation/views/auth/sign_up/sign_up_page.dart';
import 'presentation/views/home/home_page.dart';

void main() async {
  await appConfig.config();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/sign_in': (ctx) => BlocProvider(
              create: (context) => getIt<SignInCubit>(),
              child: const SignInPage(),
            ),
        '/sign_up': (ctx) => BlocProvider(
              create: (context) => getIt<SignUpCubit>(),
              child: const SignUpPage(),
            ),
        '/home_page': (ctx) => const HomePage()
      },
      initialRoute: '/sign_in',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../cubits/my_app/my_app_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyAppCubit, AppState>(
      listener: (context, state) {
        if (state is SplashLoadingDone) context.go('/sign_in');
      },
      child: Scaffold(
        body: Column(
          children: const [
            Expanded(
              child: Center(
                child: Text(
                  'Splash...',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 60),
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}

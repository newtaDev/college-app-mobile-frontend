import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../cubits/my_app/my_app_cubit.dart';
import '../../../../cubits/user/user_cubit.dart';
import '../../../router/route_names.dart';
import '../../profile/edit/edit_profile_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyAppCubit, MyAppState>(
      listener: (context, state) {
        if (state.splashStatus == SplashStatus.failed) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Something Went wrong'),
              ),
            );
        }
        if (state.splashStatus == SplashStatus.neverLogedIn ||
            state.splashStatus == SplashStatus.sessionExpired) {
          context.goNamed(Routes.signInScreen.name);
        }
        if (state.splashStatus == SplashStatus.loginSuccess) {
          final userCubit = context.read<UserCubit>();
          if (userCubit.state.userDetails.isProfileCompleted) {
            context.goNamed(Routes.dashboardScreen.name);
          } else {
            context.goNamed(
              Routes.myProfileEditScreen.name,
              extra: MyProfileEditPageParam(
                title: 'Complete your profile',
                buttonTitle: 'Save and Continue',
                navigateToOnSave: (context) =>
                    context.goNamed(Routes.dashboardScreen.name),
              ),
            );
          }
        }
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../cubits/my_app/my_app_cubit.dart';
import '../../../../cubits/user/user_cubit.dart';
import '../../../router/route_names.dart';
import '../../profile/my_profile/edit/edit_profile_page.dart';

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
          context.goNamed(RouteNames.signInScreen);
        }
        if (state.splashStatus == SplashStatus.loginSuccess) {
          final userCubit = context.read<UserCubit>();
          if (userCubit.state.userDetails.isProfileCompleted) {
            context.goNamed(RouteNames.dashboardScreen);
          } else {
            context.goNamed(
              RouteNames.myProfileEditScreen,
              extra: MyProfileEditPageParam(
                title: 'Complete your profile',
                buttonTitle: 'Save and Continue',
                navigateToOnSave: (context) =>
                    context.goNamed(RouteNames.dashboardScreen),
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

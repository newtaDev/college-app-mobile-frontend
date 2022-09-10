import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_config.dart';
import '../../../../cubits/auth/auth_cubit.dart';
import '../../../../cubits/user/user_cubit.dart';
import '../../../../data/data_source/local/auth_lds.dart';
import '../../../router/routes.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Classroom Tab'),
            // Text('access: ${authLds.userId}'),
            // Text('access: ${authLds.userType}'),
            // Text('access: ${authLds.email}'),
            // Text('user: ${context.read<UserCubit>().state.userDetails}'),
            // const Text('Settings Tab'),
            // BlocListener<AuthCubit, AuthState>(
            //   listener: (context, state) {
            //     if (state.status == AuthStatus.logedOut) {
            //       context.goNamed(RouteNames.signInScreen);
            //     }
            //   },
            //   child: ElevatedButton(
            //     onPressed: () async {
            //       await context.read<AuthCubit>().logoutUser();
            //     },
            //     child: const Text('Log out'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

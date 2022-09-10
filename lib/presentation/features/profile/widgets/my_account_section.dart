import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:styles_lib/theme/themes.dart';

import '../../../../../cubits/auth/auth_cubit.dart';
import '../../../router/routes.dart';
import '../edit/edit_profile_page.dart';

class ProfileMyAccountSection extends StatelessWidget {
  const ProfileMyAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'My Account',
            style: textTheme.labelMedium?.copyWith(
              letterSpacing: 1,
              color: ColorsPallet.grey,
            ),
          ),
        ),
        const SizedBox(height: 15),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: CircleAvatar(
            backgroundColor: ColorsPallet.primaryBlue.withOpacity(0.1),
            radius: 25,
            child: const Icon(
              Icons.edit_note_rounded,
              color: ColorsPallet.primaryBlue,
            ),
          ),
          title: const Text('Edit profile'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
          onTap: () {
            context.pushNamed(
              Routes.myProfileEditScreen.name,
              extra: MyProfileEditPageParam(
                navigateToOnSave: (context) => context.pop(),
              ),
            );
          },
        ),
        const Divider(indent: 70),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: CircleAvatar(
            backgroundColor: ColorsPallet.primaryBlue.withOpacity(0.1),
            radius: 25,
            child: const Icon(
              Icons.lock_outline_rounded,
              color: ColorsPallet.primaryBlue,
            ),
          ),
          title: const Text('Change password'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
          onTap: () {},
        ),
        const Divider(indent: 70),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: CircleAvatar(
            backgroundColor: ColorsPallet.primaryBlue.withOpacity(0.1),
            radius: 25,
            child: const Icon(
              Icons.settings_outlined,
              color: ColorsPallet.primaryBlue,
            ),
          ),
          title: const Text('Account settings'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
          onTap: () {},
        ),
        const Divider(indent: 70),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: CircleAvatar(
            backgroundColor: ColorsPallet.primaryBlue.withOpacity(0.1),
            radius: 25,
            child: const Icon(
              Icons.swap_horiz_rounded,
              color: ColorsPallet.primaryBlue,
            ),
          ),
          title: const Text('Switch Account'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
          onTap: () {},
        ),
        const Divider(indent: 70),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.logedOut) {
              context.goNamed(Routes.signInScreen.name);
            }
          },
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            leading: CircleAvatar(
              backgroundColor: ColorsPallet.primaryBlue.withOpacity(0.1),
              radius: 25,
              child: const Icon(
                Icons.logout,
                color: ColorsPallet.primaryBlue,
              ),
            ),
            title: const Text('Log out'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
            onTap: () async {
              await context.read<AuthCubit>().logoutUser();
            },
          ),
        ),
      ],
    );
  }
}

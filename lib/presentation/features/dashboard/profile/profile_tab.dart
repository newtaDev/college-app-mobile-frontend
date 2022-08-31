import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:styles_lib/styles_lib.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../../cubits/auth/auth_cubit.dart';
import '../../../router/route_names.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileAppBar(),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Row(
                      children: [
                        const ProfileAvathar(
                          emoji: '👦',
                          emojiSize: 40,
                          avatarSize: 40,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Newton Michael',
                                style: textTheme.titleLarge,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '@newta',
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: ColorsPallet.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 10, top: 15),
                    child: Text(
                      'Hai, Im newta and this is my Bio\n'
                      'can contain almost 200 charecters in bio of the user..\n'
                      'bio can contain emojis, symbols and upto 200 chars',
                      style: textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: ColorsPallet.grey),
                            ),
                            child: const Text('Call'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: ColorsPallet.grey),
                            ),
                            child: const Text('Contact info'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'My Dashboard',
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
                      backgroundColor:
                          ColorsPallet.primaryBlue.withOpacity(0.1),
                      radius: 25,
                      child: const Icon(
                        Icons.class_outlined,
                        color: ColorsPallet.primaryBlue,
                      ),
                    ),
                    title: const Text('My classroom'),
                    trailing:
                        const Icon(Icons.arrow_forward_ios_rounded, size: 15),
                    onTap: () {},
                  ),
                  const Divider(indent: 70),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    leading: CircleAvatar(
                      backgroundColor:
                          ColorsPallet.primaryBlue.withOpacity(0.1),
                      radius: 25,
                      child: const Icon(
                        Icons.check_box_outlined,
                        color: ColorsPallet.primaryBlue,
                      ),
                    ),
                    title: const Text('Attendance report'),
                    trailing:
                        const Icon(Icons.arrow_forward_ios_rounded, size: 15),
                    onTap: () {},
                  ),
                  const Divider(indent: 70),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    leading: CircleAvatar(
                      backgroundColor:
                          ColorsPallet.primaryBlue.withOpacity(0.1),
                      radius: 25,
                      child: const Icon(
                        Icons.check_box_outlined,
                        color: ColorsPallet.primaryBlue,
                      ),
                    ),
                    title: const Text('Exam results'),
                    trailing:
                        const Icon(Icons.arrow_forward_ios_rounded, size: 15),
                    onTap: () {},
                  ),
                  const SizedBox(height: 5),
                  const Divider(),
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
                      backgroundColor:
                          ColorsPallet.primaryBlue.withOpacity(0.1),
                      radius: 25,
                      child: const Icon(
                        Icons.edit_note_rounded,
                        color: ColorsPallet.primaryBlue,
                      ),
                    ),
                    title: const Text('Edit profile'),
                    trailing:
                        const Icon(Icons.arrow_forward_ios_rounded, size: 15),
                    onTap: () {},
                  ),
                  const Divider(indent: 70),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    leading: CircleAvatar(
                      backgroundColor:
                          ColorsPallet.primaryBlue.withOpacity(0.1),
                      radius: 25,
                      child: const Icon(
                        Icons.settings_outlined,
                        color: ColorsPallet.primaryBlue,
                      ),
                    ),
                    title: const Text('Account settings'),
                    trailing:
                        const Icon(Icons.arrow_forward_ios_rounded, size: 15),
                    onTap: () {},
                  ),
                  const Divider(indent: 70),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    leading: CircleAvatar(
                      backgroundColor:
                          ColorsPallet.primaryBlue.withOpacity(0.1),
                      radius: 25,
                      child: const Icon(
                        Icons.swap_horiz_rounded,
                        color: ColorsPallet.primaryBlue,
                      ),
                    ),
                    title: const Text('Switch Account'),
                    trailing:
                        const Icon(Icons.arrow_forward_ios_rounded, size: 15),
                    onTap: () {},
                  ),
                  const Divider(indent: 70),
                  BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state.status == AuthStatus.logedOut) {
                        context.goNamed(RouteNames.signInScreen);
                      }
                    },
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      leading: CircleAvatar(
                        backgroundColor:
                            ColorsPallet.primaryBlue.withOpacity(0.1),
                        radius: 25,
                        child: const Icon(
                          Icons.logout,
                          color: ColorsPallet.primaryBlue,
                        ),
                      ),
                      title: const Text('Log out'),
                      trailing:
                          const Icon(Icons.arrow_forward_ios_rounded, size: 15),
                      onTap: () async {
                        await context.read<AuthCubit>().logoutUser();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              'My Profile',
              style: textTheme.titleMedium?.copyWith(
                color: ColorsPallet.grey700,
                fontWeight: FontWeight.w500,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  context.pushNamed(RouteNames.qrScreen);
                },
                icon: const Icon(
                  Icons.qr_code,
                  color: ColorsPallet.grey700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

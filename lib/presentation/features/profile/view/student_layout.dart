import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styles_lib/theme/themes.dart';

import '../../../../cubits/user/user_cubit.dart';
import '../../../../domain/entities/user_entity.dart';
import '../widgets/my_account_section.dart';
import '../widgets/my_dashboard_section.dart';
import '../widgets/profile_with_bio.dart';

class MyProfileStudentLayout extends StatelessWidget {
  const MyProfileStudentLayout({
    // ignore: unused_element
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        BlocBuilder<UserCubit, UserState>(
          buildWhen: (previous, current) =>
              previous.userDetails != current.userDetails,
          builder: (context, state) {
            final user = state.userDetails;
            return ProfileWithBio(user: user);
          },
        ),
        const SizedBox(height: 10),
        const Divider(),
        ProfileMyDashboardSection(
          user: context.read<UserCubit>().state.userDetails,
        ),
        const SizedBox(height: 10),
        const Divider(),
        const ProfileMyAccountSection(),
        const SizedBox(height: 20),
      ],
    );
  }
}

class OtherStudentsLayout extends StatelessWidget {
  final StudentUser user;
  const OtherStudentsLayout({
    // ignore: unused_element
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        ProfileWithBio(user: user),
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
        ProfileMyDashboardSection(user: user),
        const SizedBox(height: 5),
      ],
    );
  }
}

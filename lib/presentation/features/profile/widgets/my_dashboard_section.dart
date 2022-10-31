import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:styles_lib/theme/themes.dart';

import '../../../../cubits/user/user_cubit.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../router/routes.dart';

class ProfileMyDashboardSection extends StatelessWidget {
  final UserDetails user;
  const ProfileMyDashboardSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'My Dashboard',
            style: textTheme.labelMedium?.copyWith(
              letterSpacing: 1,
              color: ColorPallet.grey,
            ),
          ),
        ),
        const SizedBox(height: 15),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: CircleAvatar(
            backgroundColor: ColorPallet.primaryBlue.withOpacity(0.1),
            radius: 25,
            child: const Icon(
              Icons.class_outlined,
              color: ColorPallet.primaryBlue,
            ),
          ),
          title: const Text('My classroom'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
          onTap: () {},
        ),
        const Divider(indent: 70),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: CircleAvatar(
            backgroundColor: ColorPallet.primaryBlue.withOpacity(0.1),
            radius: 25,
            child: const Icon(
              Icons.assignment_turned_in_outlined,
              color: ColorPallet.primaryBlue,
            ),
          ),
          title: const Text('Attendance report'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
          onTap: () {
            final isMyProfile =
                context.read<UserCubit>().state.userDetails.id == user.id;
            context.pushNamed(
              Routes.attendanceSubjectReportScreen.name,

              /// To get the latest updated report
              extra: isMyProfile
                  ? context.read<UserCubit>().state.userDetails
                  : user,
              params: RouteParams.withDashboard,
            );
          },
        ),
        const Divider(indent: 70),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: CircleAvatar(
            backgroundColor: ColorPallet.primaryBlue.withOpacity(0.1),
            radius: 25,
            child: const Icon(
              Icons.assignment_outlined,
              color: ColorPallet.primaryBlue,
            ),
          ),
          title: const Text('Exam results'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
          onTap: () {},
        ),
      ],
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets/cards/src/selectable_side_bar_card.dart';

import '../../../../cubits/user/user_cubit.dart';
import '../../../../domain/entities/user_entity.dart';
import '../widgets/my_account_section.dart';
import '../widgets/my_dashboard_section.dart';
import '../widgets/profile_with_bio.dart';

class MyProfileTeacherLayout extends StatelessWidget {
  const MyProfileTeacherLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final teacher = context.read<UserCubit>().state.userAsTeacher;
    final textTheme = Theme.of(context).textTheme;

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'My Classes',
            style: textTheme.labelMedium?.copyWith(
              letterSpacing: 1,
              color: ColorPallet.grey,
            ),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 130,
          child: TecherProfileClassList(teacher: teacher),
        ),
        const SizedBox(height: 10),
        const Divider(),
        const ProfileMyAccountSection(),
        const SizedBox(height: 20),
      ],
    );
  }
}

class TecherProfileClassList extends StatelessWidget {
  const TecherProfileClassList({
    super.key,
    required this.teacher,
  });

  final TeacherUser? teacher;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: teacher?.assignedClasses.length,
      padding: const EdgeInsets.only(left: 20),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final _class = teacher?.assignedClasses[index];
        return Padding(
          padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
          child: SizedBox(
            width: 280,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    spreadRadius: 1,
                    color: Colors.black26,
                  )
                ],
              ),
              child: SelectableSideBarCard(
                barColor:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.5),
                bgColor: Colors.white,
                title: _class?.name ?? 'N/A',
                subtitles: [
                  'Class No: ${_class?.classNumber}',
                  'Batch: ${_class?.batch}',
                  'Current semesters: ${_class?.currentSem}',
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class OtherTeachersLayout extends StatelessWidget {
  final TeacherUser user;
  const OtherTeachersLayout({
    // ignore: unused_element
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      children: [
        const SizedBox(height: 20),
        ProfileWithBio(user: user),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'My Classes',
            style: textTheme.labelMedium?.copyWith(
              letterSpacing: 1,
              color: ColorPallet.grey,
            ),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 130,
          child: TecherProfileClassList(teacher: user),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}

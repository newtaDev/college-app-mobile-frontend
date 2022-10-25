import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../../../cubits/user/user_cubit.dart';
import '../../../../../shared/global/enums.dart';
import '../../../router/routes.dart';
import 'cubit/profile_view_cubit.dart';
import 'student_layout.dart';
import 'teacher_layout.dart';

class ProfileViewPage extends StatelessWidget {
  final String userId;
  final UserType userType;
  const ProfileViewPage({
    super.key,
    required this.userId,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isMyProfile =
        context.read<UserCubit>().state.userDetails.id == userId;
    final myProfile = context.read<UserCubit>().state.userDetails;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isMyProfile ? 'My Profile' : 'Profile',
          style: textTheme.titleMedium?.copyWith(
            color: ColorPallet.grey700,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                if (isMyProfile) {
                  context.pushNamed(
                    Routes.qrViewerScreen.name,
                    extra: context.read<UserCubit>().state.userDetails,
                    params: RouteParams.withDashboard,
                  );
                } else {
                  final user =
                      context.read<ProfileViewCubit>().state.userDetails;
                  if (user == null) return;
                  context.pushNamed(
                    Routes.qrViewerScreen.name,
                    extra: user,
                    params: RouteParams.withDashboard,
                  );
                }
              },
              icon: const Icon(
                Icons.qr_code,
                color: ColorPallet.grey700,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: isMyProfile
            ? myProfile.isStudent
                ? const MyProfileStudentLayout()
                : const MyProfileTeacherLayout()
            : _OthersProfileView(
                userId: userId,
                userType: userType,
              ),
      ),
    );
  }
}

class _OthersProfileView extends StatefulWidget {
  final String userId;
  final UserType userType;
  const _OthersProfileView({
    // ignore: unused_element
    super.key,
    required this.userId,
    required this.userType,
  });

  @override
  State<_OthersProfileView> createState() => _OthersProfileViewState();
}

class _OthersProfileViewState extends State<_OthersProfileView> {
  @override
  void initState() {
    context.read<ProfileViewCubit>().getProfileDetails(
          userId: widget.userId,
          userType: widget.userType,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<ProfileViewCubit, ProfileViewState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status.isInitial || state.status.isLoading) {
          return const LoadingIndicator();
        }
        if (state.status.isError || state.userDetails == null) {
          return const Text('Profile not found');
        }
        if (!state.userDetails!.isProfileCompleted) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${state.userDetails?.name}'s",
                  style: textTheme.titleLarge,
                ),
                Text(
                  'Profile not completed yet',
                  style: textTheme.bodyLarge,
                ),
              ],
            ),
          );
        }
        return state.userDetails!.isStudent
            ? OtherStudentsLayout(user: state.userDetails!.asStudent!)
            : OtherTeachersLayout(user: state.userDetails!.asTeacher!);
      },
    );
  }
}

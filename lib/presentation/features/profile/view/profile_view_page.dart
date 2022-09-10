import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../../../cubits/user/user_cubit.dart';
import '../../../../../domain/entities/user_entity.dart';
import '../../../../../shared/global/enums.dart';
import '../../../router/route_names.dart';
import '../widgets/my_account_section.dart';
import '../widgets/my_dashboard_section.dart';
import '../widgets/profile_with_bio.dart';
import 'cubit/profile_view_cubit.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isMyProfile ? 'My Profile' : 'Profile',
          style: textTheme.titleMedium?.copyWith(
            color: ColorsPallet.grey700,
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
                  );
                } else {
                  context.pushNamed(
                    Routes.qrViewerScreen.name,
                    extra: context.read<ProfileViewCubit>().state.userDetails,
                  );
                }
              },
              icon: const Icon(
                Icons.qr_code,
                color: ColorsPallet.grey700,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: isMyProfile
            ? const _MyProfileView()
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
        return ListView(
          children: [
            const SizedBox(height: 20),
            ProfileWithBio(user: state.userDetails!),
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
            const ProfileMyDashboardSection(),
            const SizedBox(height: 5),
          ],
        );
      },
    );
  }
}

class _MyProfileView extends StatelessWidget {
  const _MyProfileView({
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
        const ProfileMyDashboardSection(),
        const SizedBox(height: 10),
        const Divider(),
        const ProfileMyAccountSection(),
        const SizedBox(height: 20),
      ],
    );
  }
}

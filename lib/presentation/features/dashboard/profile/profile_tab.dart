import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/user/user_cubit.dart';
import '../../profile/view/profile_view_page.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state.userDetails;
    return ProfileViewPage(userId: user.id, userType: user.userType);
  }
}

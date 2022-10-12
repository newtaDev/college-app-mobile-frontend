import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:styles_lib/styles_lib.dart';

import '../../../cubits/user/user_cubit.dart';
import '../../../shared/global/enums.dart';
import '../../overlays/bottom_sheet/selection_bottom_sheet.dart';
import '../../router/routes.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          if (context.read<UserCubit>().state.isTeacher)
            _buildReportListTile(
              context: context,
              icon: Icons.assignment_turned_in_outlined,
              title: 'Attendance Report of class',
              subtitle: 'Report of all subjects in a class',
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SelectClassAndSemBottomSheet(
                    onContinue: () {
                      Navigator.of(context).pop();
                      context.pushNamed(
                        Routes.attendanceClassReportScreen.name,
                        params: RouteParams.withDashboard,
                      );
                    },
                  ),
                );
              },
            ),
          if (context.read<UserCubit>().state.isStudent)
            _buildReportListTile(
              context: context,
              icon: Icons.assignment_turned_in_outlined,
              title: 'Attendance report',
              subtitle: 'Report of your subjects',
              onTap: () {
                context.pushNamed(
                  Routes.attendanceSubjectReportScreen.name,
                  extra: context.read<UserCubit>().state.userDetails,
                  params: RouteParams.withDashboard,
                );
              },
            ),
        ],
      ),
    );
  }

  ListTile _buildReportListTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: CircleAvatar(
        backgroundColor: ColorPallet.primaryBlue.withOpacity(0.1),
        radius: 25,
        child: Icon(
          icon,
          color: ColorPallet.primaryBlue,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
      onTap: onTap,
    );
  }
}

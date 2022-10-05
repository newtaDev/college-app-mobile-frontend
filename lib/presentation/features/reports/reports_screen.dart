import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/global/enums.dart';
import '../../router/routes.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            title: const Text('Attendance Report of class'),
            subtitle: const Text('Report of all subjects in a class'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              context.goNamed(
                Routes.attendanceClassReportScreen.name,
                params: {
                  'tab_name': DashboardPageTabs.home.name,
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

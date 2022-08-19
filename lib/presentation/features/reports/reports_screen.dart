import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/global/enums.dart';
import '../../router/route_names.dart';

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
            title: const Text('Attendance Reports'),
            subtitle: const Text('some description...'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              context.goNamed(
                RouteNames.attendanceReportScreen,
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

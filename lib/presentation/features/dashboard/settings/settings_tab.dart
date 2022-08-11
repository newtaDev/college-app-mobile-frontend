import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../router/route_names.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Settings Tab'),
            ElevatedButton(
              onPressed: () {
                context.goNamed(RouteNames.signInScreen);
              },
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}

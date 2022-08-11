import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/route_names.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Loged in'),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(RouteNames.schowcaseThemeAndWidgetsScreen);
              },
              child: const Text('Themes page'),
            ),
            const SizedBox(height: 20),
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

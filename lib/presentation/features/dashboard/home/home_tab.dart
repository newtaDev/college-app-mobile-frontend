import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../router/route_names.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Home tab'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.pushNamed(RouteNames.schowcaseThemeAndWidgetsScreen);
            },
            child: const Text('Themes page'),
          ),
        ],
      ),
    );
  }
}

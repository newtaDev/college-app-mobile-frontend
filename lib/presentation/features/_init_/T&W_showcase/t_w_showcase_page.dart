import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../router/route_names.dart';

class ThemeAndWidgetsShaowcasePage extends StatelessWidget {
  const ThemeAndWidgetsShaowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Themes')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                context.pushNamed(Routes.showcaseWidgetsScreen.name);
              },
              child: const Text('Widgets Page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(Routes.showcaseColorsScreen.name);
              },
              child: const Text('Colors Page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(Routes.showcaseTypographyScreen.name);
              },
              child: const Text('Typography Page'),
            ),
          ],
        ),
      ),
    );
  }
}

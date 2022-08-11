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
                context.pushNamed(RouteNames.showcaseWidgetsScreen);
              },
              child: const Text('Widgets Page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(RouteNames.showcaseColorsScreen);
              },
              child: const Text('Colors Page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(RouteNames.showcaseTypographyScreen);
              },
              child: const Text('Typography Page'),
            ),
          ],
        ),
      ),
    );
  }
}

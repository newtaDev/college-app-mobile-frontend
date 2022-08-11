import 'package:flutter/material.dart';

import 'widgets/colorschema_colors.dart';
import 'widgets/component_colors.dart';
import 'widgets/themedata_colors.dart';

class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Colors'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'ColorScheme Colors'),
              Tab(text: 'ThemeData Colors'),
              Tab(text: 'Component Colors'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: const [
                ShowColorSchemeColors(
                  onBackgroundColor: Colors.white,
                )
              ],
            ),
            ListView(
              children: const [
                ShowThemeDataColors(
                  onBackgroundColor: Colors.white,
                )
              ],
            ),
            ListView(
              children: const [
                ShowSubThemeColors(
                  onBackgroundColor: Colors.white,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/global/enums.dart';
import '../../router/route_names.dart';
import 'home/home_tab.dart';
import 'profile/profile_tab.dart';
import 'settings/settings_tab.dart';

class DashboardPage extends StatelessWidget {
  final DashboardPageTabs tabName;
  const DashboardPage({super.key, required this.tabName});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Goes back to [home] tab
        if (tabName != DashboardPageTabs.home) {
          context.goNamed(RouteNames.dashboardScreen);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: _buildTabViews(context),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: tabName.index,
          onTap: (int index) {
            final tapedTabName = DashboardPageTabs.values[index].name;
            context.go('/dashboard/$tapedTabName');
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              // title: Text('Item 1'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.beenhere),
              label: 'Class room',
              // title: Text('Item 2'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Profile',
              // title: Text('Item 3'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabViews(BuildContext context) {
    switch (tabName) {
      case DashboardPageTabs.home:
        return const HomeTab();
      case DashboardPageTabs.profile:
        return const ProfileTab();
      case DashboardPageTabs.settings:
        return const SettingsTab();
    }
  }
}

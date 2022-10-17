import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../cubits/selection/selection_cubit.dart';
import '../../../cubits/user/user_cubit.dart';
import '../../../shared/global/enums.dart';
import '../../overlays/dialogs/select_subject_dialog.dart';
import '../../router/routes.dart';
import '../../overlays/bottom_sheet/selection_bottom_sheet.dart';
import 'class_room/class_room_tab.dart';
import 'home/home_tab.dart';
import 'profile/profile_tab.dart';

class DashboardPage extends StatefulWidget {
  final DashboardPageTabs tabName;
  const DashboardPage({super.key, required this.tabName});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _fabKey = GlobalKey<FabPopupMenuState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Goes back to [home] tab
        if (widget.tabName != DashboardPageTabs.home) {
          context.goNamed(Routes.dashboardScreen.name);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: _buildTabViews(context),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.tabName.index,
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
        floatingActionButtonLocation: FabPopupMenu.location,
        floatingActionButton: context.read<UserCubit>().state.isStudent
            ? null
            : FabPopupMenu(
                key: _fabKey,
                type: FabPopupMenuType.up,
                overlayStyle: const FabPopupMenuOverlayStyle(blur: 8),
                distance: 60,
                icon: const Icon(Icons.add, color: Colors.white),
                closeButtonStyle: const FabPopupMenuCloseButtonStyle(
                  child: Icon(Icons.close, color: Colors.white),
                ),
                content: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          spreadRadius: 1,
                          color: Colors.black26,
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth:
                              MediaQuery.of(context).size.width * 0.7 > 400
                                  ? 400
                                  : MediaQuery.of(context).size.width * 0.7,
                          maxHeight: MediaQuery.of(context).size.height / 2,
                        ),
                        child: FabPopupContents(fabKey: _fabKey),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildTabViews(BuildContext context) {
    switch (widget.tabName) {
      case DashboardPageTabs.home:
        return const HomeTab();
      case DashboardPageTabs.profile:
        return const ProfileTab();
      case DashboardPageTabs.settings:
        return const ClassRoomTab();
    }
  }
}

class FabPopupContents extends StatelessWidget {
  const FabPopupContents({
    super.key,
    required this.fabKey,
  });

  final GlobalKey<FabPopupMenuState> fabKey;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColoredBox(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(Icons.campaign_outlined),
              title: const Text('Create Announcement'),
              minLeadingWidth: 5,
              onTap: () {
                final state = fabKey.currentState;
                if (state != null) {
                  state.toggle();
                }
                context.goNamed(
                  Routes.createAnnouncementFormatsScreen.name,
                  params: RouteParams.withDashboard,
                );
              },
            ),
          ),
          const Divider(height: 1),
          ColoredBox(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(Icons.post_add_rounded),
              minLeadingWidth: 5,
              title: const Text('Create Attendance'),
              onTap: () {
                final state = fabKey.currentState;
                if (state != null) {
                  state.toggle();
                }
                showDialog<void>(
                  context: context,
                  builder: (context) {
                    return SelectSubjectDialog(
                      title: 'Create Attendance',
                      onSubjectSelected: (subject) {
                        Navigator.of(context).pop();
                        context
                            .read<SelectionCubit>()
                            .setSelectedSubject(subject);
                        context.pushNamed(
                          Routes.createAttendanceScreen.name,
                          params: RouteParams.withDashboard,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          ColoredBox(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(Icons.my_library_books_outlined),
              minLeadingWidth: 5,
              title: const Text('My Announcements'),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:styles_lib/assets/assets.dart';
import 'package:widgets_lib/widgets/widgets.dart';

import '../../../../cubits/user/user_cubit.dart';
import '../../../overlays/bottom_sheet/selection_bottom_sheet.dart';
import '../../../router/routes.dart';
import '../../anouncement/view/widgets/anouncement_tabs.dart';
import '../../anouncement/view/widgets/student_anouncement_tab_view.dart';
import '../../anouncement/view/widgets/teacher_anouncement_tab_view.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    final iconButtonWidth = (MediaQuery.of(context).size.width) / 4;
    final userCubit = context.read<UserCubit>();
    final isStudent = userCubit.state.isStudent;
    final isTeacher = userCubit.state.isTeacher;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ProfileListViewCard(
                      emoji: '🏫',
                      title: 'College Name',
                      subtitle: 'location..',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Hero(
                      tag: 'home-search-tag',
                      child: Material(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Search...',
                            prefixIcon: Icon(Icons.search),
                          ),
                          readOnly: true,
                          onTap: () {
                            context.pushNamed(Routes.searchProfileScreen.name);
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButtonBox(
                          lable: 'Time Table',
                          icon: const Icon(Icons.calendar_view_month_sharp),
                          buttonWidth: iconButtonWidth,
                          onTap: () {
                            context.goNamed(
                              Routes.classTimeTable.name,
                              params: RouteParams.withDashboard,
                            );
                          },
                        ),
                        if (isTeacher)
                          IconButtonBox(
                            lable: 'Attendance',
                            icon:
                                const Icon(Icons.assignment_turned_in_outlined),
                            buttonWidth: iconButtonWidth,
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SelectionBottomSheet(
                                  onContinue: () {
                                    Navigator.of(context).pop();
                                    context.goNamed(
                                      Routes.viewAttendanceScreen.name,
                                      params: RouteParams.withDashboard,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        if (isStudent)
                          IconButtonBox(
                            lable: 'Results',
                            icon: const Icon(
                              Icons.assignment_outlined,
                            ),
                            buttonWidth: iconButtonWidth,
                            onTap: () {},
                          ),
                        IconButtonBox(
                          lable: 'Reports',
                          icon: const Icon(Icons.description_outlined),
                          buttonWidth: iconButtonWidth,
                          onTap: () {
                            context.goNamed(
                              Routes.reportsScreen.name,
                              params: RouteParams.withDashboard,
                            );
                          },
                        ),
                        IconButtonBox(
                          lable: 'Scan QR',
                          icon: const Icon(Icons.qr_code_scanner_rounded),
                          buttonWidth: iconButtonWidth,
                          onTap: () {
                            context.goNamed(
                              Routes.qrScannerScreen.name,
                              params: RouteParams.withDashboard,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 20),
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: AnouncementTabsDelegate(),
            )
          ],
          body: TabBarView(
            children: isStudent
                ? const [
                    AllAnouncementStudentTabView(),
                    MyAnouncementStudentTabView(),
                  ]
                : const [
                    AllAnouncementTeacherTabView(),
                    MyAnouncementTeacherTabView(),
                  ],
          ),
        ),
      ),
    );
  }
}

class AnouncementTabsDelegate extends SliverPersistentHeaderDelegate {
  AnouncementTabsDelegate();
  double height = 100;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final userCubit = context.read<UserCubit>();
    final isStudent = userCubit.state.isStudent;
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 5),
            child: FittedText(
              'Anouncements',
              style: textTheme.headlineSmall?.copyWith(
                fontFamily: FontAssets.raleway,
                // fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(flex: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 40,
              child: isStudent
                  ? const StudentAnouncementTabs()
                  : const TeacherAnouncementTabs(),
            ),
          ),
          const Divider(height: 1),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

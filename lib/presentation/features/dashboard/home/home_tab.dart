import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:styles_lib/assets/assets.dart';
import 'package:widgets_lib/widgets/widgets.dart';

import '../../../../cubits/user/user_cubit.dart';
import '../../../overlays/bottom_sheet/create_or_view_attendance_sheet.dart';
import '../../../router/routes.dart';
import '../../announcement/view/widgets/announcement_tabs.dart';
import '../../announcement/view/widgets/student_announcement_tab_view.dart';
import '../../announcement/view/widgets/teacher_announcement_tab_view.dart';

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
                            filled: true,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
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
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.9,
                                ),
                                builder: (context) =>
                                    const CreateOrViewAttendanceBottomSheet(
                                  title: 'Select a subject',
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
              delegate: AnnouncementTabsDelegate(),
            )
          ],
          body: TabBarView(
            children: isStudent
                ? const [
                    AllAnnouncementStudentTabView(),
                    MyAnnouncementStudentTabView(),
                  ]
                : const [
                    AllAnnouncementTeacherTabView(),
                    MyAnnouncementTeacherTabView(),
                  ],
          ),
        ),
      ),
    );
  }
}

class AnnouncementTabsDelegate extends SliverPersistentHeaderDelegate {
  AnnouncementTabsDelegate();
  double height = 90;

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final userCubit = context.read<UserCubit>();
    final isStudent = userCubit.state.isStudent;
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: FittedText(
              'Announcements',
              style: textTheme.headlineSmall?.copyWith(
                fontFamily: FontAssets.raleway,
                // fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 40,
              child: isStudent
                  ? const StudentAnnouncementTabs()
                  : const TeacherAnnouncementTabs(),
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

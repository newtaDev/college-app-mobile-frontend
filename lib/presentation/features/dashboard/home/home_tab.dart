import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:styles_lib/assets/assets.dart';
import 'package:widgets_lib/widgets/widgets.dart';

import '../../../../cubits/user/user_cubit.dart';
import '../../../../shared/global/constants.dart';
import '../../../../shared/global/enums.dart';
import '../../../router/route_names.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late ScrollController homeScrollCrt;
  bool enableAnouncemetScrolling = false;
  @override
  void initState() {
    homeScrollCrt = ScrollController()..addListener(scrollListner);
    super.initState();
  }

  void scrollListner() {
    if (homeScrollCrt.offset >= homeScrollCrt.position.maxScrollExtent) {
      if (!enableAnouncemetScrolling) {
        if (!mounted) return;
        setState(() {
          enableAnouncemetScrolling = true;
        });
      }
    }
  }

  @override
  void dispose() {
    homeScrollCrt
      ..removeListener(scrollListner)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final boxBgSize = (MediaQuery.of(context).size.width) / 4;
    final userCubit = context.read<UserCubit>();
    return LayoutBuilder(
      builder: (context, constraints) {
        const anouncementTextAndTabHeight = 76;
        final safeAreaHeight = MediaQuery.of(context).padding.top;

        /// by default bottomNavBar height and SafeArea height is subtracted from [constraints.maxHeight]
        final currentScreenHeight = constraints.maxHeight;

        return NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (ocerScroll) {
            // removes blue glow wave while reaching end of scrolling
            ocerScroll.disallowIndicator();
            return true;
          },
          child: ListView(
            controller: homeScrollCrt,
            physics: const ClampingScrollPhysics(),
            children: [
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ProfileListViewCard(
                  emoji: '👨🏻',
                  title: 'newton Michael',
                  subtitle: '@Newta',
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
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
                      lable: 'Time Tables',
                      icon: const Icon(Icons.calendar_view_month_sharp),
                      backgroundSize: boxBgSize,
                      onTap: () {},
                    ),
                    if (userCubit.state.isTeacher)
                      IconButtonBox(
                        lable: 'Attendance',
                        icon: const Icon(Icons.assignment_turned_in_outlined),
                        backgroundSize: boxBgSize,
                        onTap: () {
                          context.pushNamed(
                            RouteNames.selectClassAndSemScreen,
                            extra: 'Attendance',
                          );
                        },
                      ),
                    if (userCubit.state.isStudent)
                      IconButtonBox(
                        lable: 'Results',
                        icon: const Icon(Icons.assignment_outlined,),
                        backgroundSize: boxBgSize,
                        onTap: () {},
                      ),
                    IconButtonBox(
                      lable: 'Reports',
                      icon: const Icon(Icons.description_outlined),
                      backgroundSize: boxBgSize,
                      onTap: () {
                        context.goNamed(
                          RouteNames.reportsScreen,
                          params: {
                            'tab_name': DashboardPageTabs.home.name,
                          },
                        );
                      },
                    ),
                    IconButtonBox(
                      lable: 'Scan QR',
                      icon: const Icon(Icons.qr_code_scanner_rounded),
                      backgroundSize: boxBgSize,
                      onTap: () {
                        context.pushNamed(RouteNames.qrScannerScreen);
                      },
                    ),
                  ],
                ),
              ),
              const Divider(height: 20),
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
              const SizedBox(height: 15),
              DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 30,
                        child: TabBar(
                          isScrollable: true,
                          tabs: <Widget>[
                            Tab(
                              text: 'All',
                            ),
                            Tab(
                              text: 'Important',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                    SizedBox(
                      height: currentScreenHeight -
                          anouncementTextAndTabHeight -
                          safeAreaHeight,
                      child: TabBarView(
                        children: [
                          NotificationListener(
                            onNotification: (notification) {
                              if (notification is OverscrollNotification) {
                                if (notification.metrics.pixels <= 0.0) {
                                  if (enableAnouncemetScrolling) {
                                    if (!mounted) return false;
                                    setState(() {
                                      enableAnouncemetScrolling = false;
                                    });
                                  }
                                }
                              }
                              return true;
                            },
                            child: ListView(
                              padding: const EdgeInsets.all(15),
                              physics: !enableAnouncemetScrolling
                                  ? const NeverScrollableScrollPhysics()
                                  : const ClampingScrollPhysics(),
                              children: const [
                                TextWithImageAnouncementCard(),
                                SizedBox(height: 20),
                                TextAnouncementCard(),
                                SizedBox(height: 20),
                                MutiImageAnouncementCard(),
                                SizedBox(height: 20),
                                TextWithImageAnouncementCard(),
                                SizedBox(height: 20),
                                MutiImageAnouncementCard(),
                                SizedBox(height: 20),
                                TextWithImageAnouncementCard(),
                                SizedBox(height: 20),
                                TextAnouncementCard(),
                              ],
                            ),
                          ),
                          const Center(
                            child: Text('2nd'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Card(
              //     child: SizedBox(
              //       height: 200,
              //       width: 400,
              //     ),
              //   ),
              // )
            ],
          ),
        );
      },
    );
  }
}

class MutiImageAnouncementCard extends StatelessWidget {
  const MutiImageAnouncementCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BorderedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 260,
            width: double.maxFinite,
            child: PageView.builder(
              itemCount: Constants.randomImages.length,
              itemBuilder: (context, index) => Image.network(
                Constants.randomImages[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Multi Image view with text ',
            style: textTheme.titleMedium,
          ),
          Text(
            'Anouncement Message description canbe longer' * 2,
            style: textTheme.bodySmall,
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'By - Principal',
              style: textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class TextWithImageAnouncementCard extends StatelessWidget {
  const TextWithImageAnouncementCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BorderedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.network(
                Constants.randomImages[1],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Text with Image Title',
                  style: textTheme.titleMedium,
                ),
                Text(
                  'Anouncement Message description canbe longer' * 2,
                  style: textTheme.bodySmall,
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'By - Principal',
                    style: textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TextAnouncementCard extends StatelessWidget {
  const TextAnouncementCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BorderedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Anouncement title with no image',
            style: textTheme.titleMedium,
          ),
          Text(
            'Anouncement Message description canbe longer' * 2,
            style: textTheme.bodySmall,
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'By - Principal',
              style: textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

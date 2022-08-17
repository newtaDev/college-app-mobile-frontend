import 'package:flutter/material.dart';
import 'package:styles_lib/assets/assets.dart';
import 'package:widgets_lib/widgets/widgets.dart';

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
    return LayoutBuilder(builder: (context, constraints) {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: theme.primaryColorLight,
                    radius: 30,
                    child: Text(
                      '👨🏻',
                      style: theme.textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Newton Michael',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '@newta',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  )
                ],
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
                    icon: const Icon(Icons.access_alarm_outlined),
                    backgroundSize: boxBgSize,
                    onTap: () {},
                  ),
                  IconButtonBox(
                    lable: 'Results',
                    icon: const Icon(Icons.access_alarm_outlined),
                    backgroundSize: boxBgSize,
                    onTap: () {},
                  ),
                  IconButtonBox(
                    lable: 'Reports',
                    icon: const Icon(Icons.access_alarm_outlined),
                    backgroundSize: boxBgSize,
                    onTap: () {},
                  ),
                  IconButtonBox(
                    lable: 'Scan QR',
                    icon: const Icon(Icons.access_alarm_outlined),
                    backgroundSize: boxBgSize,
                    onTap: () {},
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
                            physics: !enableAnouncemetScrolling
                                ? const NeverScrollableScrollPhysics()
                                : const ClampingScrollPhysics(),
                            children: const [
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                title: Text('Haii 1'),
                              ),
                            ],
                          ),
                        ),
                        Center(
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
    });
  }
}

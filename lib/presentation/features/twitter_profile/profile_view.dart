import 'package:flutter/material.dart';
import 'package:styles_lib/theme/themes.dart';

import '../dashboard/home/home_tab.dart';
import 'models/profile.dart';
import 'widgets/profile_and_bg_sliver_appbar.dart';

class TwitterProfileView extends StatefulWidget {
  const TwitterProfileView({
    super.key,
    required this.profile,
  });

  final Profile profile;

  @override
  State<TwitterProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<TwitterProfileView> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                controller: scrollController,
                headerSliverBuilder: (context, value) {
                  const double profileAvatarDiameter = 100;
                  // update to shift profile avatar position from bottom edge center
                  const double profileAvatarShift = 0;
                  const profileAvatarOverflowSpace =
                      profileAvatarDiameter / 2 + profileAvatarShift;
                  return [
                    ProfileAvatarAndBgSliverAppbar(
                      profile: profile,
                      scrollController: scrollController,
                      profileAvatarDiameter: profileAvatarDiameter,
                      profileAvatarShift: profileAvatarShift,
                      options: [
                        GestureDetector(
                          onTap: () {},
                          child: const DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.qr_code,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: profileAvatarOverflowSpace + 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profile.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  profile.username,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: ColorPallet.grey,
                                      ),
                                ),
                                Text(
                                  profile.slogan,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                        fontSize: 17,
                                      ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: AnnouncementTabsDelegate(),
                    )
                  ];
                },
                body: ProfileViewTabs(
                  profile: profile,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileViewTabs extends StatelessWidget {
  const ProfileViewTabs({
    super.key,
    required this.profile,
  });

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TabBarView(
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Tweet ${index + 1}'),
              );
            },
          ),
          ListView.builder(
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Replies ${index + 1}'),
              );
            },
          ),
        ],
      ),
    );
  }
}

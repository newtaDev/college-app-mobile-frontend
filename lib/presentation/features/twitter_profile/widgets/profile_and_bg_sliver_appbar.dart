import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/profile.dart';
import 'circle_profile_avathar.dart';
import 'profile_bg_flexible_space_bar.dart';
import 'sliver_appbar_delegate.dart';

class ProfileAvatarAndBgSliverAppbar extends StatelessWidget {
  const ProfileAvatarAndBgSliverAppbar({
    super.key,
    this.maxHeight,
    this.minHeight,
    required this.profile,
    required this.scrollController,
    required this.profileAvatarShift,
    required this.profileAvatarDiameter,
    this.options = const [],
  });

  final double? maxHeight;
  final double? minHeight;
  final ScrollController scrollController;

  final Profile profile;
  final double profileAvatarDiameter;
  final double profileAvatarShift;
  final List<Widget> options;

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final size = MediaQuery.of(context).size;
    const optionsHeight = 30.0;
    final minAppBarHeight =
        minHeight ?? MediaQuery.of(context).padding.top + 80 + optionsHeight;
    final maxAppBarHeight = maxHeight ??
        (isPortrait ? size.height * 0.25 : minAppBarHeight + size.height * 0.1);

    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        return SliverPersistentHeader(
          pinned: true,
          delegate: SliverAppBarDelegate(
            maxHeight: maxAppBarHeight,
            minHeight: minAppBarHeight,
            builder: (context, shrinkOffset) {
              final double maxHeightBottomEdgeToMinHeightAppbarHitRatio =
                  (shrinkOffset / (maxAppBarHeight - minAppBarHeight))
                      .clamp(0, 1);
              final isAppbarActive =
                  maxHeightBottomEdgeToMinHeightAppbarHitRatio >= 1;
              final double minHeightBottomEdgeToTopHit = isAppbarActive
                  ? (maxAppBarHeight - shrinkOffset) / minAppBarHeight
                  : 0;
              final double profileAvatarBottomPaddingRatio =
                  isAppbarActive ? 1 - minHeightBottomEdgeToTopHit : 0;

              // for profile title
              final offset = scrollController.offset;
              final double appbarTitleToTopratio = (1 -
                      ((maxAppBarHeight +

                              /// adjusted offset to make the title appear when the profile name and userid are almost at the
                              /// bottom edge of the app bar in min-height state
                              profileAvatarDiameter / 2 +
                              profileAvatarShift
                              //
                              -
                              offset) /
                          minAppBarHeight))
                  .clamp(-1, 1.0);
              final isAppbarTitleActive = appbarTitleToTopratio >= 0;
              final double appbarTitleOpacity =
                  isAppbarTitleActive ? appbarTitleToTopratio : 0;
              final profileAvatharAndBg = [
                ProfileBgFlexibleSpaceBar(
                  titleOpacity: appbarTitleOpacity,
                  profile: profile,
                ),
                CircleProfileAvatar(
                  appBarToTopHit: minHeightBottomEdgeToTopHit,
                  bottomToAppbarHitBeforeBlur:
                      maxHeightBottomEdgeToMinHeightAppbarHitRatio,
                  profileAvatarBottomPaddingRatio:
                      profileAvatarBottomPaddingRatio,
                  profile: profile,
                  isAppbarActive: isAppbarActive,
                  profileAvatarDiameter: profileAvatarDiameter,
                  profileAvatarShift: profileAvatarShift,
                )
              ];

              return Stack(
                alignment: Alignment.topCenter,
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  if (isAppbarActive)
                    ...profileAvatharAndBg.reversed.toList()
                  else
                    ...profileAvatharAndBg,
                  Align(
                    alignment: Alignment.topRight,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: options,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}

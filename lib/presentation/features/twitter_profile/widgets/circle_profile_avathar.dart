
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:styles_lib/theme/themes.dart';

import '../models/profile.dart';

class CircleProfileAvatar extends StatelessWidget {
  const CircleProfileAvatar({
    super.key,
    required this.appBarToTopHit,
    required this.bottomToAppbarHitBeforeBlur,
    required this.profileAvatarBottomPaddingRatio,
    required this.profile,
    required this.isAppbarActive,
    required this.profileAvatarDiameter,
    required this.profileAvatarShift,
  });

  final double appBarToTopHit;
  final double bottomToAppbarHitBeforeBlur;
  final double profileAvatarBottomPaddingRatio;
  final Profile profile;
  final bool isAppbarActive;
  final double profileAvatarDiameter;
  final double profileAvatarShift;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final profileAvatarRadius = profileAvatarDiameter / 2;
        final bottomPadding = profileAvatarRadius + profileAvatarShift;
        final scaleRatio = bottomPadding / profileAvatarDiameter;
        final scale = lerpDouble(1, scaleRatio, bottomToAppbarHitBeforeBlur)!;

        final decreasingPadding =
            profileAvatarBottomPaddingRatio * (profileAvatarDiameter * 1.2);

        return Positioned(
          bottom: -bottomPadding -
              bottomToAppbarHitBeforeBlur * bottomPadding * scale +
              profileAvatarShift * (1 + scale) * bottomToAppbarHitBeforeBlur +
              decreasingPadding,
          left: 20 * (1 - bottomToAppbarHitBeforeBlur),
          child: Transform.scale(
            origin: const Offset(0.5, 0.5),
            scale: scale,
            child: Container(
              foregroundDecoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).backgroundColor,
                  width: 4,
                ),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: profileAvatarRadius,
                backgroundColor: ColorsPallet.grey200,
                // child: Text('⚡️ ',style: Theme.of(context).textTheme.displaySmall,),
                backgroundImage: NetworkImage(
                  profile.profilePic,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

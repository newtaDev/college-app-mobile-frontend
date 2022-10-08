import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:styles_lib/theme/themes.dart';

import '../models/profile.dart';

class ProfileBgFlexibleSpaceBar extends StatelessWidget {
  const ProfileBgFlexibleSpaceBar({
    super.key,
    required this.titleOpacity,
    required this.profile,
  });

  final double titleOpacity;
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ClipRect(
      child: DecoratedBox(
        decoration:  BoxDecoration(
          color: ColorsPallet.grey200,
          // gradient: LinearGradient(
          //   begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          //   colors: [
          //     Colors.blue,
          //     ColorsPallet.primaryBlueDark,
          //   ],
          // ),
          image: DecorationImage(
            image: NetworkImage(profile.bannerPic),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: titleOpacity * 20,
            sigmaY: titleOpacity * 20,
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FractionalTranslation(
                translation: Offset(
                  0,
                  1 - titleOpacity,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.name,
                      style: textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      profile.username,
                      style: textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

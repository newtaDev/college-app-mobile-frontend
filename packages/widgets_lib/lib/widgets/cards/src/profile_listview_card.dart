import 'package:flutter/material.dart';

import '../../common/profile_avathar.dart';

class ProfileListViewCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String emoji;
  final double avatarSize;
  final Widget? traling;
  const ProfileListViewCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.emoji,
    this.avatarSize = 30,
    this.traling,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        ProfileAvathar(emoji: emoji, avatarSize: avatarSize),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                )
            ],
          ),
        ),
        if (traling != null) traling!,
      ],
    );
  }
}

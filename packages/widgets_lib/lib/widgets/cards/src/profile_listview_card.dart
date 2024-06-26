import 'package:flutter/material.dart';

import '../../common/profile_avathar.dart';

class ProfileListViewCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final String emoji;
  final double avatarSize;
  final Widget? traling;
  final double? emojiSize;
  const ProfileListViewCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.emoji,
    this.avatarSize = 30,
    this.traling,
    this.emojiSize,
    this.subtitleWidget,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        ProfileAvathar(
          emoji: emoji,
          emojiSize: emojiSize,
          avatarSize: avatarSize,
        ),
        const SizedBox(width: 20),
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
              if (subtitle != null || subtitleWidget != null)
                subtitleWidget ??
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

import 'package:flutter/material.dart';

class ProfileAvathar extends StatelessWidget {
  final String emoji;
  final double? emojiSize;
  final double avatarSize;
  const ProfileAvathar({
    super.key,
    this.avatarSize = 30,
    required this.emoji,
    this.emojiSize,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    return CircleAvatar(
      backgroundColor: theme.primaryColorLight,
      radius: avatarSize,
      child: Text(
        emoji,
        style: textTheme.headlineMedium?.copyWith(fontSize: emojiSize ?? 25),
      ),
    );
  }
}

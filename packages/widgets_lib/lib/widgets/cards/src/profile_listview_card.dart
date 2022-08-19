import 'package:flutter/material.dart';

class ProfileListViewCard extends StatelessWidget {
  final String name;
  final String userName;
  final String emoji;
  const ProfileListViewCard({
    super.key,
    required this.name,
    required this.userName,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: theme.primaryColorLight,
          radius: 30,
          child: Text(
            emoji,
            style: textTheme.headlineMedium,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '@$userName',
                style: textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

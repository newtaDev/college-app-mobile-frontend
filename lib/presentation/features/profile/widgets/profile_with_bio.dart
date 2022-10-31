import 'package:flutter/material.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets/common/profile_avathar.dart';

import '../../../../domain/entities/user_entity.dart';

class ProfileWithBio extends StatelessWidget {
  final UserDetails user;
  const ProfileWithBio({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Row(
            children: [
              ProfileAvathar(
                emoji: user.emoji!,
                emojiSize: 40,
                avatarSize: 40,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '@${user.username}',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: ColorPallet.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 10, top: 15),
          child: Text(
            user.bio!,
            style: textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

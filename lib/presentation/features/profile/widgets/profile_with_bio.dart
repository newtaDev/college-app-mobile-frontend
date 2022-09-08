import 'package:flutter/material.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets/common/profile_avathar.dart';

class ProfileWithBio extends StatelessWidget {
  const ProfileWithBio({super.key});

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
              const ProfileAvathar(
                emoji: '👦',
                emojiSize: 40,
                avatarSize: 40,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Newton Michael',
                      style: textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '@newta',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: ColorsPallet.grey),
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
            'Hai, Im newta and this is my Bio\n'
            'can contain almost 200 charecters in bio of the user..\n'
            'bio can contain emojis, symbols and upto 200 chars',
            style: textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

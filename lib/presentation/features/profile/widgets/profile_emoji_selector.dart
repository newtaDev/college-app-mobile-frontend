import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:styles_lib/theme/themes.dart';

import '../../../../shared/helpers/helpers.dart';

class ProfileEmojiSelector extends StatefulWidget {
  final String? initialEmoji;
  final void Function(Emoji emoji) onSelected;
  const ProfileEmojiSelector({
    super.key,
    required this.initialEmoji,
    required this.onSelected,
  });

  @override
  State<ProfileEmojiSelector> createState() => _ProfileEmojiSelectorState();
}

class _ProfileEmojiSelectorState extends State<ProfileEmojiSelector> {
  int? centerIndex;
  late final CarouselController controller;
  final profileEmojies = Emoji.all()
      .where(
        (e) =>
            e.emojiSubgroup == EmojiSubgroup.person ||
            e.emojiSubgroup == EmojiSubgroup.personRole,
      )
      .toList();
  late final int initilaIndex;
  @override
  void initState() {
    controller = CarouselController();
    profileEmojies.shuffle();
    initilaIndex = profileEmojies
        .indexWhere((element) => element.char == widget.initialEmoji);
    centerIndex = initilaIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CarouselSlider.builder(
      carouselController: controller,
      itemCount: profileEmojies.length,
      itemBuilder: (context, index, realIndex) {
        final isCentre = index == centerIndex;
        return AnimatedScale(
          duration: Helpers.minDuration,
          scale: isCentre ? 0.8 : 0.6,
          child: GestureDetector(
            onTap: () => controller.animateToPage(index),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isCentre ? Colors.black : ColorsPallet.grey300,
                ),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  radius: 80,
                  child: Text(
                    profileEmojies[index].char,
                    style: textTheme.headlineLarge?.copyWith(fontSize: 40),
                    textScaleFactor: 1.5,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        initialPage: initilaIndex,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {
          centerIndex = index;
          widget.onSelected(profileEmojies[index]);
          setState(() {});
        },
        height: 140,
        viewportFraction: 0.3,
        enlargeCenterPage: true,
      ),
    );
  }
}

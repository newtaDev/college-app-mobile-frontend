import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:styles_lib/assets/assets.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:widgets_lib/widgets/cards/src/bordered_box.dart';

import '../../../../shared/extensions/extentions.dart';
import '../../../../shared/helpers/helpers.dart';

class MutiImageAnouncementCard extends StatelessWidget {
  final String title;
  final String description;
  final String by;
  final List<Image>? images;
  final DateTime createdOn;
  final void Function()? onTap;
  const MutiImageAnouncementCard({
    super.key,
    required this.title,
    required this.description,
    required this.by,
    this.images,
    required this.createdOn,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: BorderedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 300,
                width: double.maxFinite,
                child: images == null || (images?.isEmpty ?? false)
                    ? ColoredBox(
                        color: ColorsPallet.grey100,
                        child: Center(
                          child: SvgPicture.asset(
                            SvgAssets.placeholder,
                            height: 40,
                            width: 40,
                          ),
                        ),
                      )
                    : CarouselSlider.builder(
                        itemCount: images?.length,
                        itemBuilder: (context, index, realIndex) => SizedBox(
                          width: double.maxFinite,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: ColoredBox(
                              color: ColorsPallet.grey100,
                              child: images![index],
                            ),
                          ),
                        ),
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {},
                          height: 300,
                          // padEnds: (images?.length ?? 0) <= 1,
                          viewportFraction: 1,
                          // enlargeStrategy: CenterPageEnlargeStrategy.height,
                          enlargeCenterPage: true,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
            Linkify(
              text: description,
              style: textTheme.bodySmall,
              options: const LinkifyOptions(humanize: false),
              onOpen: (link) => launchUrlString(link.url),
            ),
            const SizedBox(height: 10),
            _CreateByCard(createdOn: createdOn, by: by),
          ],
        ),
      ),
    );
  }
}

class TextWithImageAnouncementCard extends StatelessWidget {
  final String title;
  final String description;
  final String by;
  final Image? image;
  final DateTime createdOn;
  final void Function()? onTap;
  const TextWithImageAnouncementCard({
    super.key,
    required this.title,
    required this.description,
    required this.by,
    this.image,
    required this.createdOn,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: BorderedBox(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: ColoredBox(
                      color: ColorsPallet.grey100,
                      child: image ??
                          ColoredBox(
                            color: ColorsPallet.grey100,
                            child: Center(
                              child: SvgPicture.asset(
                                SvgAssets.placeholder,
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 2),
                      Linkify(
                        text: description,
                        style: textTheme.bodySmall,
                        options: const LinkifyOptions(humanize: false),
                        onOpen: (link) => launchUrlString(link.url),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            _CreateByCard(createdOn: createdOn, by: by),
          ],
        ),
      ),
    );
  }
}

class _CreateByCard extends StatelessWidget {
  const _CreateByCard({
    // ignore: unused_element
    super.key,
    required this.createdOn,
    required this.by,
  });

  final DateTime createdOn;
  final String by;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        const Icon(
          Icons.access_time,
          color: ColorsPallet.grey,
          size: 16,
        ),
        const SizedBox(width: 5),
        Text(
          createdOn.toDayAgoWithDate(),
          style: textTheme.bodySmall,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'By - $by',
              style: textTheme.bodySmall,
            ),
          ),
        ),
      ],
    );
  }
}

class TextAnouncementCard extends StatelessWidget {
  final String title;
  final String description;
  final String by;
  final DateTime createdOn;
  final void Function()? onTap;

  const TextAnouncementCard({
    super.key,
    required this.title,
    required this.description,
    required this.by,
    required this.createdOn,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: BorderedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 2),
            Linkify(
              text: description,
              style: textTheme.bodySmall,
              options: const LinkifyOptions(humanize: false),
              onOpen: (link) => launchUrlString(link.url),
            ),
            const SizedBox(height: 10),
            _CreateByCard(createdOn: createdOn, by: by),
          ],
        ),
      ),
    );
  }
}

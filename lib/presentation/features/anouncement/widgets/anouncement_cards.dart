import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:styles_lib/assets/assets.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:widgets_lib/widgets/cards/src/bordered_box.dart';

import '../../../../shared/extensions/extentions.dart';
import '../../../../shared/helpers/helpers.dart';
import '../../../router/routes.dart';
import '../../pages/image_viewer_page.dart';

class MutiImageAnouncementCard extends StatelessWidget {
  final String title;
  final String description;
  final String by;
  final List<Image>? images;
  final List<String>? imageUrls;
  final List<File>? imageFiles;
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
    this.imageUrls,
    this.imageFiles,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        onTap?.call();
      },
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
                        color: ColorPallet.grey100,
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
                              color: ColorPallet.grey100,
                              child: _image(
                                context: context,
                                imageWidget: images![index],
                                index: index,
                              ),
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

  Widget _image({
    required BuildContext context,
    required Image imageWidget,
    required int index,
  }) {
    final tag = UniqueKey();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();

        context.pushNamed(
          Routes.imageViewerScreen.name,
          extra: ImageViewerPageParams(
            type: imageUrls != null
                ? ImageViewerType.urls
                : ImageViewerType.files,
            heroTag: tag.toString(),
            imageFiles: imageFiles,
            imageUrls: imageUrls,
            initialPage: index,
          ),
        );
      },
      child: Hero(
        tag: tag.toString(),
        child: imageWidget,
      ),
    );
  }
}

class TextWithImageAnouncementCard extends StatelessWidget {
  final String title;
  final String description;
  final String by;
  final Image? imageWidget;
  final String? imageUrl;
  final File? imageFile;
  final DateTime createdOn;
  final void Function()? onTap;
  const TextWithImageAnouncementCard({
    super.key,
    required this.title,
    required this.description,
    required this.by,
    this.imageWidget,
    required this.createdOn,
    this.onTap,
    this.imageUrl,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        onTap?.call();
      },
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
                      color: ColorPallet.grey100,
                      child: _image(context),
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

  Widget _image(BuildContext context) {
    final tag = UniqueKey();
    if (imageWidget == null) {
      return ColoredBox(
        color: ColorPallet.grey100,
        child: Center(
          child: SvgPicture.asset(
            SvgAssets.placeholder,
            height: 40,
            width: 40,
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();

        context.pushNamed(
          Routes.imageViewerScreen.name,
          extra: ImageViewerPageParams(
            type: imageUrl != null ? ImageViewerType.url : ImageViewerType.file,
            heroTag: tag.toString(),
            imageFile: imageFile,
            imageUrl: imageUrl,
          ),
        );
      },
      child: Hero(
        tag: tag.toString(),
        child: imageWidget!,
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
          color: ColorPallet.grey,
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
              '- $by',
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
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        onTap?.call();
      },
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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:styles_lib/styles_lib.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../../shared/extensions/extentions.dart';

class ClassRoomSubjectResourcesPage extends StatelessWidget {
  const ClassRoomSubjectResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final bgColor = ColorPallet
        .brightColors[Random().nextInt(ColorPallet.brightColors.length)];
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.upload_outlined, color: Colors.white),
        onPressed: () {},
        label: Text(
          'Upload classes',
          style: textTheme.button
              ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const SliverToBoxAdapter(
              child: SubjectResourceHeader(),
            ),
          ];
        },
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          children: [
            BorderedBox(
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: bgColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.description_rounded,
                              color: bgColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Title of the resource',
                              style: textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'This is the description of the resource this wcan be quite long thatr we cant even imagin',
                              style: textTheme.bodySmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedText(
                        DateTime.now()
                            .subtract(const Duration(days: 2))
                            .toDaysAgoWithLimit(),
                        style: textTheme.bodySmall,
                      ),
                      FittedText(
                        '2 Attachments',
                        style: textTheme.bodySmall,
                      ),
                      FittedText(
                        '4 Comments',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectResourceHeader extends StatelessWidget {
  const SubjectResourceHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final bgHeight =
        (size.height * 0.2) < 100 ? (size.height * 0.4) : size.height * 0.2;
    return PhysicalModel(
      color: Theme.of(context).backgroundColor,
      shadowColor: Colors.black38,
      elevation: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: bgHeight,
                width: size.width,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorPallet.lightShadeColors[Random().nextInt(
                          ColorPallet.lightShadeColors.length,
                        )],
                        ColorPallet.lightShadeColors[Random().nextInt(
                          ColorPallet.lightShadeColors.length,
                        )],
                      ],
                    ),
                  ),
                ),
              ),
              const SafeArea(child: BackButton()),
              Positioned(
                bottom: -50,
                left: 20,
                child: Image.asset(
                  ImgAssets.booksEmojiIcon,
                  height: 80,
                  width: 80,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 20,
                child: Text(
                  '- Teacher Name',
                  style: textTheme.titleSmall,
                ),
              ),
              Positioned(
                top: 0,
                right: 15,
                child: SafeArea(
                  bottom: false,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download_outlined),
                    label: Text(
                      'My downloads',
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 120, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Subject Name', style: textTheme.titleLarge),
                RichText(
                  text: TextSpan(
                    style: textTheme.bodyMedium,
                    text: 'Class Name',
                    children: [
                      TextSpan(
                        style: textTheme.bodySmall,
                        text: ' - 1st sem ',
                      ),
                    ],
                  ),
                )
                // Text('Class Name',style: textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

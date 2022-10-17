import 'dart:math';

import 'package:flutter/material.dart';
import 'package:styles_lib/assets/assets.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets/widgets.dart';

class ClassRoomTab extends StatelessWidget {
  const ClassRoomTab({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedText(
                      'Refrences',
                      style: textTheme.headlineSmall?.copyWith(
                        fontFamily: FontAssets.raleway,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(40),
                            ),
                            icon: const Icon(Icons.menu_book_rounded),
                            label: const Text('Syllabus'),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.library_books_rounded),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(40),
                            ),
                            label: const FittedText('Question banks'),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.description),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                      ),
                      label: const FittedText('Previous question papers'),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: ClassRoomTitleDelegate(),
            ),
          ],
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ClassRoomSubjectCard(),
              ClassRoomSubjectCard(),
              ClassRoomSubjectCard(),
              ClassRoomSubjectCard(),
              ClassRoomSubjectCard(),
              ClassRoomSubjectCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class ClassRoomSubjectCard extends StatelessWidget {
  const ClassRoomSubjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: BorderedBox(
        // borderRadius: BorderRadius.circular(8),
        // child: DecoratedBox(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         ColorPallet.lightShadeColors[
        //             Random().nextInt(ColorPallet.lightShadeColors.length)],
        //         ColorPallet.lightShadeColors[
        //             Random().nextInt(ColorPallet.lightShadeColors.length)],
        //       ],
        //     ),
        //   ),
        child: Row(
          children: [
            Image.asset(
              ImgAssets.booksEmojiIcon,
              height: 60,
              width: 60,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subject Name',
                    style: textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text('Bcom A ', style: textTheme.bodySmall),
                  Text('1st semester ', style: textTheme.bodySmall),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '- Rajesh shetty',
                      style: textTheme.bodySmall,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ClassRoomTitleDelegate extends SliverPersistentHeaderDelegate {
  ClassRoomTitleDelegate();
  double height = 50;

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FittedText(
              'My Subjects',
              style: textTheme.headlineSmall?.copyWith(
                fontFamily: FontAssets.raleway,
                // fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          const Divider(height: 1)
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

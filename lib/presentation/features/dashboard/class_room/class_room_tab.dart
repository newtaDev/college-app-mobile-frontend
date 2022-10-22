import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styles_lib/assets/assets.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets/widgets.dart';

import '../../../../cubits/user/user_cubit.dart';
import '../../../../shared/extensions/extentions.dart';
import 'widgets/my_subject_view.dart';

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
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FittedText(
                        'Refrences',
                        style: textTheme.headlineSmall?.copyWith(
                          fontFamily: FontAssets.raleway,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.menu_book_rounded),
                            label: const Text('Syllabus'),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.library_books_rounded),
                            label: const FittedText('Question banks'),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.description),
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
          body: const MySubjectsClassRoomView(),
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

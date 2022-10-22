import 'dart:math';

import 'package:flutter/material.dart';
import 'package:styles_lib/styles_lib.dart';
import 'package:widgets_lib/widgets/widgets.dart';

import '../../../../../shared/extensions/extentions.dart';

class ClassRoomSubjectCard extends StatelessWidget {
  final String subjectName;
  final String className;
  final int semester;
  final String? assignedTo;
  final Color genColor;
  final void Function()? onTap;
  const ClassRoomSubjectCard({
    super.key,
    required this.subjectName,
    required this.className,
    required this.semester,
    this.assignedTo,
    this.onTap,
    required this.genColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: onTap,
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
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: genColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      subjectName.getInitials(takeUpto: 2),
                      style: textTheme.titleLarge?.copyWith(
                        color: genColor,
                      ),
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
                      subjectName,
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(className, style: textTheme.bodySmall),
                    Text(
                      '$semester${semester.getRankPosition} semester',
                      style: textTheme.bodySmall,
                    ),
                    if (assignedTo != null)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '- $assignedTo',
                          style: textTheme.bodySmall,
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

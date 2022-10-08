import 'package:flutter/material.dart';
import 'package:styles_lib/theme/themes.dart';

class SelectableSideBarCard extends StatelessWidget {
  final Color barColor;
  final Color? bgColor;
  final String title;
  final List<String> subtitles;
  final void Function()? onTap;
  const SelectableSideBarCard({
    super.key,
    required this.barColor,
    required this.title,
    this.onTap,
    this.bgColor,
    this.subtitles = const [],
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: onTap,
        child: ColoredBox(
          color: bgColor ?? Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ColoredBox(
                color: barColor,
                child: const SizedBox(width: 10),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      ...List.generate(
                        subtitles.length,
                        (index) => Text(
                          subtitles[index],
                          style: textTheme.titleSmall
                              ?.copyWith(color: ColorPallet.grey600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

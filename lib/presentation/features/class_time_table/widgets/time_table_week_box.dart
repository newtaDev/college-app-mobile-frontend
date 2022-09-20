import 'package:flutter/material.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets_lib.dart';

class TimeTableDateAndWeekBox extends StatelessWidget {
  const TimeTableDateAndWeekBox({
    super.key,
    this.isSelected = false,
    required this.week,
    required this.day,
    this.onTap,
  });
  final bool isSelected;
  final String week;
  final String day;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: BorderedBox(
        bgColor: isSelected ? ColorsPallet.primaryBlue : null,
        width: (MediaQuery.of(context).size.width / 7) + (isSelected ? 10 : 0),
        child: Center(
          child: FittedBox(
            child: Column(
              children: [
                Text(
                  day,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : ColorsPallet.grey,
                  ),
                ),
                SizedBox(height: isSelected ? 10 : 0),
                Text(
                  week,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.white : ColorsPallet.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

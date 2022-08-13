import 'package:flutter/material.dart';

class IconButtonBox extends StatelessWidget {
  const IconButtonBox({
    super.key,
    this.backgroundSize,
    required this.icon,
    required this.lable,
    this.boxSize = 60,
    this.boxColor,
    this.onTap,
  });
  final double? backgroundSize;
  final double boxSize;
  final Color? boxColor;
  final Widget icon;
  final String lable;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: backgroundSize,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ColoredBox(
                color: boxColor ?? theme.primaryColorLight,
                child: SizedBox(
                  height: boxSize,
                  width: boxSize,
                  child: icon,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              lable,
              style: textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ColorCard extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  const ColorCard({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: SizedBox(
        height: 60,
        width: 120,
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: textColor,
                ),
          ),
        ),
      ),
    );
  }
}

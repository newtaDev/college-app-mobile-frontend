import 'package:flutter/material.dart';

class RoundedCloseButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Alignment? alignment;
  final EdgeInsetsGeometry? padding;
  final double iconSize;

  const RoundedCloseButton({
    // ignore: unused_element
    super.key,
    this.onTap,
    this.alignment,
    this.padding,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.topRight,
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(5),
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}

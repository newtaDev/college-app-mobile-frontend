import 'package:flutter/material.dart';
import 'package:styles_lib/theme/themes.dart';

class BorderedBox extends StatelessWidget {
  final Widget? child;
  final BoxBorder? border;
  final Color? borderColor;
  final Color? bgColor;
  final List<BoxShadow>? boxShadow;
  final BorderRadiusGeometry? borderRadius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  const BorderedBox({
    super.key,
    this.child,
    this.border,
    this.borderColor,
    this.bgColor,
    this.boxShadow,
    this.borderRadius,
    this.height,
    this.width,
    this.padding,
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: boxShadow,
        border:
            border ?? Border.all(color: borderColor ?? ColorsPallet.grey300),
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(10),
          child: alignment == null
              ? child
              : Align(alignment: alignment!, child: child),
        ),
      ),
    );
  }
}

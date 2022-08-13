import 'package:flutter/material.dart';

class FittedText extends StatelessWidget {
  ///Commmenly used text To be Fit Inside width
  const FittedText(
    this.data, {
    super.key,
    this.style,
    this.fit = BoxFit.scaleDown,
    this.alignment = Alignment.centerLeft,
    this.textAlign,
  });
  final BoxFit fit;
  final TextStyle? style;
  final String data;
  final Alignment alignment;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? const SizedBox()
        : FittedBox(
            fit: fit,
            alignment: alignment,
            child: Text(
              data,
              style: style,
              textAlign: textAlign,
            ),
          );
  }
}

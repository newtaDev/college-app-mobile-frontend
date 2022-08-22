import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final bool isIosStyle;
  final double size;
  final double strokeWidth;
  final Color? color;
  const LoadingIndicator({
    super.key,
    this.isIosStyle = true,
    this.size = 20,
    this.strokeWidth = 1,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (isIosStyle) {
      return Center(
        child: CupertinoActivityIndicator(color: color),
      );
    }
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          color: color,
        ),
      ),
    );
  }
}

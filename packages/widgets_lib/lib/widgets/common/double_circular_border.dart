
import 'package:flutter/material.dart';
import 'package:styles_lib/theme/themes.dart';

class DoubleCircularBorder extends StatefulWidget {
  const DoubleCircularBorder({
    required this.child,
    super.key,
    this.innerColor = ColorsPallet.darkGrey,
    this.outerColor = ColorsPallet.darkGrey,
    this.size = 200,
    this.innerIconsSize = 3,
    this.outerIconsSize = 3,
    this.reverse = true,
  });

  final Color innerColor;
  final Color outerColor;
  final double innerIconsSize;
  final double size;
  final double outerIconsSize;
  final Widget child;
  final bool reverse;

  @override
  State<DoubleCircularBorder> createState() => _WidgetAnimatorState();
}

class _WidgetAnimatorState extends State<DoubleCircularBorder> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        _firstArc(),
        _secondArc(),
        _child(),
      ],
    );
  }

  Center _child() {
    return Center(
      child: SizedBox(
        width: widget.size * 0.7,
        height: widget.size * 0.7,
        child: widget.child,
      ),
    );
  }

  Center _secondArc() {
    return Center(
      child: CustomPaint(
        painter: Arc2Painter(
          color: widget.outerColor,
          iconsSize: widget.innerIconsSize,
        ),
        child: SizedBox(
          width: widget.size,
          height: widget.size,
        ),
      ),
    );
  }

  Center _firstArc() {
    return Center(
      child: CustomPaint(
        painter: Arc1Painter(
          color: widget.innerColor,
          iconsSize: widget.outerIconsSize,
        ),
        child: SizedBox(
          width: 0.85 * widget.size,
          height: 0.85 * widget.size,
        ),
      ),
    );
  }
}

class Arc2Painter extends CustomPainter {
  Arc2Painter({required this.color, this.iconsSize = 3});

  final Color color;
  final double iconsSize;

  @override
  void paint(Canvas canvas, Size size) {
    const pi = 3.14;
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // draw the three arcs
    canvas
      ..drawArc(rect, 0, 0.67 * pi, false, p)
      ..drawArc(rect, 0.74 * pi, 0.65 * pi, false, p)
      ..drawArc(rect, 1.46 * pi, 0.47 * pi, false, p)

      //first shape
      ..drawRect(
        Rect.fromLTWH(
          size.width * 0.2 - iconsSize,
          size.width * 0.9 - iconsSize,
          iconsSize * 2,
          iconsSize * 2,
        ),
        p,
      );

    //second shape
    //draw the inner cross
    final centerX = size.width * 0.385;
    final centerY = size.width * 0.015;
    final lineLength = iconsSize / 2;
    canvas
      ..drawLine(
        Offset(centerX - lineLength, centerY + lineLength),
        Offset(centerX + lineLength, centerY - lineLength),
        p,
      )
      ..drawLine(
        Offset(centerX + lineLength, centerY + lineLength),
        Offset(centerX - lineLength, centerY - lineLength),
        p,
      )
      // the circle
      ..drawCircle(
        Offset(centerX, centerY),
        iconsSize + 1,
        p,
      )

      // third shape
      ..drawOval(
        Rect.fromLTWH(
          size.width - iconsSize * 1.5,
          size.width * 0.445 - iconsSize,
          iconsSize * 3,
          iconsSize * 2,
        ),
        p,
      );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Arc1Painter extends CustomPainter {
  Arc1Painter({required this.color, this.iconsSize = 3});

  final Color color;
  final double iconsSize;

  @override
  void paint(Canvas canvas, Size size) {
    const pi = 3.14;

    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // draw the two arcs
    canvas
      ..drawArc(rect, 0.15, 0.9 * pi, false, p)
      ..drawArc(rect, 1.05 * pi, 0.9 * pi, false, p);

    // draw the cross
    final centerY = size.width / 2;
    canvas
      ..drawLine(
        Offset(-iconsSize, centerY - iconsSize),
        Offset(iconsSize, centerY + iconsSize),
        p,
      )
      ..drawLine(
        Offset(iconsSize, centerY - iconsSize),
        Offset(-iconsSize, centerY + iconsSize),
        p,
      )

      // draw the circle
      ..drawCircle(Offset(size.width, centerY), iconsSize, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

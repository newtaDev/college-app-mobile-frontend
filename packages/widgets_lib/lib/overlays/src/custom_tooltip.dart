import 'dart:developer' as d;
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

enum TooltipDirection { up, down, left, right }

enum ShowCloseButton { inside, outside, none }

enum ClipAreaShape { oval, rectangle }

typedef OutSideTapHandler = void Function();

class CustomToolTip {
  static Key closeButtonKey = const Key('CloseButtonKey');

  bool isOpen = false;

  final Widget? content;
  final Widget? child;

  TooltipDirection popupDirection;

  final OutSideTapHandler? onClose;

  double? minWidth, minHeight, maxWidth, maxHeight;

  final double minimumOutSidePadding;

  final bool snapsFarAwayVertically;

  final bool snapsFarAwayHorizontally;

  double? top, right, bottom, left;

  final ShowCloseButton showCloseButton;

  final bool hasShadow;

  final Color shadowColor;

  final double shadowBlurRadius;

  final double shadowSpreadRadius;

  final double borderWidth;

  final double borderRadius;

  final Color borderColor;

  final Color closeButtonColor;

  final double closeButtonSize;

  final IconData closeButtonIcon;

  final double arrowLength;

  final double arrowBaseWidth;

  final double arrowTipDistance;

  final Color backgroundColor;

  final Color outsideBackgroundColor;

  final Rect? touchThrougArea;

  final ClipAreaShape touchThroughAreaShape;

  final double touchThroughAreaCornerRadius;

  final Key? tooltipContainerKey;

  final bool dismissOnTapOutside;

  final bool blockOutsidePointerEvents;

  final bool containsBackgroundOverlay;

  Offset? _targetCenter;
  OverlayEntry? _backGroundOverlay;
  OverlayEntry? _ballonOverlay;

  CustomToolTip({
    this.tooltipContainerKey,
    this.content, // The contents of the tooltip.
    this.popupDirection = TooltipDirection.right,
    this.onClose,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.top,
    this.child,
    this.right,
    this.bottom,
    this.left,
    this.minimumOutSidePadding = 20.0,
    this.showCloseButton = ShowCloseButton.none,
    this.snapsFarAwayVertically = false,
    this.snapsFarAwayHorizontally = false,
    this.hasShadow = true,
    this.shadowColor = Colors.black26,
    this.shadowBlurRadius = 15.0,
    this.shadowSpreadRadius = 6.0,
    this.borderWidth = 0,
    this.borderRadius = 8.0,
    this.borderColor = Colors.transparent,
    this.closeButtonIcon = Icons.close,
    this.closeButtonColor = Colors.black,
    this.closeButtonSize = 30.0,
    this.arrowLength = 10.0,
    this.arrowBaseWidth = 15.0,
    this.arrowTipDistance = 2.0,
    this.backgroundColor = Colors.white,
    this.outsideBackgroundColor = Colors.transparent,
    this.touchThroughAreaShape = ClipAreaShape.oval,
    this.touchThroughAreaCornerRadius = 5.0,
    this.touchThrougArea,
    this.dismissOnTapOutside = true,
    this.blockOutsidePointerEvents = true,
    this.containsBackgroundOverlay = true,
  })  : assert((maxWidth ?? double.infinity) >= (minWidth ?? 0.0), 'Err...'),
        assert((maxHeight ?? double.infinity) >= (minHeight ?? 0.0), 'Err...');

  void close() {
    if (onClose != null) {
      onClose?.call();
    }

    _ballonOverlay?.remove();
    _backGroundOverlay?.remove();
    isOpen = false;
  }

  void show(BuildContext targetContext, {OverlayState? overlay}) {
    final renderBox = targetContext.findRenderObject()! as RenderBox;
    overlay ??= Overlay.of(targetContext, rootOverlay: true)!;
    final overlayRenderBox = overlay.context.findRenderObject() as RenderBox?;

    _targetCenter = renderBox.localToGlobal(
      renderBox.size.center(Offset.zero),
      ancestor: overlayRenderBox,
    );

    // Create the background below the popup including the clipArea.
    if (containsBackgroundOverlay) {
      late Widget background;

      final shapeOverlay = _ShapeOverlay(
        touchThrougArea,
        touchThroughAreaShape,
        touchThroughAreaCornerRadius,
        outsideBackgroundColor,
      );
      final backgroundDecoration =
          DecoratedBox(decoration: ShapeDecoration(shape: shapeOverlay));

      if (dismissOnTapOutside && blockOutsidePointerEvents) {
        background = GestureDetector(
          onTap: close,
          onPanUpdate: (details) {
            if (isOpen) {
              if (!(shapeOverlay
                      ._getExclusion()
                      ?.contains(details.localPosition) ??
                  false)) {
                close();
              }
            }
          },
          child: backgroundDecoration,
        );
      } else if (dismissOnTapOutside && !blockOutsidePointerEvents) {
        background = Listener(
          behavior: HitTestBehavior.translucent,
          onPointerMove: (event) {
            if (!(shapeOverlay._getExclusion()?.contains(event.localPosition) ??
                false)) {
              close();
            }
          },
          onPointerDown: (event) {
            d.log('thiis');
            if (!(shapeOverlay._getExclusion()?.contains(event.localPosition) ??
                false)) {
              close();
            }
          },
          child: IgnorePointer(child: backgroundDecoration),
        );
      } else if (!dismissOnTapOutside && blockOutsidePointerEvents) {
        background = backgroundDecoration;
      } else if (!dismissOnTapOutside && !blockOutsidePointerEvents) {
        background = IgnorePointer(child: backgroundDecoration);
      } else {
        background = backgroundDecoration;
      }

      _backGroundOverlay = OverlayEntry(
        builder: (context) => _AnimationWrapper(
          builder: (context, opacity) => AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 600),
            child: background,
          ),
        ),
      );
    }

    if (snapsFarAwayVertically) {
      maxHeight = null;
      left = 0.0;
      right = 0.0;
      if (_targetCenter!.dy > overlayRenderBox!.size.center(Offset.zero).dy) {
        popupDirection = TooltipDirection.up;
        top = 0.0;
      } else {
        popupDirection = TooltipDirection.down;
        bottom = 0.0;
      }
    } // Only one of of them is possible, and vertical has higher priority.
    else if (snapsFarAwayHorizontally) {
      maxWidth = null;
      top = 0.0;
      bottom = 0.0;
      if (_targetCenter!.dx < overlayRenderBox!.size.center(Offset.zero).dx) {
        popupDirection = TooltipDirection.right;
        right = 0.0;
      } else {
        popupDirection = TooltipDirection.left;
        left = 0.0;
      }
    }

    _ballonOverlay = OverlayEntry(
      builder: (context) => _AnimationWrapper(
        builder: (context, opacity) => AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: opacity,
          child: Center(
            child: CustomSingleChildLayout(
              delegate: _PopupBallonLayoutDelegate(
                popupDirection: popupDirection,
                targetCenter: _targetCenter,
                minWidth: minWidth,
                maxWidth: maxWidth,
                minHeight: minHeight,
                maxHeight: maxHeight,
                outSidePadding: minimumOutSidePadding,
                top: top,
                bottom: bottom,
                left: left,
                right: right,
              ),
              child: Stack(
                fit: StackFit.passthrough,
                children: [_buildPopUp(), _buildCloseButton()],
              ),
            ),
          ),
        ),
      ),
    );

    final overlays = <OverlayEntry>[];

    if (containsBackgroundOverlay) {
      overlays.add(_backGroundOverlay!);
    }
    overlays.add(_ballonOverlay!);

    overlay.insertAll(overlays);
    isOpen = true;
  }

  Widget _buildPopUp() {
    return Positioned(
      child: child ??
          Container(
            key: tooltipContainerKey,
            decoration: ShapeDecoration(
              color: backgroundColor,
              shadows: hasShadow
                  ? [
                      BoxShadow(
                        color: shadowColor,
                        blurRadius: shadowBlurRadius,
                        spreadRadius: shadowSpreadRadius,
                      )
                    ]
                  : null,
              shape: _BubbleShape(
                popupDirection,
                _targetCenter,
                borderRadius,
                arrowBaseWidth,
                arrowTipDistance,
                borderColor,
                borderWidth,
                left,
                top,
                right,
                bottom,
              ),
            ),
            margin: _getBallonContainerMargin(),
            child: Material(
              type: MaterialType.transparency,
              child: content,
            ),
          ),
    );
  }

  Widget _buildCloseButton() {
    const internalClickAreaPadding = 2.0;

    //
    if (showCloseButton == ShowCloseButton.none) {
      return const SizedBox();
    }

    // ---

    double right;
    double top;

    switch (popupDirection) {
      //
      // LEFT: -------------------------------------
      case TooltipDirection.left:
        right = arrowLength + arrowTipDistance + 3.0;
        if (showCloseButton == ShowCloseButton.inside) {
          top = 2.0;
        } else if (showCloseButton == ShowCloseButton.outside) {
          top = 0.0;
        } else {
          throw AssertionError(showCloseButton);
        }
        break;

      // RIGHT/UP: ---------------------------------
      case TooltipDirection.right:
      case TooltipDirection.up:
        right = 5.0;
        if (showCloseButton == ShowCloseButton.inside) {
          top = 2.0;
        } else if (showCloseButton == ShowCloseButton.outside) {
          top = 0.0;
        } else {
          throw AssertionError(showCloseButton);
        }
        break;

      // DOWN: -------------------------------------
      case TooltipDirection.down:
        // If this value gets negative the Shadow gets clipped. The problem occurs is arrowlength + arrowTipDistance
        // is smaller than _outSideCloseButtonPadding which would mean arrowLength would need to be increased if the button is ouside.
        right = 2.0;
        if (showCloseButton == ShowCloseButton.inside) {
          top = arrowLength + arrowTipDistance + 2.0;
        } else if (showCloseButton == ShowCloseButton.outside) {
          top = 0.0;
        } else {
          throw AssertionError(showCloseButton);
        }
        break;

      // ---------------------------------------------
    }

    // ---

    return Positioned(
      right: right,
      top: top,
      child: GestureDetector(
        onTap: close,
        child: Padding(
          padding: const EdgeInsets.all(internalClickAreaPadding),
          child: Icon(
            closeButtonIcon,
            size: closeButtonSize,
            color: closeButtonColor,
          ),
        ),
      ),
    );
  }

  EdgeInsets _getBallonContainerMargin() {
    final top = (showCloseButton == ShowCloseButton.outside)
        ? closeButtonSize + 5
        : 0.0;

    switch (popupDirection) {
      //
      case TooltipDirection.down:
        return EdgeInsets.only(
          top: arrowTipDistance + arrowLength,
        );

      case TooltipDirection.up:
        return EdgeInsets.only(
          bottom: arrowTipDistance + arrowLength,
          top: top,
        );

      case TooltipDirection.left:
        return EdgeInsets.only(right: arrowTipDistance + arrowLength, top: top);

      case TooltipDirection.right:
        return EdgeInsets.only(left: arrowTipDistance + arrowLength, top: top);
    }
  }
}

class _PopupBallonLayoutDelegate extends SingleChildLayoutDelegate {
  final TooltipDirection? _popupDirection;
  final Offset? _targetCenter;
  final double? _minWidth;
  final double? _maxWidth;
  final double? _minHeight;
  final double? _maxHeight;
  final double? _top;
  final double? _bottom;
  final double? _left;
  final double? _right;
  final double? _outSidePadding;

  _PopupBallonLayoutDelegate({
    TooltipDirection? popupDirection,
    Offset? targetCenter,
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
    double? outSidePadding,
    double? top,
    double? bottom,
    double? left,
    double? right,
  })  : _targetCenter = targetCenter,
        _popupDirection = popupDirection,
        _minWidth = minWidth,
        _maxWidth = maxWidth,
        _minHeight = minHeight,
        _maxHeight = maxHeight,
        _top = top,
        _bottom = bottom,
        _left = left,
        _right = right,
        _outSidePadding = outSidePadding;

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double? calcLeftMostXtoTarget() {
      double? leftMostXtoTarget;
      if (_left != null) {
        leftMostXtoTarget = _left;
      } else if (_right != null) {
        leftMostXtoTarget = max(
          size.topLeft(Offset.zero).dx + _outSidePadding!,
          size.topRight(Offset.zero).dx -
              _outSidePadding! -
              childSize.width -
              _right!,
        );
      } else {
        leftMostXtoTarget = max(
          _outSidePadding!,
          min(
            _targetCenter!.dx - childSize.width / 2,
            size.topRight(Offset.zero).dx - _outSidePadding! - childSize.width,
          ),
        );
      }
      return leftMostXtoTarget;
    }

    double? calcTopMostYtoTarget() {
      double? topmostYtoTarget;
      if (_top != null) {
        topmostYtoTarget = _top;
      } else if (_bottom != null) {
        topmostYtoTarget = max(
          size.topLeft(Offset.zero).dy + _outSidePadding!,
          size.bottomRight(Offset.zero).dy -
              _outSidePadding! -
              childSize.height -
              _bottom!,
        );
      } else {
        topmostYtoTarget = max(
          _outSidePadding!,
          min(
            _targetCenter!.dy - childSize.height / 2,
            size.bottomRight(Offset.zero).dy -
                _outSidePadding! -
                childSize.height,
          ),
        );
      }
      return topmostYtoTarget;
    }

    switch (_popupDirection) {
      //
      case TooltipDirection.down:
        return Offset(calcLeftMostXtoTarget()!, _targetCenter!.dy);

      case TooltipDirection.up:
        final top = _top ?? _targetCenter!.dy - childSize.height;
        return Offset(calcLeftMostXtoTarget()!, top);

      case TooltipDirection.left:
        final left = _left ?? _targetCenter!.dx - childSize.width;
        return Offset(left, calcTopMostYtoTarget()!);

      case TooltipDirection.right:
        return Offset(
          _targetCenter!.dx,
          calcTopMostYtoTarget()!,
        );
      // ignore: no_default_cases
      default:
        throw AssertionError(_popupDirection);
    }
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // print("ParentConstraints: $constraints");

    var calcMinWidth = _minWidth ?? 0.0;
    var calcMaxWidth = _maxWidth ?? double.infinity;
    var calcMinHeight = _minHeight ?? 0.0;
    var calcMaxHeight = _maxHeight ?? double.infinity;

    void calcMinMaxWidth() {
      if (_left != null && _right != null) {
        calcMaxWidth = constraints.maxWidth - (_left! + _right!);
      } else if ((_left != null && _right == null) ||
          (_left == null && _right != null)) {
        // make sure that the sum of left, right + maxwidth isn't bigger than the screen width.
        final sideDelta = (_left ?? 0.0) + (_right ?? 0.0) + _outSidePadding!;
        if (calcMaxWidth > constraints.maxWidth - sideDelta) {
          calcMaxWidth = constraints.maxWidth - sideDelta;
        }
      } else {
        if (calcMaxWidth > constraints.maxWidth - 2 * _outSidePadding!) {
          calcMaxWidth = constraints.maxWidth - 2 * _outSidePadding!;
        }
      }
    }

    void calcMinMaxHeight() {
      if (_top != null && _bottom != null) {
        calcMaxHeight = constraints.maxHeight - (_top! + _bottom!);
      } else if ((_top != null && _bottom == null) ||
          (_top == null && _bottom != null)) {
        // make sure that the sum of top, bottom + maxHeight isn't bigger than the screen Height.
        final sideDelta = (_top ?? 0.0) + (_bottom ?? 0.0) + _outSidePadding!;
        if (calcMaxHeight > constraints.maxHeight - sideDelta) {
          calcMaxHeight = constraints.maxHeight - sideDelta;
        }
      } else {
        if (calcMaxHeight > constraints.maxHeight - 2 * _outSidePadding!) {
          calcMaxHeight = constraints.maxHeight - 2 * _outSidePadding!;
        }
      }
    }

    if (_popupDirection != null) {
      switch (_popupDirection!) {
        //
        case TooltipDirection.down:
          calcMinMaxWidth();
          if (_bottom != null) {
            calcMinHeight = calcMaxHeight =
                constraints.maxHeight - _bottom! - _targetCenter!.dy;
          } else {
            calcMaxHeight = min(
                  _maxHeight ?? constraints.maxHeight,
                  constraints.maxHeight - _targetCenter!.dy,
                ) -
                _outSidePadding!;
          }
          break;

        case TooltipDirection.up:
          calcMinMaxWidth();

          if (_top != null) {
            calcMinHeight = calcMaxHeight = _targetCenter!.dy - _top!;
          } else {
            calcMaxHeight =
                min(_maxHeight ?? constraints.maxHeight, _targetCenter!.dy) -
                    _outSidePadding!;
          }
          break;

        case TooltipDirection.right:
          calcMinMaxHeight();
          if (_right != null) {
            calcMinWidth = calcMaxWidth =
                constraints.maxWidth - _right! - _targetCenter!.dx;
          } else {
            calcMaxWidth = min(
                  _maxWidth ?? constraints.maxWidth,
                  constraints.maxWidth - _targetCenter!.dx,
                ) -
                _outSidePadding!;
          }
          break;

        case TooltipDirection.left:
          calcMinMaxHeight();
          if (_left != null) {
            calcMinWidth = calcMaxWidth = _targetCenter!.dx - _left!;
          } else {
            calcMaxWidth =
                min(_maxWidth ?? constraints.maxWidth, _targetCenter!.dx) -
                    _outSidePadding!;
          }
          break;
      }
    }

    final childConstraints = BoxConstraints(
      minWidth: calcMinWidth > calcMaxWidth ? calcMaxWidth : calcMinWidth,
      maxWidth: calcMaxWidth,
      minHeight: calcMinHeight > calcMaxHeight ? calcMaxHeight : calcMinHeight,
      maxHeight: calcMaxHeight,
    );

    // print("Child constraints: $childConstraints");

    return childConstraints;
  }

  @override
  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    return false;
  }
}

class _BubbleShape extends ShapeBorder {
  final Offset? targetCenter;
  final double arrowBaseWidth;
  final double arrowTipDistance;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final double? left, top, right, bottom;
  final TooltipDirection popupDirection;

  const _BubbleShape(
    this.popupDirection,
    this.targetCenter,
    this.borderRadius,
    this.arrowBaseWidth,
    this.arrowTipDistance,
    this.borderColor,
    this.borderWidth,
    this.left,
    this.top,
    this.right,
    this.bottom,
  );

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    //
    late double topLeftRadius,
        topRightRadius,
        bottomLeftRadius,
        bottomRightRadius;

    Path _getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom - bottomLeftRadius)
        ..lineTo(rect.left, rect.top + topLeftRadius)
        ..arcToPoint(
          Offset(rect.left + topLeftRadius, rect.top),
          radius: Radius.circular(topLeftRadius),
        )
        ..lineTo(rect.right - topRightRadius, rect.top)
        ..arcToPoint(
          Offset(rect.right, rect.top + topRightRadius),
          radius: Radius.circular(topRightRadius),
        );
    }

    Path _getBottomRightPath(Rect rect) {
      return Path()
        ..moveTo(rect.left + bottomLeftRadius, rect.bottom)
        ..lineTo(rect.right - bottomRightRadius, rect.bottom)
        ..arcToPoint(
          Offset(rect.right, rect.bottom - bottomRightRadius),
          radius: Radius.circular(bottomRightRadius),
          clockwise: false,
        )
        ..lineTo(rect.right, rect.top + topRightRadius)
        ..arcToPoint(
          Offset(rect.right - topRightRadius, rect.top),
          radius: Radius.circular(topRightRadius),
          clockwise: false,
        );
    }

    topLeftRadius = (left == 0 || top == 0) ? 0.0 : borderRadius;
    topRightRadius = (right == 0 || top == 0) ? 0.0 : borderRadius;
    bottomLeftRadius = (left == 0 || bottom == 0) ? 0.0 : borderRadius;
    bottomRightRadius = (right == 0 || bottom == 0) ? 0.0 : borderRadius;

    switch (popupDirection) {
      //

      case TooltipDirection.down:
        return _getBottomRightPath(rect)
          ..lineTo(
            min(
              max(
                targetCenter!.dx + arrowBaseWidth / 2,
                rect.left + borderRadius + arrowBaseWidth,
              ),
              rect.right - topRightRadius,
            ),
            rect.top,
          )
          ..lineTo(
            targetCenter!.dx,
            targetCenter!.dy + arrowTipDistance,
          ) // up to arrow tip   \
          ..lineTo(
            max(
              min(
                targetCenter!.dx - arrowBaseWidth / 2,
                rect.right - topLeftRadius - arrowBaseWidth,
              ),
              rect.left + topLeftRadius,
            ),
            rect.top,
          ) //  down /

          ..lineTo(rect.left + topLeftRadius, rect.top)
          ..arcToPoint(
            Offset(rect.left, rect.top + topLeftRadius),
            radius: Radius.circular(topLeftRadius),
            clockwise: false,
          )
          ..lineTo(rect.left, rect.bottom - bottomLeftRadius)
          ..arcToPoint(
            Offset(rect.left + bottomLeftRadius, rect.bottom),
            radius: Radius.circular(bottomLeftRadius),
            clockwise: false,
          );

      case TooltipDirection.up:
        return _getLeftTopPath(rect)
          ..lineTo(rect.right, rect.bottom - bottomRightRadius)
          ..arcToPoint(
            Offset(rect.right - bottomRightRadius, rect.bottom),
            radius: Radius.circular(bottomRightRadius),
          )
          ..lineTo(
            min(
              max(
                targetCenter!.dx + arrowBaseWidth / 2,
                rect.left + bottomLeftRadius + arrowBaseWidth,
              ),
              rect.right - bottomRightRadius,
            ),
            rect.bottom,
          )

          // up to arrow tip   \
          ..lineTo(targetCenter!.dx, targetCenter!.dy - arrowTipDistance)

          //  down /
          ..lineTo(
            max(
              min(
                targetCenter!.dx - arrowBaseWidth / 2,
                rect.right - bottomRightRadius - arrowBaseWidth,
              ),
              rect.left + bottomLeftRadius,
            ),
            rect.bottom,
          )
          ..lineTo(rect.left + bottomLeftRadius, rect.bottom)
          ..arcToPoint(
            Offset(rect.left, rect.bottom - bottomLeftRadius),
            radius: Radius.circular(bottomLeftRadius),
          )
          ..lineTo(rect.left, rect.top + topLeftRadius)
          ..arcToPoint(
            Offset(rect.left + topLeftRadius, rect.top),
            radius: Radius.circular(topLeftRadius),
          );

      case TooltipDirection.left:
        return _getLeftTopPath(rect)
          ..lineTo(
            rect.right,
            max(
              min(
                targetCenter!.dy - arrowBaseWidth / 2,
                rect.bottom - bottomRightRadius - arrowBaseWidth,
              ),
              rect.top + topRightRadius,
            ),
          )
          ..lineTo(
            targetCenter!.dx - arrowTipDistance,
            targetCenter!.dy,
          ) // right to arrow tip   \
          //  left /
          ..lineTo(
            rect.right,
            min(
              targetCenter!.dy + arrowBaseWidth / 2,
              rect.bottom - bottomRightRadius,
            ),
          )
          ..lineTo(rect.right, rect.bottom - borderRadius)
          ..arcToPoint(
            Offset(rect.right - bottomRightRadius, rect.bottom),
            radius: Radius.circular(bottomRightRadius),
          )
          ..lineTo(rect.left + bottomLeftRadius, rect.bottom)
          ..arcToPoint(
            Offset(rect.left, rect.bottom - bottomLeftRadius),
            radius: Radius.circular(bottomLeftRadius),
          );

      case TooltipDirection.right:
        return _getBottomRightPath(rect)
          ..lineTo(rect.left + topLeftRadius, rect.top)
          ..arcToPoint(
            Offset(rect.left, rect.top + topLeftRadius),
            radius: Radius.circular(topLeftRadius),
            clockwise: false,
          )
          ..lineTo(
            rect.left,
            max(
              min(
                targetCenter!.dy - arrowBaseWidth / 2,
                rect.bottom - bottomLeftRadius - arrowBaseWidth,
              ),
              rect.top + topLeftRadius,
            ),
          )

          //left to arrow tip   /
          ..lineTo(targetCenter!.dx + arrowTipDistance, targetCenter!.dy)

          //  right \
          ..lineTo(
            rect.left,
            min(
              targetCenter!.dy + arrowBaseWidth / 2,
              rect.bottom - bottomLeftRadius,
            ),
          )
          ..lineTo(rect.left, rect.bottom - bottomLeftRadius)
          ..arcToPoint(
            Offset(rect.left + bottomLeftRadius, rect.bottom),
            radius: Radius.circular(bottomLeftRadius),
            clockwise: false,
          );
    }
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    var paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawPath(getOuterPath(rect), paint);
    paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    if (right == 0.0) {
      if (top == 0.0 && bottom == 0.0) {
        canvas.drawPath(
          Path()
            ..moveTo(rect.right, rect.top)
            ..lineTo(rect.right, rect.bottom),
          paint,
        );
      } else {
        canvas.drawPath(
          Path()
            ..moveTo(rect.right, rect.top + borderWidth / 2)
            ..lineTo(rect.right, rect.bottom - borderWidth / 2),
          paint,
        );
      }
    }
    if (left == 0.0) {
      if (top == 0.0 && bottom == 0.0) {
        canvas.drawPath(
          Path()
            ..moveTo(rect.left, rect.top)
            ..lineTo(rect.left, rect.bottom),
          paint,
        );
      } else {
        canvas.drawPath(
          Path()
            ..moveTo(rect.left, rect.top + borderWidth / 2)
            ..lineTo(rect.left, rect.bottom - borderWidth / 2),
          paint,
        );
      }
    }
    if (top == 0.0) {
      if (left == 0.0 && right == 0.0) {
        canvas.drawPath(
          Path()
            ..moveTo(rect.right, rect.top)
            ..lineTo(rect.left, rect.top),
          paint,
        );
      } else {
        canvas.drawPath(
          Path()
            ..moveTo(rect.right - borderWidth / 2, rect.top)
            ..lineTo(rect.left + borderWidth / 2, rect.top),
          paint,
        );
      }
    }
    if (bottom == 0.0) {
      if (left == 0.0 && right == 0.0) {
        canvas.drawPath(
          Path()
            ..moveTo(rect.right, rect.bottom)
            ..lineTo(rect.left, rect.bottom),
          paint,
        );
      } else {
        canvas.drawPath(
          Path()
            ..moveTo(rect.right - borderWidth / 2, rect.bottom)
            ..lineTo(rect.left + borderWidth / 2, rect.bottom),
          paint,
        );
      }
    }
  }

  @override
  ShapeBorder scale(double t) {
    return _BubbleShape(
      popupDirection,
      targetCenter,
      borderRadius,
      arrowBaseWidth,
      arrowTipDistance,
      borderColor,
      borderWidth,
      left,
      top,
      right,
      bottom,
    );
  }
}

class _ShapeOverlay extends ShapeBorder {
  final Rect? clipRect;
  final Color outsideBackgroundColor;
  final ClipAreaShape clipAreaShape;
  final double clipAreaCornerRadius;

  const _ShapeOverlay(
    this.clipRect,
    this.clipAreaShape,
    this.clipAreaCornerRadius,
    this.outsideBackgroundColor,
  );

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addOval(clipRect!);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final outer = Path()..addRect(rect);

    final exclusion = _getExclusion();
    if (exclusion == null) {
      return outer;
    } else {
      return Path.combine(ui.PathOperation.difference, outer, exclusion);
    }
  }

  Path? _getExclusion() {
    Path exclusion;
    if (clipRect == null) {
      return null;
    } else if (clipAreaShape == ClipAreaShape.oval) {
      exclusion = Path()..addOval(clipRect!);
    } else {
      exclusion = Path()
        ..moveTo(clipRect!.left + clipAreaCornerRadius, clipRect!.top)
        ..lineTo(clipRect!.right - clipAreaCornerRadius, clipRect!.top)
        ..arcToPoint(
          Offset(clipRect!.right, clipRect!.top + clipAreaCornerRadius),
          radius: Radius.circular(clipAreaCornerRadius),
        )
        ..lineTo(clipRect!.right, clipRect!.bottom - clipAreaCornerRadius)
        ..arcToPoint(
          Offset(clipRect!.right - clipAreaCornerRadius, clipRect!.bottom),
          radius: Radius.circular(clipAreaCornerRadius),
        )
        ..lineTo(clipRect!.left + clipAreaCornerRadius, clipRect!.bottom)
        ..arcToPoint(
          Offset(clipRect!.left, clipRect!.bottom - clipAreaCornerRadius),
          radius: Radius.circular(clipAreaCornerRadius),
        )
        ..lineTo(clipRect!.left, clipRect!.top + clipAreaCornerRadius)
        ..arcToPoint(
          Offset(clipRect!.left + clipAreaCornerRadius, clipRect!.top),
          radius: Radius.circular(clipAreaCornerRadius),
        )
        ..close();
    }
    return exclusion;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    canvas.drawPath(
      getOuterPath(rect),
      Paint()..color = outsideBackgroundColor,
    );
  }

  @override
  ShapeBorder scale(double t) {
    return _ShapeOverlay(
      clipRect,
      clipAreaShape,
      clipAreaCornerRadius,
      outsideBackgroundColor,
    );
  }
}

typedef FadeBuilder = Widget Function(BuildContext, double);

class _AnimationWrapper extends StatefulWidget {
  final FadeBuilder? builder;

  const _AnimationWrapper({this.builder});

  @override
  _AnimationWrapperState createState() => _AnimationWrapperState();
}

class _AnimationWrapperState extends State<_AnimationWrapper> {
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          opacity = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder!(context, opacity);
  }
}

enum CustomToolTipDismissBehaviour { none, onTap, onPointerDown }

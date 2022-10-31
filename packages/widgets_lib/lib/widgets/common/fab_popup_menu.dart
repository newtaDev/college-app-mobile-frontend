import 'dart:math' as math;
import 'dart:ui';
// Inspired by this article.
// https://docs.flutter.dev/cookbook/effects/expandable-fab

import 'package:flutter/material.dart';

/// The type of behavior of this widget.
enum FabPopupMenuType { fan, up, left }

/// Style of the overlay.
@immutable
class FabPopupMenuOverlayStyle {
  const FabPopupMenuOverlayStyle({
    this.color,
    this.blur,
  });

  /// The color to paint behind the Fab.
  final Color? color;

  /// The strength of the blur behind Fab.
  final double? blur;
}

/// Style of the close button.
@immutable
class FabPopupMenuCloseButtonStyle {
  const FabPopupMenuCloseButtonStyle({
    this.child = const Icon(Icons.close),
    this.foregroundColor,
    this.backgroundColor,
  });

  /// The widget below the close button widget in the tree.
  final Widget child;

  /// The default foreground color for icons and text within the button.
  final Color? foregroundColor;

  /// The button's background color.
  final Color? backgroundColor;
}

class _FabPopupMenuLocation extends StandardFabLocation {
  final ValueNotifier<ScaffoldPrelayoutGeometry?> scaffoldGeometry =
      ValueNotifier(null);

  @override
  double getOffsetX(
    ScaffoldPrelayoutGeometry scaffoldGeometry,
    double adjustment,
  ) {
    Future.microtask(() {
      this.scaffoldGeometry.value = scaffoldGeometry;
    });
    return 0;
  }

  @override
  double getOffsetY(
    ScaffoldPrelayoutGeometry scaffoldGeometry,
    double adjustment,
  ) {
    return 0;
  }
}

/// Fab button that can show/hide multiple action buttons with animation.
@immutable
class FabPopupMenu extends StatefulWidget {
  static final FloatingActionButtonLocation location = _FabPopupMenuLocation();

  const FabPopupMenu({
    required super.key,
    this.distance = 100,
    this.duration = const Duration(milliseconds: 250),
    this.fanAngle = 90,
    this.initialOpen = false,
    this.type = FabPopupMenuType.fan,
    this.closeButtonStyle = const FabPopupMenuCloseButtonStyle(),
    this.foregroundColor,
    this.backgroundColor,
    this.icon = const Icon(Icons.menu),
    this.childrenOffset = const Offset(4, 4),
    this.children = const [],
    this.onOpen,
    this.onClose,
    this.overlayStyle,
    this.content,
  });

  /// Distance from children.
  final double distance;

  /// Animation duration.
  final Duration duration;

  /// Angle of opening when fan type.
  final double fanAngle;

  /// Open at initial display.
  final bool initialOpen;

  /// The type of behavior of this widget.
  final FabPopupMenuType type;

  /// Style of the close button.
  final FabPopupMenuCloseButtonStyle closeButtonStyle;

  /// The widget below this widget in the tree.
  final Widget icon;

  /// For positioning of children widgets.
  final Offset childrenOffset;

  /// The widgets below this widget in the tree.
  final List<Widget> children;

  /// The default foreground color for icons and text within the button.
  final Color? foregroundColor;

  /// The button's background color.
  final Color? backgroundColor;

  /// Execute when the menu opens.
  final VoidCallback? onOpen;

  /// Execute when the menu closes.
  final VoidCallback? onClose;

  /// Provides the style for overlay. No overlay when null.
  final FabPopupMenuOverlayStyle? overlayStyle;

  final Widget? content;

  @override
  State<FabPopupMenu> createState() => FabPopupMenuState();
}

class FabPopupMenuState extends State<FabPopupMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  /// Returns whether the menu is open
  bool get isOpen => _open;
  bool isAnimationCompleted = true;

  /// Display or hide the menu.
  void toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        isAnimationCompleted = false;
        widget.onOpen?.call();
        _controller.forward();
      } else {
        widget.onClose?.call();
        _controller.reverse();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: widget.duration,
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = FabPopupMenu.location as _FabPopupMenuLocation;
    Offset? offset;
    Widget? cache;
    return WillPopScope(
      onWillPop: () async {
        if (isOpen) {
          toggle();
          return false;
        } else {
          return true;
        }
      },
      child: ValueListenableBuilder<ScaffoldPrelayoutGeometry?>(
        valueListenable: location.scaffoldGeometry,
        builder: (context, geometry, child) {
          if (geometry == null) {
            return const SizedBox.shrink();
          }
          final x = kFloatingActionButtonMargin + geometry.minInsets.right;
          final bottomContentHeight =
              geometry.scaffoldSize.height - geometry.contentBottom;
          final y = kFloatingActionButtonMargin +
              math.max(geometry.minViewPadding.bottom, bottomContentHeight);
          if (offset != Offset(x, y)) {
            offset = Offset(x, y);
            cache = _buildButtons(offset!);
          }
          return cache!;
        },
      ),
    );
  }

  Widget _buildButtons(Offset offset) {
    final blur = widget.overlayStyle?.blur;
    final overlayColor = widget.overlayStyle?.color;
    return GestureDetector(
      onTap: toggle,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (blur != null && !isAnimationCompleted)
            IgnorePointer(
              ignoring: !_open,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: _open ? blur : 0.0),
                duration: widget.duration,
                curve: Curves.easeInOut,
                builder: (_, value, child) {
                  if (value < 0.001) {
                    return child!;
                  }
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
                    child: child,
                  );
                },
                child: const ColoredBox(color: Colors.transparent),
              ),
            ),
          IgnorePointer(
            ignoring: !_open,
            child: AnimatedOpacity(
              duration: widget.duration,
              opacity: _open ? 1 : 0,
              curve: Curves.easeInOut,
              onEnd: () {
                setState(() {
                  if (!isOpen) isAnimationCompleted = true;
                });
              },
              child: overlayColor == null
                  ? const SizedBox()
                  : ColoredBox(
                      color: overlayColor,
                    ),
            ),
          ),
          if (widget.content != null && !isAnimationCompleted)
            _ExpandingActionButton(
              directionInDegrees: 90 + (90 - widget.fanAngle) / 2,
              maxDistance: widget.distance,
              progress: _expandAnimation,
              offset: offset + widget.childrenOffset,
              child: widget.content!,
            ),
          if (widget.content == null && !isAnimationCompleted)
            ..._buildExpandingActionButtons(offset),
          Align(
            alignment: Alignment.bottomRight,
            child: Transform.translate(
              offset: -offset,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildTapToCloseFab(),
                  _buildTapToOpenFab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    final style = widget.closeButtonStyle;
    return FloatingActionButton(
      heroTag: null,
      foregroundColor: style.foregroundColor,
      backgroundColor: style.backgroundColor,
      onPressed: toggle,
      child: style.child,
    );
  }

  List<Widget> _buildExpandingActionButtons(Offset offset) {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = widget.fanAngle / (count - 1);
    for (var i = 0; i < count; i++) {
      final double dir, dist;
      switch (widget.type) {
        case FabPopupMenuType.fan:
          dir = step * i;
          dist = widget.distance;
          break;
        case FabPopupMenuType.up:
          dir = 90;
          dist = widget.distance * (i + 1);
          break;
        case FabPopupMenuType.left:
          dir = 0;
          dist = widget.distance * (i + 1);
          break;
      }
      children.add(
        _ExpandingActionButton(
          directionInDegrees: dir + (90 - widget.fanAngle) / 2,
          maxDistance: dist,
          progress: _expandAnimation,
          offset: offset + widget.childrenOffset,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    final duration = widget.duration;
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1,
        ),
        duration: duration,
        curve: const Interval(0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1, curve: Curves.easeInOut),
          duration: duration,
          child: FloatingActionButton(
            heroTag: null,
            foregroundColor: widget.foregroundColor,
            backgroundColor: widget.backgroundColor,
            onPressed: toggle,
            child: AnimatedRotation(
              duration: duration,
              turns: _open ? -0.5 : 0,
              child: widget.icon,
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
    required this.offset,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Offset offset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final pos = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: offset.dx + pos.dx,
          bottom: offset.dy + pos.dy,
          child: Transform.translate(
            // angle: (1.0 - progress.value) * math.pi / 2,
            offset: Offset(offset.dx + pos.dx, progress.value),
            child: child,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

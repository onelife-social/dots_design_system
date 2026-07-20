import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

const double _kPointerWidth = 20;
const double _kPointerHeight = 10;
const double _kCloseSize = 22;

/// A trip-stop map marker that collapses to a pin and expands to a summary
/// bubble. [expanded] is controlled by the consumer (tap / map centering /
/// timeline).
///
/// The widget is bottom-anchored: its bottom-center is the geographic tip, both
/// collapsed and expanded, so a consumer can bottom-align it inside a fixed-size
/// map marker without the anchor point ever shifting. Only real content absorbs
/// taps (empty space falls through to the map).
class DotsTripStopMarker extends StatelessWidget {
  const DotsTripStopMarker({
    required this.expanded,
    required this.memoryCount,
    required this.order,
    this.thumbnails = const <Widget>[],
    this.title,
    this.color,
    this.onTap,
    this.onOpen,
    super.key,
  });

  /// Whether the summary bubble is shown instead of the collapsed pin.
  final bool expanded;

  /// Total memories at this stop.
  final int memoryCount;

  /// 1-based position of this stop along the trip; shown inside the collapsed pin.
  final int order;

  /// Image widgets for the memories at this stop, forwarded to
  /// [DotsTripStopCard] when [expanded].
  final List<Widget> thumbnails;

  /// Optional place label shown in the expanded card.
  final String? title;

  /// Accent color for both the pin and the card. Defaults to
  /// [DotsColorsModel.labelHighlight].
  final Color? color;

  /// Toggles [expanded]: fires from the collapsed pin and the expanded bubble's
  /// close button.
  final VoidCallback? onTap;

  /// Opens the stop's memories: fires when the expanded card body is tapped.
  /// Ignored while collapsed.
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final accentColor = color ?? theme.colors.labelHighlight;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      switchInCurve: Curves.easeOutBack,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      ),
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ...previousChildren,
          if (currentChild != null) currentChild,
        ],
      ),
      child: expanded
          ? _ExpandedStopMarker(
              key: const ValueKey('expanded'),
              thumbnails: thumbnails,
              memoryCount: memoryCount,
              title: title,
              accentColor: accentColor,
              onOpen: onOpen,
              onClose: onTap,
            )
          : GestureDetector(
              key: const ValueKey('collapsed'),
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              child: DotsMapPin(
                color: accentColor,
                count: order,
              ),
            ),
    );
  }
}

class _ExpandedStopMarker extends StatelessWidget {
  const _ExpandedStopMarker({
    required this.thumbnails,
    required this.memoryCount,
    required this.title,
    required this.accentColor,
    required this.onOpen,
    required this.onClose,
    super.key,
  });

  final List<Widget> thumbnails;
  final int memoryCount;
  final String? title;
  final Color accentColor;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            DotsTripStopCard(
              thumbnails: thumbnails,
              memoryCount: memoryCount,
              title: title,
              accentColor: accentColor,
              onTap: onOpen,
            ),
            if (onClose != null)
              Positioned(
                top: -8,
                right: -8,
                child: _CloseButton(onTap: onClose!),
              ),
          ],
        ),
        CustomPaint(
          size: const Size(_kPointerWidth, _kPointerHeight),
          painter: _StopMarkerPointerPainter(
            color: theme.colors.bgContainerPrimary,
            shadow: theme.styles.defaultShadow,
          ),
        ),
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: _kCloseSize,
        height: _kCloseSize,
        decoration: BoxDecoration(
          color: theme.colors.bgContainerPrimary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: theme.colors.shadowPrimary, blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Icon(Icons.close, size: 14, color: theme.colors.textSecondary),
      ),
    );
  }
}

class _StopMarkerPointerPainter extends CustomPainter {
  const _StopMarkerPointerPainter({
    required this.color,
    required this.shadow,
  });

  final Color color;
  final DotsStyleShadow shadow;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawShadow(path, shadow.color, shadow.blurRadius, false);
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _StopMarkerPointerPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.shadow != shadow;
}

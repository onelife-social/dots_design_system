import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsTooltip extends StatelessWidget {
  final DotsIconData? icon;
  final Widget? iconWidget;
  final String text;
  final Function()? onTap;
  final Function()? onClose;
  final bool showCloseButton;

  final DotsToolTipTailPosition tailPosition;
  final double maxWidth;

  const DotsTooltip({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
    this.iconWidget,
    this.showCloseButton = true,
    required this.tailPosition,
    this.onClose,
    this.maxWidth = 288,
  });

  BorderRadiusGeometry get _borderRadius {
    switch (tailPosition) {
      case DotsToolTipTailPosition.bottomAlignLeadingEdge:
        return DotsBorderRadius.r24.copyWith(bottomLeft: Radius.circular(14));
      case DotsToolTipTailPosition.bottomAlignTrailingEdge:
        return DotsBorderRadius.r24.copyWith(bottomRight: Radius.circular(14));
      case DotsToolTipTailPosition.topAlignLeadingEdge:
        return DotsBorderRadius.r24.copyWith(topLeft: Radius.circular(14));
      case DotsToolTipTailPosition.topAlignTrailingEdge:
        return DotsBorderRadius.r24.copyWith(topRight: Radius.circular(14));
      default:
        return DotsBorderRadius.r24;
    }
  }

  double get _tailAlignmentX {
    switch (tailPosition) {
      case DotsToolTipTailPosition.bottomAlignLeadingEdge:
      case DotsToolTipTailPosition.topAlignLeadingEdge:
        return -0.82;
      case DotsToolTipTailPosition.bottomAlignLeading:
      case DotsToolTipTailPosition.topAlignLeading:
        return -0.56;
      case DotsToolTipTailPosition.bottomAlignCenter:
      case DotsToolTipTailPosition.topAlignCenter:
        return 0;
      case DotsToolTipTailPosition.topAlignTrailing:
      case DotsToolTipTailPosition.bottomAlignTrailing:
        return 0.56;
      case DotsToolTipTailPosition.bottomAlignTrailingEdge:
      case DotsToolTipTailPosition.topAlignTrailingEdge:
        return 0.82;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final Widget? iconWidget =
        this.iconWidget ??
        (icon != null
            ? DotsIcon(iconData: icon!, size: 32, color: theme.colors.labelHighlight)
            : null);
    final double height = 64.0;
    final Color bgColor = theme.colors.bgBaseContrast;
    final Color borderColor = theme.colors.bgContainerSecondary;
    return DotsDecoratedBox(
      styleType: theme.styles.defaultShadow,
      child: GestureDetector(
        onTap: () => onTap?.call(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: _borderRadius,
              child: Container(
                constraints: BoxConstraints(maxWidth: maxWidth, minWidth: 185, minHeight: height),
                padding: const EdgeInsets.all(16).copyWith(right: 52),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: _borderRadius,
                  border: Border.all(
                    width: 1,
                    color: borderColor,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    if (iconWidget != null) iconWidget,
                    Expanded(
                      child: Text(
                        text,
                        textAlign: TextAlign.left,
                        style: theme.typo.main.labelDefaultMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            showCloseButton
                ? Positioned(
                    top: 16,
                    right: 16,
                    child: DotsCloseButton(
                      size: DotsCloseButtonSize.small,
                      variant: DotsCloseButtonVariant.softContrast,
                      addBlur: false,
                      onTap: () => onClose?.call(),
                    ),
                  )
                : SizedBox(),
            Positioned(
              top: tailPosition.isBottom ? null : -12,
              bottom: tailPosition.isBottom ? -12 : null,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment(_tailAlignmentX, 0),
                child: ClipPath(
                  clipper: TriangleClipper(isInverted: tailPosition.isBottom),
                  child: CustomPaint(
                    size: const Size(21, 13),
                    painter: TrianglePainter(
                      color: bgColor,
                      borderColor: borderColor,
                      shadow: theme.styles.defaultShadow,
                      isInverted: tailPosition.isBottom,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  final bool isInverted;

  TriangleClipper({required this.isInverted});

  @override
  Path getClip(Size size) {
    late final Path path;
    if (isInverted) {
      path = Path()
        ..moveTo(0, 0)
        ..lineTo(size.width / 2 - 2, size.height - 2)
        ..quadraticBezierTo(size.width / 2, size.height, size.width / 2 + 2, size.height - 2)
        ..lineTo(size.width, 0)
        ..close();
    } else {
      path = Path()
        ..moveTo(0, size.height)
        ..lineTo(size.width / 2 - 2, 2)
        ..quadraticBezierTo(size.width / 2, 0, size.width / 2 + 2, 2)
        ..lineTo(size.width, size.height)
        ..close();
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    if (oldClipper is TriangleClipper) {
      return oldClipper.isInverted != isInverted;
    }
    return false;
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;
  final Color borderColor;
  final DotsStyleShadow shadow;
  final bool isInverted;
  TrianglePainter({
    required this.color,
    required this.borderColor,
    required this.shadow,
    required this.isInverted,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    late final Path path;
    if (isInverted) {
      path = Path()
        ..moveTo(0, 0)
        ..lineTo(size.width / 2 - 2, size.height - 2)
        ..quadraticBezierTo(size.width / 2, size.height, size.width / 2 + 2, size.height - 2)
        ..lineTo(size.width, 0)
        ..close();
    } else {
      path = Path()
        ..moveTo(0, size.height)
        ..lineTo(size.width / 2 - 2, 2)
        ..quadraticBezierTo(size.width / 2, 0, size.width / 2 + 2, 2)
        ..lineTo(size.width, size.height)
        ..close();
    }
    canvas.drawShadow(path, shadow.color, shadow.blurRadius, false);

    canvas.drawPath(path, paint);

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    late final Path borderPath;
    if (isInverted) {
      borderPath = Path()
        ..moveTo(0, 0)
        ..lineTo(size.width / 2 - 2, size.height - 2)
        ..quadraticBezierTo(
          size.width / 2,
          size.height,
          size.width / 2 + 2,
          size.height - 2,
        )
        ..lineTo(size.width, 0);
    } else {
      borderPath = Path()
        ..moveTo(0, size.height)
        ..lineTo(size.width / 2 - 2, 2)
        ..quadraticBezierTo(size.width / 2, 0, size.width / 2 + 2, 2)
        ..lineTo(
          size.width,
          size.height,
        );
    }
    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is TrianglePainter) {
      return oldDelegate.color != color ||
          oldDelegate.borderColor != borderColor ||
          oldDelegate.isInverted != isInverted ||
          oldDelegate.shadow != shadow;
    }
    return false;
  }
}

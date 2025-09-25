import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsTooltip extends StatelessWidget {
  final DotsIconData? icon;
  final String text;
  final Function()? onTap;
  final Function()? onClose;
  final bool showCloseButton;

  final DotsToolTipTailPosition tailPosition;

  const DotsTooltip(
      {super.key,
      required this.text,
      this.onTap,
      this.icon,
      this.showCloseButton = true,
      required this.tailPosition,
      this.onClose});

  BorderRadiusGeometry get _borderRadius {
    switch (tailPosition) {
      case DotsToolTipTailPosition.bottomAlignLeadingEdge:
        return DotsBorderRadius.r24.copyWith(
          bottomLeft: Radius.circular(14),
        );
      case DotsToolTipTailPosition.bottomAlignTrailingEdge:
        return DotsBorderRadius.r24.copyWith(
          bottomRight: Radius.circular(14),
        );
      case DotsToolTipTailPosition.topAlignLeadingEdge:
        return DotsBorderRadius.r24.copyWith(
          topLeft: Radius.circular(14),
        );
      case DotsToolTipTailPosition.topAlignTrailingEdge:
        return DotsBorderRadius.r24.copyWith(
          topRight: Radius.circular(14),
        );
      default:
        return DotsBorderRadius.r24;
    }
  }

  double tailFromBorderWidth() {
    switch (tailPosition) {
      case DotsToolTipTailPosition.bottomAlignLeadingEdge:
      case DotsToolTipTailPosition.topAlignLeadingEdge:
      case DotsToolTipTailPosition.bottomAlignTrailingEdge:
      case DotsToolTipTailPosition.topAlignTrailingEdge:
        return 17;
      case DotsToolTipTailPosition.bottomAlignLeading:
      case DotsToolTipTailPosition.topAlignLeading:
      case DotsToolTipTailPosition.topAlignTrailing:
      case DotsToolTipTailPosition.bottomAlignTrailing:
        return 54;
      case DotsToolTipTailPosition.bottomAlignCenter:
      case DotsToolTipTailPosition.topAlignCenter:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final icon = this.icon;
    final double height = 64.0;
    return DotsDecoratedBox(
      styleType: theme.styles.defaultShadow,
      child: GestureDetector(
        onTap: () => onTap?.call(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 288, minWidth: 185, minHeight: height),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colors.bgContainerPrimary,
                borderRadius: _borderRadius,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  if (icon != null)
                    DotsIcon(
                      iconData: icon,
                      size: 32,
                      color: theme.colors.labelHighlight,
                    ),
                  Expanded(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: theme.typo.main.labelDefaultMedium,
                    ),
                  ),
                  showCloseButton
                      ? DotsCloseButton(
                          size: DotsCloseButtonSize.small,
                          variant: DotsCloseButtonVariant.softContrast,
                          onTap: () => onClose?.call(),
                        )
                      : SizedBox()
                ],
              ),
            ),
            Positioned(
              top: tailPosition.isBottom ? height : -12,
              right: tailPosition.isRight ? tailFromBorderWidth() : null,
              left: tailPosition.isLeft ? tailFromBorderWidth() : null,
              child: Align(
                alignment: Alignment.center,
                child: CustomPaint(
                  size: const Size(21, 12),
                  painter: TrianglePainter(
                      color: theme.colors.bgContainerPrimary,
                      shadow: theme.styles.defaultShadow,
                      isInverted: tailPosition.isBottom),
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
  @override
  Path getClip(Size size) {
    final Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2 - 2, 2)
      ..quadraticBezierTo(
        size.width / 2,
        0,
        size.width / 2 + 2,
        3,
      )
      ..lineTo(size.width, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;
  final DotsStyleShadow shadow;
  final bool isInverted;
  TrianglePainter({
    required this.color,
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
        ..quadraticBezierTo(
          size.width / 2,
          size.height,
          size.width / 2 + 2,
          size.height - 2,
        )
        ..lineTo(size.width, 0)
        ..close();
    } else {
      path = Path()
        ..moveTo(0, size.height)
        ..lineTo(size.width / 2 - 2, 2)
        ..quadraticBezierTo(
          size.width / 2,
          0,
          size.width / 2 + 2,
          2,
        )
        ..lineTo(size.width, size.height)
        ..close();
    }
    canvas.drawShadow(path, shadow.color, shadow.blurRadius, false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is TrianglePainter) {
      return oldDelegate.color != color ||
          oldDelegate.isInverted != isInverted ||
          oldDelegate.shadow != shadow;
    }
    return false;
  }
}

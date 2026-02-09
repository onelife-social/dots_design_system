import 'dart:math';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class MilestonesList extends StatelessWidget {
  final List<dynamic> list;

  final double cardHeight = 326;
  final double badgeHeight = 17;
  final double tailExtension = 64; // extend line beyond last card

  const MilestonesList({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final int count = list.length;

    final Color lineColor = theme.colors.labelSecondary;
    final double lineWidth = 2;
    final double lineDotsSpacing = 8;

    final double topPadding = badgeHeight / 2; // first item is always a badge
    final double bottomPadding = cardHeight / 2 + tailExtension; // last item is always a card
    final double totalHeight = _totalHeight(list, topPadding, bottomPadding);

    return SingleChildScrollView(
      child: SizedBox(
        height: totalHeight,
        child: LayoutBuilder(
          builder: (_, constraints) {
            final double centerX = constraints.maxWidth / 2;
            final List<Offset> points = _generatePoints(list, count, centerX, topPadding);

            return Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _BezierTimelinePainter(
                      lineColor: lineColor,
                      dotRadius: lineWidth / 2,
                      spacing: lineDotsSpacing,
                      points: points,
                    ),
                  ),
                ),

                for (int i = 0; i < count; i++)
                  Positioned(
                    left: points[i].dx,
                    top: points[i].dy,
                    child: FractionalTranslation(
                      translation: const Offset(-0.5, -0.5),
                      child: Builder(
                        builder: (_) {
                          final item = list[i];
                          if (item is String) {
                            return BadgeMilestone(
                              content: item,
                              variant: BadgeMilestoneVariant.ghost,
                            );
                          } else if (item is MilestoneCard) {
                            return item;
                          } else {
                            return const Offstage();
                          }
                        },
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  double _totalHeight(List<dynamic> items, double topPadding, double bottomPadding) {
    double totalHeight = topPadding;

    for (int i = 0; i < items.length - 1; i++) {
      totalHeight += _verticalSpacing(items[i], items[i + 1], i);
    }

    return totalHeight + bottomPadding;
  }

  double _verticalSpacing(Object curr, Object next, int index) {
    final bool currIsCard = curr is MilestoneCard;
    final bool nextIsCard = next is MilestoneCard;

    final double currHeight = currIsCard ? cardHeight : badgeHeight;
    final double nextHeight = nextIsCard ? cardHeight : badgeHeight;
    // gap = random 8-20 between cards, 64 between badge and card or card and badge
    final double gap = (currIsCard && nextIsCard) ? (8.0 + Random().nextInt(13)) : 64.0;

    return (currHeight / 2) + gap + (nextHeight / 2);
  }

  List<Offset> _generatePoints(
    List<dynamic> items,
    int count,
    double centerX,
    double topPadding,
  ) {
    final List<int> pattern1 = [0, -23, 37, 16, -38];
    final List<int> pattern2 = [0, -38, 37, -39, 29, 37];
    List<int> selectedPattern = pattern1; // starts with pattern1, then randomly alternates

    List<int> xPositions = [];
    while (xPositions.length < count) {
      for (final x in selectedPattern) {
        xPositions.add(x);
        if (xPositions.length == count) break;
      }
      selectedPattern = Random().nextBool() ? pattern1 : pattern2;
    }

    final List<Offset> finalPoints = [];
    double accumulatedYPosition = topPadding;
    for (int i = 0; i < count; i++) {
      finalPoints.add(Offset(centerX + xPositions[i], accumulatedYPosition));
      if (i < count - 1) {
        accumulatedYPosition += _verticalSpacing(items[i], items[i + 1], i);
      }
    }

    // Extend the line, assuming a fake last card
    if (count > 0) {
      final double extraY = accumulatedYPosition + (cardHeight / 2) + tailExtension;
      final double lastX = centerX + xPositions[count - 1];
      finalPoints.add(Offset(lastX, extraY));
    }

    return finalPoints;
  }
}

class _BezierTimelinePainter extends CustomPainter {
  final Color lineColor;
  final double dotRadius;
  final double spacing;
  final List<Offset> points;

  _BezierTimelinePainter({
    required this.lineColor,
    required this.dotRadius,
    required this.spacing,
    required this.points,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double bend = 20.0;
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      final prev = points[i - 1];
      final curr = points[i];
      final double midX = (prev.dx + curr.dx) / 2;
      final double midY = (prev.dy + curr.dy) / 2;
      final double dir = (curr.dx - prev.dx) >= 0 ? 1.0 : -1.0;
      final double controlX = midX + (bend * dir);
      final double controlY = midY;
      path.quadraticBezierTo(controlX, controlY, curr.dx, curr.dy);
    }

    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;

    for (final metric in path.computeMetrics()) {
      for (double d = 0.0; d <= metric.length; d += spacing) {
        final tangent = metric.getTangentForOffset(d);
        if (tangent != null) {
          canvas.drawCircle(tangent.position, dotRadius, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BezierTimelinePainter oldDelegate) {
    return false;
  }
}

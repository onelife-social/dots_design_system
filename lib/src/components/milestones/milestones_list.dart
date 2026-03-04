import 'dart:math';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class MilestonesList extends StatefulWidget {
  final List<dynamic> list;
  final int seed;

  final double cardHeight = 326;
  final double badgeHeight = 17;
  final double tailExtension = 64; // extend line beyond last card

  const MilestonesList({
    super.key,
    required this.list,
    required this.seed,
  });

  @override
  State<MilestonesList> createState() => _MilestonesListState();
}

class _MilestonesListState extends State<MilestonesList> {
  late List<GlobalKey> _itemKeys;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _itemKeys = List.generate(widget.list.length, (index) => GlobalKey());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedItem();
    });
  }

  @override
  void didUpdateWidget(MilestonesList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.list.length != widget.list.length) {
      _itemKeys = List.generate(widget.list.length, (index) => GlobalKey());
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedItem();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelectedItem() {
    for (int i = 0; i < widget.list.length; i++) {
      final item = widget.list[i];
      if (item is MilestoneCard && item.isSelected) {
        final context = _itemKeys[i].currentContext;
        if (context != null) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 50),
            curve: Curves.easeInOut,
            alignment: 0.5,
          );
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final int count = widget.list.length;

    final Color lineColor = theme.colors.labelSecondary;
    final double lineWidth = 2;
    final double lineDotsSpacing = 8;

    final double topPadding = widget.badgeHeight / 2; // first item is always a badge
    final double bottomPadding =
        widget.cardHeight / 2 + widget.tailExtension; // last item is always a card
    final Random random = Random(widget.seed);
    final double totalHeight = _totalHeight(
      widget.list,
      topPadding,
      bottomPadding,
      random,
    );

    return SingleChildScrollView(
      controller: _scrollController,
      child: SizedBox(
        height: totalHeight,
        child: LayoutBuilder(
          builder: (_, constraints) {
            final double centerX = constraints.maxWidth / 2;
            final List<Offset> points = _generatePoints(
              widget.list,
              count,
              centerX,
              topPadding,
              random,
            );

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
                    key: _itemKeys[i],
                    left: points[i].dx,
                    top: points[i].dy,
                    child: FractionalTranslation(
                      translation: const Offset(-0.5, -0.5),
                      child: Builder(
                        builder: (_) {
                          final item = widget.list[i];
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

  double _totalHeight(
    List<dynamic> items,
    double topPadding,
    double bottomPadding,
    Random random,
  ) {
    double totalHeight = topPadding;

    for (int i = 0; i < items.length - 1; i++) {
      totalHeight += _verticalSpacing(items[i], items[i + 1], random);
    }

    return totalHeight + bottomPadding;
  }

  double _verticalSpacing(Object curr, Object next, Random random) {
    final bool currIsCard = curr is MilestoneCard;
    final bool nextIsCard = next is MilestoneCard;

    final double currHeight = currIsCard ? widget.cardHeight : widget.badgeHeight;
    final double nextHeight = nextIsCard ? widget.cardHeight : widget.badgeHeight;
    // gap = random 20-34 between cards, 64 between badge and card or card and badge
    final double gap = (currIsCard && nextIsCard) ? (20.0 + random.nextInt(15)) : 64.0;

    return (currHeight / 2) + gap + (nextHeight / 2);
  }

  List<Offset> _generatePoints(
    List<dynamic> items,
    int count,
    double centerX,
    double topPadding,
    Random random,
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
      selectedPattern = random.nextBool() ? pattern1 : pattern2;
    }

    final List<Offset> finalPoints = [];
    double accumulatedYPosition = topPadding;
    for (int i = 0; i < count; i++) {
      finalPoints.add(Offset(centerX + xPositions[i], accumulatedYPosition));
      if (i < count - 1) {
        accumulatedYPosition += _verticalSpacing(items[i], items[i + 1], random);
      }
    }

    // Extend the line, assuming a fake last card
    if (count > 0) {
      final double extraY = accumulatedYPosition + (widget.cardHeight / 2) + widget.tailExtension;
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
    return oldDelegate.lineColor != lineColor ||
        oldDelegate.dotRadius != dotRadius ||
        oldDelegate.spacing != spacing ||
        oldDelegate.points != points;
  }
}

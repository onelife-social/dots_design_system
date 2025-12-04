import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../dots_design_system.dart';

class ImageWithProgressAround extends StatefulWidget {
  /// The progress value, between 0.0 and 1.0
  final double progress;

  /// The image provider to display in the center of the progress indicator.
  final ImageProvider? imageProvider;

  /// The width of the widget.
  final double width;

  /// The width (thickness) of the progress bar border.
  final double progressBarWidth;

  /// The padding between the inner image and the progress bar.
  final double innerPadding;

  /// The border radius for the rounded corners of the image and progress bar.
  final double borderRadius;

  const ImageWithProgressAround({
    super.key,
    required this.width,
    required this.progress,
    this.imageProvider,
    this.progressBarWidth = 6.0,
    this.innerPadding = 8.0,
    this.borderRadius = 45.0,
  });

  static const double kStandardAspectRatio = 9 / 16;
  static const double kSmallAspectRatio = 3 / 4;

  @override
  State<ImageWithProgressAround> createState() => _ImageWithProgressAroundState();
}

class _ImageWithProgressAroundState extends State<ImageWithProgressAround>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  double _previousProgress = 0.0;
  final animationDuration = const Duration(milliseconds: 300);
  final animationCurve = Curves.easeInOut;

  @override
  void initState() {
    super.initState();
    _previousProgress = widget.progress;
    _animationController = AnimationController(duration: animationDuration, vsync: this);
    _progressAnimation = Tween<double>(
      begin: _previousProgress,
      end: widget.progress,
    ).animate(CurvedAnimation(parent: _animationController, curve: animationCurve));
    _animationController.value = 1.0;
  }

  @override
  void didUpdateWidget(ImageWithProgressAround oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _previousProgress = _progressAnimation.value;
      _progressAnimation = Tween<double>(
        begin: _previousProgress,
        end: widget.progress,
      ).animate(CurvedAnimation(parent: _animationController, curve: animationCurve));
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const progressBarColors = [
      Color(0xFFEF5FC1),
      Color(0xFFC982F7),
      Color(0xFF15ABF3),
      Color(0xFFB295B6),
      Color(0xFFF5784D),
      Color(0xFFEF9C5F),
      Color(0xFFF44E69),
      Color(0xFFEF5FC1),
    ];

    return SizedBox(
      width: widget.width,
      child: AspectRatio(
        aspectRatio: context.isSmallScreen
            ? ImageWithProgressAround.kSmallAspectRatio
            : ImageWithProgressAround.kStandardAspectRatio,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              padding: EdgeInsets.all(widget.innerPadding + widget.progressBarWidth),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: Stack(
                  children: [
                    _MemoryImage(
                      imageProvider: widget.imageProvider,
                      animationDuration: animationDuration,
                      animationCurve: animationCurve,
                    ),
                    Container(
                      color: Colors.black.dotsWithOpacity(0.2),
                      child: AnimatedBuilder(
                        animation: _progressAnimation,
                        builder: (context, child) {
                          return _ProgressText(progress: _progressAnimation.value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: _BorderProgressPainter(
                    progress: _progressAnimation.value,
                    strokeWidth: widget.progressBarWidth,
                    gradient: progressBarColors,
                    backgroundColor: context.dotsTheme.colors.bgSecondaryBtn,
                    borderRadius: widget.borderRadius,
                    padding: widget.innerPadding,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MemoryImage extends StatelessWidget {
  final ImageProvider? imageProvider;
  final Duration animationDuration;
  final Curve animationCurve;

  const _MemoryImage({
    this.imageProvider,
    required this.animationDuration,
    required this.animationCurve,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedSwitcher(
        duration: animationDuration,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: animationCurve,
            ),
            child: child,
          );
        },
        child: imageProvider == null
            ? SizedBox.shrink(key: const ValueKey(null))
            : SizedBox.expand(
                key: ValueKey(imageProvider),
                child: Image(
                  image: imageProvider!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => SizedBox.shrink(),
                ),
              ),
      ),
    );
  }
}

class _ProgressText extends StatelessWidget {
  final double progress;

  const _ProgressText({required this.progress});

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Center(
      child: Text(
        '${(progress * 100).toStringAsFixed(0)}%',
        style: theme.typo.main.titleH3.copyWith(color: theme.colors.labelAlwaysWhite),
      ),
    );
  }
}

class _BorderProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final List<Color> gradient;
  final Color backgroundColor;
  final double borderRadius;
  final double padding;

  _BorderProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.gradient,
    required this.backgroundColor,
    required this.borderRadius,
    required this.padding,
  });

  // Add padding to radius so the outer progress bar corners match the inner image corners visually
  double get radius => borderRadius + padding + strokeWidth / 2;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw on the outer border (without padding) but use the same radius as the inner image
    // Subtract half strokeWidth from each side so the stroke is centered on the edge
    final halfStroke = strokeWidth / 2;
    final rect = Rect.fromLTWH(
      halfStroke,
      halfStroke,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    // Draw background border (always visible)
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final backgroundPath = Path()..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));

    canvas.drawPath(backgroundPath, backgroundPaint);

    // Draw progress border
    // Normalize progress: if > 1, treat as percentage (divide by 100), otherwise use as-is
    final normalizedProgress = progress > 1.0
        ? (progress / 100.0).clamp(0.0, 1.0)
        : progress.clamp(0.0, 1.0);

    if (normalizedProgress > 0) {
      final progressPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      progressPaint.shader = SweepGradient(colors: gradient).createShader(rect);

      // Calculate the path length (perimeter of rounded rectangle)
      // Calculate exactly as the path is built, segment by segment
      final topEdgeHalf = (rect.width / 2) - radius;
      final cornerLength = math.pi * radius / 2;
      final rightEdgeLength = rect.height - 2 * radius;
      final bottomEdgeLength = rect.width - 2 * radius;
      final leftEdgeLength = rect.height - 2 * radius;

      final perimeter =
          topEdgeHalf +
          cornerLength +
          rightEdgeLength +
          cornerLength +
          bottomEdgeLength +
          cornerLength +
          leftEdgeLength +
          cornerLength +
          topEdgeHalf;

      // Draw progress along the border starting from top center, going clockwise
      final progressLength = perimeter * normalizedProgress;
      final progressPath = _createProgressPath(rect, radius, progressLength, perimeter, halfStroke);

      canvas.drawPath(progressPath, progressPaint);
    }
  }

  Path _createProgressPath(
    Rect rect,
    double radius,
    double progressLength,
    double totalLength,
    double halfStroke,
  ) {
    final path = Path();
    double currentLength = 0;
    const pi = math.pi;

    // Start from top center, going clockwise
    final startX = rect.left + rect.width / 2;
    final startY = rect.top;
    path.moveTo(startX, startY);

    // Calculate distance from center to right corner
    final centerToRightCorner = (rect.width / 2) - radius;

    // 1. Top edge: from center to right corner (going right)
    if (currentLength + centerToRightCorner <= progressLength) {
      path.lineTo(rect.left + rect.width - radius, startY);
      currentLength += centerToRightCorner;
    } else {
      final remaining = progressLength - currentLength;
      path.lineTo(startX + remaining, startY);
      return path;
    }

    // 2. Top-right corner (quarter circle, clockwise)
    final cornerLength = pi * radius / 2;
    // The arc center is at (rect.right - radius, rect.top + radius)
    final topRightCornerRect = Rect.fromLTWH(
      rect.left + rect.width - radius * 2,
      rect.top,
      radius * 2,
      radius * 2,
    );
    if (currentLength + cornerLength <= progressLength) {
      path.addArc(topRightCornerRect, -pi / 2, pi / 2);
      currentLength += cornerLength;
    } else {
      final remaining = progressLength - currentLength;
      final sweepAngle = remaining / radius; // sweep angle in radians
      path.addArc(topRightCornerRect, -pi / 2, sweepAngle);
      return path;
    }

    // 3. Right edge (top to bottom)
    final rightEdgeLength = rect.height - 2 * radius;
    if (currentLength + rightEdgeLength <= progressLength) {
      path.lineTo(rect.left + rect.width, rect.top + rect.height - radius);
      currentLength += rightEdgeLength;
    } else {
      final remaining = progressLength - currentLength;
      path.lineTo(rect.left + rect.width, rect.top + radius + remaining);
      return path;
    }

    // 4. Bottom-right corner (clockwise)
    // The arc center is at (rect.right - radius, rect.bottom - radius)
    final bottomRightCornerRect = Rect.fromLTWH(
      rect.left + rect.width - radius * 2,
      rect.top + rect.height - radius * 2,
      radius * 2,
      radius * 2,
    );
    if (currentLength + cornerLength <= progressLength) {
      path.addArc(bottomRightCornerRect, 0, pi / 2);
      currentLength += cornerLength;
    } else {
      final remaining = progressLength - currentLength;
      final sweepAngle = remaining / radius;
      path.addArc(bottomRightCornerRect, 0, sweepAngle);
      return path;
    }

    // 5. Bottom edge (right to left)
    final bottomEdgeLength = rect.width - 2 * radius;
    if (currentLength + bottomEdgeLength <= progressLength) {
      path.lineTo(rect.left + radius, rect.top + rect.height);
      currentLength += bottomEdgeLength;
    } else {
      final remaining = progressLength - currentLength;
      path.lineTo(rect.left + rect.width - radius - remaining, rect.top + rect.height);
      return path;
    }

    // 6. Bottom-left corner (clockwise)
    // The arc center is at (rect.left + radius, rect.bottom - radius)
    final bottomLeftCornerRect = Rect.fromLTWH(
      rect.left,
      rect.top + rect.height - radius * 2,
      radius * 2,
      radius * 2,
    );
    if (currentLength + cornerLength <= progressLength) {
      path.addArc(bottomLeftCornerRect, pi / 2, pi / 2);
      currentLength += cornerLength;
    } else {
      final remaining = progressLength - currentLength;
      final sweepAngle = remaining / radius;
      path.addArc(bottomLeftCornerRect, pi / 2, sweepAngle);
      return path;
    }

    // 7. Left edge (bottom to top)
    final leftEdgeLength = rect.height - 2 * radius;
    if (currentLength + leftEdgeLength <= progressLength) {
      path.lineTo(rect.left, rect.top + radius);
      currentLength += leftEdgeLength;
    } else {
      final remaining = progressLength - currentLength;
      path.lineTo(rect.left, rect.top + rect.height - radius - remaining);
      return path;
    }

    // 8. Top-left corner (clockwise, back to center)
    // The arc center is at (rect.left + radius, rect.top + radius)
    final topLeftCornerRect = Rect.fromLTWH(rect.left, rect.top, radius * 2, radius * 2);
    if (currentLength + cornerLength <= progressLength) {
      path.addArc(topLeftCornerRect, pi, pi / 2);
      currentLength += cornerLength;
    } else {
      final remaining = progressLength - currentLength;
      final sweepAngle = remaining / radius;
      path.addArc(topLeftCornerRect, pi, sweepAngle);
      return path;
    }

    // 9. Top edge: from left corner back to center (going right)
    final topEdgeHalfBack = (rect.width / 2) - radius;
    final remaining = progressLength - currentLength;
    if (remaining > 0) {
      if (remaining >= topEdgeHalfBack) {
        path.lineTo(startX, startY);
        currentLength += topEdgeHalfBack;
      } else {
        path.lineTo(rect.left + radius + remaining, startY);
      }
    }

    return path;
  }

  @override
  bool shouldRepaint(_BorderProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

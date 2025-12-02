import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

/// Conventional progress but divided in parts
class DotsProgressBar extends StatelessWidget {
  /// Percentage of the progress, must be between 0 and 1.
  final double percentage;

  /// Parts progress is divided, must be more than 0.
  final int parts;

  /// Width of the progress bar.
  final double width;

  /// Space between each part.
  final double spaceBetween;

  /// Color of the progress bar.
  final Color? barColor;

  /// Color of the background of the progress bar.
  final Color? bgColor;

  const DotsProgressBar({
    super.key,
    required this.percentage,
    this.parts = 3,
    this.width = double.infinity,
    this.spaceBetween = 5,
    this.barColor,
    this.bgColor,
  }) : assert(
         percentage <= 1 && percentage >= 0,
         'Percentage must be between 1 and 0 both inclusive',
       ),
       assert(parts > 0, 'Parts must be more than 0');

  factory DotsProgressBar.byStep(int stepNumber, int totalSteps) {
    assert(stepNumber <= totalSteps, 'Step number must be less than or equal to $totalSteps');

    return DotsProgressBar(percentage: stepNumber / totalSteps);
  }

  @override
  Widget build(BuildContext context) {
    final Color finalBarColor = barColor ?? context.dotsTheme.colors.labelHighlight;
    final Color finalBgColor = bgColor ?? context.dotsTheme.colors.labelSecondary;

    return SizedBox(
      height: 5,
      width: width,
      child: CustomPaint(
        painter: _MultiStepProgressPainter(
          percentage: percentage,
          parts: parts,
          spaceBetween: spaceBetween,
          colorPrimary: finalBarColor,
          colorBackground: finalBgColor,
        ),
      ),
    );
  }
}

class _MultiStepProgressPainter extends CustomPainter {
  final double percentage;
  final int parts;
  final Color colorPrimary;
  final Color colorBackground;
  final double spaceBetween;

  _MultiStepProgressPainter({
    required this.percentage,
    required this.colorPrimary,
    required this.colorBackground,
    required this.parts,
    required this.spaceBetween,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final List<RRect> enabledRectList = [];
    final List<RRect> disabledRectList = [];
    final widthOfEach = ((size.width - ((parts - 1) * spaceBetween)) / parts);
    final separation = size.width * percentage;

    for (int i = 0; i < parts; i++) {
      final startPoint = (widthOfEach + spaceBetween) * i;
      final endPoint = startPoint + widthOfEach;
      final rectToAdd = RRect.fromRectAndRadius(
        Rect.fromLTRB(startPoint, 0, endPoint, 5),
        const Radius.circular(100),
      );

      if (startPoint < separation && endPoint < separation) {
        enabledRectList.add(rectToAdd);
      } else if (startPoint > separation && endPoint > separation) {
        disabledRectList.add(rectToAdd);
      } else {
        disabledRectList.add(rectToAdd);
        enabledRectList.add(
          RRect.fromRectAndRadius(
            Rect.fromLTRB(startPoint, 0, separation, 5),
            const Radius.circular(100),
          ),
        );
      }
    }

    for (final rect in disabledRectList) {
      canvas.drawRRect(rect, Paint()..color = colorBackground);
    }
    for (final rect in enabledRectList) {
      canvas.drawRRect(rect, Paint()..color = colorPrimary);
    }
  }

  @override
  bool shouldRepaint(covariant _MultiStepProgressPainter oldDelegate) =>
      percentage != oldDelegate.percentage ||
      parts != oldDelegate.parts ||
      colorPrimary != oldDelegate.colorPrimary ||
      colorBackground != oldDelegate.colorBackground;
}

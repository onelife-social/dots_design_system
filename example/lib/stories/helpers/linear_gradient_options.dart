import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class LinearGradientOptions {
  static linearGradientBlur(BuildContext context) {
    return context.knobs.options<LinearGradientBlur>(
      label: 'Linear Gradient Blur',
      initial: const LinearGradientBlur(
        values: [0.0, 1.0],
        stops: [0.0, 1.0],
        start: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      options: const [
        LinearGradientBlur(
          values: [0.0, 1.0],
          stops: [0.0, 1.0],
          start: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        LinearGradientBlur(
          values: [0.0, 0.6, 1.0],
          stops: [0.0, 0.7, 1.0],
          start: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        LinearGradientBlur(
          values: [1.0, 0.0],
          stops: [0.0, 1.0],
          start: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        LinearGradientBlur(
          values: [0.0, 1.0],
          stops: [0.0, 1.0],
          start: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        LinearGradientBlur(
          values: [1.0, 0.0],
          stops: [0.0, 1.0],
          start: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
        LinearGradientBlur(
          values: [1.0, 0.0, 1.0],
          stops: [0.0, 0.5, 1.0],
          start: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ]
          .map(
            (g) => Option(
              label:
                  '${g.start.x.toStringAsFixed(1)},${g.start.y.toStringAsFixed(1)} -> ${g.end.x.toStringAsFixed(1)},${g.end.y.toStringAsFixed(1)}  v:${g.values.join('/')}',
              value: g,
            ),
          )
          .toList(),
    );
  }
}

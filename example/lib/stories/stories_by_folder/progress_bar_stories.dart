import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

enum ProgressBarColorListOption {
  recap,
  fixed,
}

List<Color> _progressBarColorsFromOption(
  ProgressBarColorListOption option,
  Color fixedColor,
) {
  switch (option) {
    case ProgressBarColorListOption.recap:
      return DotsColors.recapGradientColors;
    case ProgressBarColorListOption.fixed:
      return [
        fixedColor,
        fixedColor,
      ];
  }
}

List<Story> get progressBarStories => [
      Story(
        name: 'Progress Bar/Image with progress around',
        description: 'Demo page for Image with progress around',
        builder: (context) {
          final theme = context.dotsTheme;

          final ProgressBarColorListOption colorListOption = context.knobs.options(
            label: 'Progress bar color list',
            initial: ProgressBarColorListOption.recap,
            options: const [
              Option(label: 'Recap', value: ProgressBarColorListOption.recap),
              Option(label: 'Fixed color', value: ProgressBarColorListOption.fixed),
            ],
          );
          final Color fixedColor = context.knobs.options<Color>(
            label: 'Progress bar fixed color',
            initial: DotsColors.recapGradientColors[0],
            options: [
              Option(label: 'Blue', value: theme.colors.labelHighlight),
              Option(label: 'Red', value: theme.colors.labelDestructive),
            ],
          );

          return ImageWithProgressAround(
            width: context.knobs.slider(label: 'Width', initial: 300, min: 50, max: 400),
            progress: context.knobs.slider(label: 'Progress', initial: 0.5, min: 0, max: 1),
            percentageTextStyle: context.knobs.boolean(label: 'Show percentage text style', initial: true)
              ? theme.typo.main.titleH6
              : null,
            imageProvider: NetworkImage(context.knobs
                .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9')),
            progressBarWidth:
                context.knobs.slider(label: 'Progress bar width', initial: 6, min: 0, max: 20),
            innerPadding: context.knobs.slider(label: 'Inner padding', initial: 8, min: 0, max: 40),
            progressBarColors: _progressBarColorsFromOption(colorListOption, fixedColor),
            borderRadius:
                context.knobs.slider(label: 'Border radius', initial: 45, min: 0, max: 100),
            animationDuration: Duration(
                seconds: context.knobs
                    .slider(label: 'Animation duration', initial: 1.8, min: 0.0, max: 3.0)
                    .toInt()),
          );
        },
      ),
      Story(
        name: 'Progress Bar/ProgressBar',
        description: 'Demo page for ProgressBar',
        builder: (context) => DotsProgressBar(
          percentage: context.knobs.slider(
            label: 'Percentage',
            initial: 0.5,
            min: 0,
            max: 1,
          ),
          parts: context.knobs
              .slider(
                label: 'Parts',
                initial: 2,
                min: 1,
                max: 3,
              )
              .toInt(),
          width: context.knobs.slider(
            label: 'Width',
            initial: 110,
            min: 50,
            max: 300,
          ),
        ),
      ),
    ];

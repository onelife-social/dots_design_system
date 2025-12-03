import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get progressBarStories => [
      Story(
        name: 'Progress Bar/Image with progress around',
        description: 'Demo page for Image with progress around',
        builder: (context) => ImageWithProgressAround(
          width: context.knobs.slider(label: 'Width', initial: 300, min: 50, max: 400),
          progress: context.knobs.slider(label: 'Progress', initial: 0.5, min: 0, max: 1),
          imageProvider: NetworkImage(
              context.knobs.text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9')),
          progressBarWidth: context.knobs.slider(label: 'Progress bar width', initial: 6, min: 0, max: 20),
          innerPadding: context.knobs.slider(label: 'Inner padding', initial: 8, min: 0, max: 40),
          borderRadius: context.knobs.slider(label: 'Border radius', initial: 45, min: 0, max: 100),
        ),
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

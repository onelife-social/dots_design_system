
import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get separatorStories => [
  Story(
    name: 'Separators/Activity Group Header',
    description: 'Demo page for Activity Group Header',
    builder: (context) {
      final showNumber = context.knobs.boolean(label: 'Show number', initial: true);
      final numberValue = showNumber
          ? context.knobs.text(label: 'Number', initial: '3').trim()
          : null;

      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: DotsActivityGroupHeader(
            text: context.knobs.text(label: 'Text', initial: 'This is a separator'),
            number: numberValue?.isEmpty == true ? null : numberValue,
            topLineSeparator: context.knobs.boolean(label: 'Top Line Separator', initial: true),
          ),
        ),
      );
    },
  ),
];
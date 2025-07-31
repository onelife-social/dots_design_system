
import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get separatorStories => [
  Story(
    name: 'Separators/Text Separator',
    description: 'Demo page for Text Separator',
    builder: (context) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: DotsTextSeparator(
          text: context.knobs.text(label: 'Text', initial: 'This is a separator'),
          topLineSeparator: context.knobs.boolean(label: 'Top Line Separator', initial: true),
        ),
      ),
    ),
  ),
];

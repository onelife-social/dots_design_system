import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get selectorRadioButtonStories => [
      Story(
        name: 'Selector/Selector Radio Button',
        description: 'Demo page for Selector Radio Button',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotsSelectorRadioButton(
            isSelected: context.knobs.boolean(label: 'Is Selected', initial: false),
            title: context.knobs.text(label: 'Title', initial: 'Title'),
            icon1: context.knobs.options<DotsIconData>(
              label: 'Icon 1',
              initial: DotsIconData.clockFilled,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            icon1Size: context.knobs.slider(
              label: 'Icon 1 Size',
              initial: 16,
              min: 8,
              max: 32,
            ),
            details1: context.knobs.text(label: 'Details 1', initial: 'Details 1'),
            icon2: context.knobs.options<DotsIconData>(
              label: 'Icon 2',
              initial: DotsIconData.calendar,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            icon2Size: context.knobs.slider(
              label: 'Icon 2 Size',
              initial: 16,
              min: 8,
              max: 32,
            ),
            details2: context.knobs.text(label: 'Details 2', initial: 'Details 2'),
            onTap: () {},
          ),
        ),
      ),
      Story(
        name: 'Selector/Selector Radio Button Label',
        description: 'Demo page for Selector Radio Button Label',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotsSelectorRadioButtonLabel(
            isSelected: context.knobs.boolean(label: 'Is Selected', initial: false),
            free: context.knobs.boolean(label: 'Free', initial: false),
            title: context.knobs.text(label: 'Title', initial: 'Title'),
            details1: context.knobs.text(label: 'Details 1', initial: 'Details 1'),
            details2: context.knobs.text(label: 'Details 2', initial: 'Details 2'),
            tagText: context.knobs.text(label: 'Tag Text', initial: 'Tag Text'),
            onTap: () {},
          ),
        ),
      ),
    ];

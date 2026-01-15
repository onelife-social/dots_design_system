import 'package:dots_design_system/dots_design_system.dart';
import 'package:example/components/segmented_control_handle.dart';
import 'package:example/stories/helpers/color_knob_options.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get segmentedControlStories => [
      Story(
        name: 'Segmented Control/Segmented control',
        description: 'Demo page for Segmented control',
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SegmentedControlHandle(
              key: ValueKey('SegmentedControlHandle'),
              leftOptionName: context.knobs.text(label: 'Option 1', initial: 'Option 1'),
              rightOptionName: context.knobs.text(label: 'Option 2', initial: 'Option 2'),
              selectedColor: knobColorSelector(context, 'Selected color'),
              backgroundColor: knobColorSelector(context, 'Background color'),
              rightOptionTag: context.knobs.text(label: 'Option 2 tag', initial: '2'),
            ),
          );
        },
      ),
      Story(
        name: 'Segmented Control/SegmentedControlIcon',
        description: 'Demo page for SegmentedControlIcon',
        builder: (context) {
          SegmentedControlOption selectedOption = SegmentedControlOption.left;

          return StatefulBuilder(
            builder: (context, setState) {
              return SegmentedControlIcon(
                key: ValueKey('SegmentedControlIcon'),
                leftOptionIcon: context.knobs.options<DotsIconData>(
                  label: 'Left option icon',
                  initial: DotsIconData.gridOutline,
                  options: DotsIconData.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList(),
                ),
                rightOptionIcon: context.knobs.options<DotsIconData>(
                  label: 'Right option icon',
                  initial: DotsIconData.calendar,
                  options: DotsIconData.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList(),
                ),
                selectedOption: selectedOption,
                onTapOption: (option) {
                  setState(() => selectedOption = option);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Value changed to: ${option.name}')),
                  );
                },
              );
            },
          );
        },
      ),
      Story(
        name: 'Segmented Control/Segmented control single',
        description: 'Demo page for Segmented control with a single button',
        builder: (context) {
          return SegmentedControlSingle(
            key: ValueKey('SegmentedControlSingle'),
            buttonName: context.knobs.text(label: 'Button name', initial: 'Button'),
            selectedColor: knobColorSelector(context, 'Selected color'),
            backgroundColor: knobColorSelector(context, 'Background color'),
            buttonTag: context.knobs.text(label: 'Button tag', initial: '1'),
          );
        },
      ),
    ];

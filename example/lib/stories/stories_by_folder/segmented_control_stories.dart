import 'package:dots_design_system/dots_design_system.dart';
import 'package:example/components/segmented_control_handle.dart';
import 'package:example/stories/helpers/color_knob_options.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../components/segmented_control_price_handle.dart';

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
              variant: context.knobs.options<SegmentedControlVariant>(
                label: 'Variant',
                initial: SegmentedControlVariant.main,
                options: SegmentedControlVariant.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList(),
              ),
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
      Story(
        name: 'Segmented Control/Segmented control price',
        description: 'Demo page for Segmented control for price options',
        builder: (context) {
          final variant = context.knobs.options<SegmentedControlPriceVariant>(
            label: 'Variant',
            initial: SegmentedControlPriceVariant.dual,
            options: SegmentedControlPriceVariant.values
                .map((item) => Option(label: item.name, value: item))
                .toList(),
          );

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SegmentedControlPriceHandle(
              key: ValueKey('SegmentedControlPriceHandle_${variant.name}'),
              variant: variant,
              leftOptionName: context.knobs.text(label: 'Option 1', initial: 'Label'),
              leftOptionPrice: context.knobs.text(label: 'Option 1 price', initial: '99,00€'),
              leftOptionTag: context.knobs.text(label: 'Option 1 tag', initial: '17% OFF'),
              leftOptionDescription:
                  context.knobs.text(label: 'Option 1 description', initial: '8,25€/mes'),
              leftOptionPriceTrailing:
                  context.knobs.text(label: 'Option 1 price trailing', initial: '/ano'),
              rightOptionName: variant.isDual
                  ? context.knobs.text(label: 'Option 2', initial: 'Label')
                  : null,
              rightOptionPrice: variant.isDual
                  ? context.knobs.text(label: 'Option 2 price', initial: '100,00€')
                  : null,
              rightOptionTag: variant.isDual
                  ? context.knobs.text(label: 'Option 2 tag', initial: '17% OFF')
                  : null,
              rightOptionDescription: variant.isDual
                  ? context.knobs.text(label: 'Option 2 description', initial: '8,25€/mes')
                  : null,
              rightOptionPriceTrailing: variant.isDual
                  ? context.knobs.text(label: 'Option 2 price trailing', initial: '/ano')
                  : null,
              selectedColor: knobColorSelector(context, 'Selected color'),
              backgroundColor: knobColorSelector(context, 'Background color'),
            ),
          );
        },
      ),
    ];

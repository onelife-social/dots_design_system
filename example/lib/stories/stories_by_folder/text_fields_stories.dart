import 'package:dots_design_system/dots_design_system.dart';
import 'package:example/stories/helpers/color_knob_options.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get textFieldStories => [
      Story(
        name: 'TextFields/TextField',
        description: 'Demo page for plain text field',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotsTextField(
            controller: TextEditingController(),
            focusNode: FocusNode(),
            iconData: context.knobs.nullable.options<DotsIconData>(
              label: 'Icon',
              initial: DotsIconData.search,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            hintText: context.knobs.text(label: 'Hint Text', initial: 'Enter text'),
            isError: context.knobs.boolean(label: 'Is Error?', initial: false),
            errorText: context.knobs.nullable.text(label: 'Error Text', initial: 'Error message'),
            background: context.knobs.boolean(label: 'Background?', initial: true),
            alignCenter: context.knobs.boolean(label: 'Align Center?', initial: false),
          ),
        ),
      ),
      Story(
        name: 'TextFields/TextFieldButton',
        description: 'Demo page for text field with button',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotsTextFieldButton(
            alignCenter: context.knobs.boolean(
              label: 'Align Center',
              initial: false,
            ),
            iconData: context.knobs.nullable.options<DotsIconData>(
              label: 'Icon Data',
              initial: DotsIconData.search,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            hintText: context.knobs.nullable.text(label: 'Hint Text', initial: 'Enter text') ??
                'Enter text',
            onChanged: (value) {},
            isError: context.knobs.boolean(label: 'Is Error?', initial: false),
            errorText: context.knobs.nullable.text(label: 'Error Text', initial: 'Error message'),
            iconDataButton: context.knobs.options<DotsIconData>(
              label: 'Close Button Icon',
              initial: DotsIconData.cross,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            buttonVariant: context.knobs.options<DotsCloseButtonVariant>(
              label: 'Close Button Variant',
              initial: DotsCloseButtonVariant.inverted,
              options: DotsCloseButtonVariant.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList(),
            ),
            buttonSize: context.knobs.options<DotsCloseButtonSize>(
              label: 'Close Button Size',
              initial: DotsCloseButtonSize.extraSmall,
              options: DotsCloseButtonSize.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList(),
            ),
            background: context.knobs.boolean(label: 'Background?', initial: true),
            endButtonText: context.knobs.nullable.text(label: 'End Button Text', initial: 'Submit'),
            suffixIcon: context.knobs.nullable.options<DotsIconData>(
              label: 'Suffix Icon',
              initial: DotsIconData.checkCircle,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            suffixIconColor: basicColorSelector(context, 'Suffix Icon Color'),
          ),
        ),
      ),
      Story(
        name: 'TextFields/TextFieldDate',
        description: 'Demo page for date and time picker',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotsTextFieldDate(
            iconData: context.knobs.nullable.options<DotsIconData>(
              label: 'Icon',
              initial: DotsIconData.calendar,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            label: context.knobs.nullable.text(label: 'Label', initial: 'Label'),
            date: "12 ENE 2026",
            time: "18:00",
            onTap: () {},
            isError: context.knobs.boolean(label: 'Is Error?', initial: false),
            errorText: context.knobs.nullable.text(label: 'Error Text', initial: 'Error message'),
            background: context.knobs.boolean(label: 'Background?', initial: true),
          ),
        ),
      ),
      Story(
        name: 'TextFields/TextArea',
        description: 'Demo page for TextArea',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotsTextArea(
            controller: TextEditingController(),
            focusNode: FocusNode(),
            iconData: context.knobs.nullable.options<DotsIconData>(
              label: 'Icon',
              initial: DotsIconData.text,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            label: context.knobs.text(label: 'Label', initial: 'Label'),
            hintText: context.knobs.text(label: 'Hint Text', initial: 'Enter a description'),
            maxTextLength: 80,
            // minHeight: 100,
            // maxHeight: 300,
            isError: context.knobs.boolean(label: 'Is Error?', initial: false),
            errorText: context.knobs.nullable.text(label: 'Error Text', initial: 'Error message'),
          ),
        ),
      ),
    ];

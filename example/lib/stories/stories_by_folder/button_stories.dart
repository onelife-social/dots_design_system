import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get buttonStories => [
      Story(
        name: 'Buttons/Main button',
        description: 'Demo page for button',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotsMainButton(
            content: context.knobs.text(label: 'Content', initial: 'Button text'),
            details: context.knobs.nullable.text(label: 'Details', initial: 'Details'),
            enabled: context.knobs.boolean(label: 'Enabled', initial: true),
            icon: context.knobs.nullable.options<DotsIconData>(
                label: 'Icon',
                initial: DotsIconData.trash,
                options: DotsIconData.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList()),
            size: context.knobs.options<DotsMainButtonSize>(
                label: 'Size',
                initial: DotsMainButtonSize.large,
                options: DotsMainButtonSize.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList()),
            variant: context.knobs.options<DotsMainButtonVariant>(
                label: 'Variant',
                initial: DotsMainButtonVariant.main,
                options: DotsMainButtonVariant.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList()),
            onTap: () {},
            expand: context.knobs.boolean(label: 'Expand', initial: true),
          ),
        ),
      ),
      Story(
        name: 'Buttons/Icon button',
        description: 'Demo page for icon button',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: DotsIconButton(
              icon: context.knobs.options<DotsIconData>(
                  label: 'Icon',
                  initial: DotsIconData.trash,
                  options: DotsIconData.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList()),
              label:
                  context.knobs.nullable.text(label: 'Label', initial: 'Details', enabled: false),
              size: context.knobs.options<DotsIconButtonSize>(
                  label: 'Size',
                  initial: DotsIconButtonSize.large,
                  options: DotsIconButtonSize.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList()),
              variant: context.knobs.options<DotsIconButtonVariant>(
                  label: 'Variant',
                  initial: DotsIconButtonVariant.solid,
                  options: DotsIconButtonVariant.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList()),
              tag: context.knobs.nullable.text(label: 'Tag', initial: '5', enabled: false),
              onTap: () {},
            ),
          ),
        ),
      ),
      Story(
        name: 'Buttons/Floating button',
        description: 'Demo page for floating button',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: DotsFloatingButton(
              content: context.knobs.text(label: 'Content', initial: 'Buscar'),
              icon: context.knobs.nullable.options<DotsIconData>(
                  label: 'Icon',
                  initial: DotsIconData.search,
                  options: DotsIconData.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList()),
              blur: context.knobs.boolean(label: 'Blur', initial: true),
              onTap: () {},
            ),
          ),
        ),
      ),
    ];

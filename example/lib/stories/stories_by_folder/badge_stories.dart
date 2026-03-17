import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../helpers/color_knob_options.dart';

List<Story> get badgeStories => [
      Story(
        name: 'Badges/Badge tag',
        description: 'Demo page for badge tag',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: BadgeTag(
            tag: context.knobs.text(label: 'Badge tag text', initial: '1'),
            size: context.knobs.options<Size>(
              label: 'Distance from top right corner',
              initial: const Size(-5.0, -5.0),
              options: [
                Option(label: 'Default', value: const Size(-5.0, -5.0)),
                Option(label: 'Small', value: const Size(2.0, 2.0)),
                Option(label: 'Medium', value: const Size(10.0, 10.0)),
                Option(label: 'Large', value: const Size(20.0, 20.0)),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.black, width: 1.5, style: BorderStyle.solid),
              ),
              width: 30.0,
              height: 30.0,
            ),
          ),
        ),
      ),
      Story(
        name: 'Badges/Badge label',
        description: 'Demo page for badge label',
        builder: (context) => BadgeLabel(
          content: context.knobs.text(label: 'Content', initial: 'Badge label text'),
          size: context.knobs.options<BadgeLabelSize>(
              label: 'Size',
              initial: BadgeLabelSize.medium,
              options: BadgeLabelSize.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList()),
          variant: context.knobs.options<BadgeLabelVariant>(
              label: 'Variant',
              initial: BadgeLabelVariant.main,
              options: BadgeLabelVariant.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList()),
          badgeIcon: context.knobs.options<DotsIconData?>(
            label: 'Badge Icon',
            initial: null,
            options: [
              const Option(label: 'None', value: null),
              ...DotsIconData.values.map((item) => Option(label: item.name, value: item)),
            ],
          ),
        ),
      ),
      Story(
        name: 'Badges/BadgeProgress',
        description: 'Demo page for BadgeProgress',
        builder: (context) => BadgeProgress(
          current: context.knobs.slider(label: 'Min', initial: 0, min: 0, max: 500).toInt(),
          max: context.knobs.slider(label: 'Max', initial: 100, min: 0, max: 500).toInt(),
        ),
      ),
      Story(
        name: 'Badges/Badge milestone',
        description: 'Demo page for badge milestone',
        builder: (context) => BadgeMilestone(
          content: context.knobs.text(label: 'Content', initial: 'Label'),
          variant: context.knobs.options<BadgeMilestoneVariant>(
              label: 'Variant',
              initial: BadgeMilestoneVariant.main,
              options: BadgeMilestoneVariant.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList()),
        ),
      ),
      Story(
        name: 'Badges/Badge icon',
        description: 'Circular badge with a single icon. Size Large = 44px, Style White.',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              BadgeIcon(
                icon: context.knobs.options<DotsIconData>(
                  label: 'Icon',
                  initial: DotsIconData.video,
                  options: DotsIconData.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList(),
                ),
                size: context.knobs.options<BadgeIconSize>(
                  label: 'Size',
                  initial: BadgeIconSize.large,
                  options: BadgeIconSize.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList(),
                ),
                style: context.knobs.options<BadgeIconStyle>(
                  label: 'Style',
                  initial: BadgeIconStyle.white,
                  options: BadgeIconStyle.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList(),
                ),
                iconColor: knobColorSelector(context, 'Icon color'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('onTap'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      Story(
        name: 'Badges/Badge icon group',
        description: 'Group of 1 to 3 badge icons following the Figma layout.',
        builder: (context) {
          final iconCount = context.knobs.options<int>(
            label: 'Icon count',
            initial: 3,
            options: const [
              Option(label: '1', value: 1),
              Option(label: '2', value: 2),
              Option(label: '3', value: 3),
            ],
          );

          final icon1 = context.knobs.options<DotsIconData>(
            label: 'Icon 1',
            initial: DotsIconData.video,
            options:
                DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
          );
          final icon2 = context.knobs.options<DotsIconData>(
            label: 'Icon 2',
            initial: DotsIconData.pages,
            options:
                DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
          );
          final icon3 = context.knobs.options<DotsIconData>(
            label: 'Icon 3',
            initial: DotsIconData.mic,
            options:
                DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
          );

          final icons = <DotsIconData>[icon1, icon2, icon3].take(iconCount).toList();
          final iconColors = List.generate(
              iconCount, (index) => knobColorSelector(context, 'Icon ${index + 1} color'));

          return Center(
            child: BadgeIconGroup(
              icons: icons,
              iconColors: iconColors,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('onTap')),
                );
              },
            ),
          );
        },
      ),
    ];

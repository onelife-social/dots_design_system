import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

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
          badgeIcon:  context.knobs.options<DotsIconData?>(
            label: 'Badge Icon',
            initial: null,
            options: [
              const Option(label: 'None', value: null),
              ...DotsIconData.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList(),
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
    ];

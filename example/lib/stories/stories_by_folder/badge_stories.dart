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
            child: Container(
              color: Colors.white,
              width: context.knobs.slider(
                label: 'Width',
                initial: 200,
                min: 100,
                max: 400,
              ),
              height: context.knobs.slider(
                label: 'Height',
                initial: 100,
                min: 50,
                max: 200,
              ),
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
        ),
      ),
    ];

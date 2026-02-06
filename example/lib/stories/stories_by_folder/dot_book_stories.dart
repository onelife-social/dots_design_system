import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get dotBookStories => [
      Story(
        name: 'DotBook Components/page control',
        description: 'Demo page for Page control',
        builder: (context) => ColoredBox(
          color: context.dotsTheme.colors.bgContainerSecondary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: PageControl(
              count: context.knobs.sliderInt(
                label: 'Dot count',
                initial: 5,
                max: 10,
                min: 0,
              ),
              activeIndex: context.knobs.sliderInt(
                label: 'Active dot index',
                initial: 0,
                max: 9,
                min: 0,
              ),
            ),
          ),
        ),
      ),
      Story(
        name: 'DotBook Components/image placeholder',
        description: 'Demo page for Image placeholder',
        builder: (context) => ColoredBox(
          color: context.dotsTheme.colors.bgContainerSecondary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DotBookImagePlaceholder(
              imageProvider: const NetworkImage('https://picsum.photos/250?image=3'),
              sizeText: context.knobs.text(label: 'Badge text', initial: '19 x 25 cm'),
              onBackPressed: context.knobs.boolean(
                        label: 'Show back button',
                        initial: true,
                      )
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('On tap!')),
                      );
                    }
                  : null,
            ),
          ),
        ),
      ),
    ];

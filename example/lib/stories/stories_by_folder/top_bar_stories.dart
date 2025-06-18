import 'package:dots_design_system/dots_design_system.dart';
import 'package:example/components/home_top_bar_demo.dart';
import 'package:example/components/top_bar_demo.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get topBarStories => [
      Story(
        name: 'Top bar',
        description: 'Demo page for Top bar',
        builder: (context) => ColoredBox(
          color: context.dotsTheme.colors.bgContainerSecondary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TopBarDemo(
              variant: context.knobs.options<TobBarVariant>(
                label: 'Variant',
                initial: TobBarVariant.title,
                options: TobBarVariant.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList(),
              ),
              title: context.knobs.text(label: 'Title', initial: 'Title'),
              subtitle: context.knobs.nullable.text(label: 'Subtitle', initial: 'Subtitle'),
              showLeftIcon: context.knobs.boolean(label: 'Show left icon', initial: false),
              showRightIcon: context.knobs.boolean(label: 'Show right icon', initial: false),
              showBackButton: context.knobs.boolean(label: 'Show back button', initial: false),
              ctaLabel: context.knobs.nullable.text(label: 'CTA title', initial: 'Call to Action'),
              ctaEnabled: context.knobs.boolean(label: 'CTA enabled', initial: true),
            ),
          ),
        ),
      ),
      Story(
        name: 'Home Top bar',
        description: 'Demo page for Home Top bar',
        builder: (context) => ColoredBox(
          color: Color.fromARGB(0, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: HomeTopBarDemo(
              variant: context.knobs.options<HomeTopBarVariant>(
                label: 'Variant',
                initial: HomeTopBarVariant.icons,
                options: HomeTopBarVariant.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList(),
              ),
              title: context.knobs.text(label: 'Title', initial: 'Dots.Memories'),
              showTag: context.knobs.boolean(label: 'Show tag', initial: false),
              showImageUrl: context.knobs.boolean(label: 'Show image', initial: false),
              imageUrl: context.knobs
                  .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9'),
            ),
          ),
        ),
      ),
    ];

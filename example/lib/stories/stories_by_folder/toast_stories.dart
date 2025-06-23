import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get toastStories => [
      Story(
          name: 'Toast/Action',
          description: 'Demo page for Toast action',
          builder: (context) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: DotsToastAction(
                  title: context.knobs.text(label: 'Title', initial: 'Title'),
                  variant: context.knobs.options<DotsToastVariant>(
                    label: 'Variant',
                    initial: DotsToastVariant.success,
                    options: DotsToastVariant.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList(),
                  ),
                ),
              )),
      Story(
          name: 'Toast/Info',
          description: 'Demo page for Toast information',
          builder: (context) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: DotsToastInfo(
                  title: context.knobs.text(label: 'Title', initial: 'Title'),
                  variant: context.knobs.options<DotsToastVariant>(
                    label: 'Variant',
                    initial: DotsToastVariant.success,
                    options: DotsToastVariant.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList(),
                  ),
                ),
              )),
    ];

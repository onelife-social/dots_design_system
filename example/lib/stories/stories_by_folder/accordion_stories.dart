import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get accordionStories => [
      Story(
        name: 'Dots Accordion',
        description: 'Dots design accordion demo',
        builder: (context) {
          final singleOpen = context.knobs.boolean(label: 'Single Open', initial: true);
          final sections = [
            DotsAccordionSection(
              title: 'First section',
              leadingIcon: DotsIconData.list,
              expanded: false,
              content: Text(
                'Content of the first section. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                style: context.dotsTheme.typo.main.bodyDefaultMedium,
              ),
            ),
            DotsAccordionSection(
              title: 'Second section',
              leadingIcon: DotsIconData.info,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'You can place any widget here:',
                    style: context.dotsTheme.typo.main.bodyDefaultMedium,
                  ),
                  const SizedBox(height: 8),
                  DotsMainButton(
                    content: 'Action',
                    onTap: () {},
                    size: DotsMainButtonSize.small,
                    variant: DotsMainButtonVariant.main,
                  ),
                ],
              ),
            ),
            DotsAccordionSection(
              title: 'Third section with a very long title that should be truncated',
              leadingIcon: DotsIconData.helpCircle,
              content: Text(
                'More accordion content.',
                style: context.dotsTheme.typo.main.bodyDefaultMedium,
              ),
            ),
          ];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: DotsAccordion(
              sections: sections,
              singleOpen: singleOpen,
            ),
          );
        },
      ),
    ];

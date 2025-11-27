import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get planningStories => [
  Story(
    name: 'Planning/Planning Item',
    description: 'Demo page for DotsPlanningItem',
    builder: (context) {
      final screenHeight = MediaQuery.of(context).size.height;
      return Center(
        child: Container(
          height: screenHeight * 0.3,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: DotsPlanningItem(
            sectionImage: NetworkImage(
              context.knobs.text(
                label: 'Image URL',
                initial: 'https://picsum.photos/250?image=9',
              ),
            ),
            mainIcon: DotsIconData.chevronDown,
            mainIconActive: DotsIconData.chevronUp,
            mainText: context.knobs.text(label: 'Main Text', initial: 'Título principal'),
            dateTimeIcon: DotsIconData.clockOutline,
            dateTimeText: context.knobs.text(label: 'Start time', initial: '18:00'),
            durationIcon: DotsIconData.clockTimer,
            durationText: context.knobs.text(label: 'Duration', initial: '2h of duration'),
            ubicationIcon: DotsIconData.locationPin,
            ubicationText: context.knobs.text(label: 'Location', initial: 'Madrid, Spain'),
            descriptionIcon: DotsIconData.text,
            descriptionText: context.knobs.text(label: 'Description', initial: 'La entrada al local está en la calle Juan de Austria. '),
          ),
        ),
      );
    },
  ),
];
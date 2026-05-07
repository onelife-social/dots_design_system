import 'package:dots_design_system/dots_design_system.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get iconStories => [
      Story(
        name: 'Icons/Icon Item',
        description: 'Demo page for Icon Item',
        builder: (context) {
          return DotsIconItem(
            type: context.knobs.options(
              label: 'Icon Type',
              initial: DotsIconItemSlotType.cover,
              options: const [
                Option(label: 'Cover', value: DotsIconItemSlotType.cover),
                Option(label: 'Dedicatory', value: DotsIconItemSlotType.dedicatory),
                Option(label: 'Images', value: DotsIconItemSlotType.images),
                Option(label: 'Milestone', value: DotsIconItemSlotType.milestone),
              ],
            ),
            label: context.knobs.text(label: 'Label', initial: 'Icon Label'),
          );
        },
      ),
    ];

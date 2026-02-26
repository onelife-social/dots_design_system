import 'package:dots_design_system/dots_design_system.dart';
import 'package:example/components/radio_card_icons_demo_page.dart';
import 'package:example/components/radio_card_label_demo_page.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get miscellaneousStories => [
      Story(
        name: 'Miscellaneous/Radio Card Label',
        description: 'Demo page for Radio Card Label',
        builder: (context) => RadioCardLabelDemoScreen(
          variant: context.knobs.options(
            label: 'Variant',
            initial: RadioCardLabelVariant.small,
            options: const [
              Option(label: 'Small', value: RadioCardLabelVariant.small),
              Option(label: 'Medium', value: RadioCardLabelVariant.medium),
            ],
          ),
          value: context.knobs.text(label: 'Value'),
        ),
      ),
      Story(
        name: 'Miscellaneous/Radio Card Icons',
        description: 'Demo page for Radio Card Icons',
        builder: (context) => RadioCardIconsDemoScreen(),
      ),
    ];

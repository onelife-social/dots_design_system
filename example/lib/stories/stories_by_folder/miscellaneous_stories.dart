import 'package:example/components/radio_card_label_demo_page.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get miscellaneousStories => [
      Story(
        name: 'Miscellaneous/Radio Card Label',
        description: 'Demo page for Radio Card Label',
        builder: (context) => RadioCardLabelDemoScreen(),
      ),
    ];

import 'package:example/components/spinner_round_demo_page.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get spinnerStories => [
      Story(
        name: 'Spinner/SpinnerRound',
        description: 'Demo for SpinnerRound',
        builder: (context) => const SpinnerRoundDemoPage(),
      ),
    ];

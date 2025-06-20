import 'package:example/components/dots_decorated_box_demo.dart';
import 'package:example/components/dots_style_text_demo.dart';
import 'package:example/components/icons_demo_page.dart';
import 'package:example/theme/colors_demo_page.dart';
import 'package:example/theme/typography_demo_page.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get themeStories => [
      Story(
        name: 'Theme/Typo',
        description: 'Demo page for all typography',
        builder: (context) => TypographyDemoPage(),
      ),
      Story(
        name: 'Theme/Styles/Decorated box',
        description: 'Demo page for styles with decoratedBox',
        builder: (context) => DotsDecoratedBoxDemoScreen(
            showSquircleClip: context.knobs.boolean(
              label: 'showSquircleClip',
            ),
            radius: context.knobs.slider(
              label: 'Radius',
              initial: 16,
              max: 100,
              min: 0,
            )),
      ),
      Story(
        name: 'Theme/Styles/Text style',
        description: 'Demo page for Styles for text',
        builder: (context) => DotsStyleTextDemo(),
      ),
      Story(
        name: 'Theme/Colors',
        description: 'Demo page for all colors',
        builder: (context) => ColorsDemoPage(),
      ),
      Story(
        name: 'Theme/Icons',
        description: 'Demo page for icons',
        builder: (context) => IconsDemoPage(
          color:
              Color(context.knobs.sliderInt(label: 'Color', max: 4294967295, initial: 4080218930)),
          size: context.knobs.slider(label: 'Size', max: 100, initial: 100),
        ),
      ),
    ];

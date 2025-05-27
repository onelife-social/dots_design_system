import 'package:example/theme/colors_demo_page.dart';
import 'package:example/theme/typography_demo_page.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:dots_design_system/dots_design_system.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => Storybook(
        wrapperBuilder: (BuildContext _, Widget? child) => MaterialApp(
          theme: dotsThemeDataLight,
          darkTheme: dotsThemeDataDark,
          home: Builder(builder: (context) {
            return Scaffold(
                backgroundColor: context.dotsTheme.colors.bgBase, body: Center(child: child));
          }),
        ),
        stories: [
          Story(
            name: 'Theme/Typo',
            description: 'Demo page for all typography',
            builder: (context) => TypographyDemoPage(),
          ),
          Story(
            name: 'Theme/colors',
            description: 'Demo page for all colors',
            builder: (context) => ColorsDemoPage(),
          ),
          Story(
            name: 'button',
            description: 'Demo page for button',
            builder: (context) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: DotsButton(
                content: context.knobs.text(label: 'Content', initial: 'Button text'),
                details: context.knobs.nullable.text(label: 'Details', initial: 'Details'),
                enabled: context.knobs.boolean(label: 'Enabled', initial: true),
                size: context.knobs.options<DotsButtonSize>(
                    label: 'Size',
                    initial: DotsButtonSize.large,
                    options: DotsButtonSize.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList()),
                variant: context.knobs.options<DotsButtonVariant>(
                    label: 'Variant',
                    initial: DotsButtonVariant.main,
                    options: DotsButtonVariant.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList()),
                onTap: () {},
              ),
            ),
          ),
        ],
      );
}

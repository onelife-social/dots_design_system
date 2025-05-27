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
          themeMode: ThemeMode.light,
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
              child: DotsMainButton(
                content: context.knobs.text(label: 'Content', initial: 'Button text'),
                details: context.knobs.nullable.text(label: 'Details', initial: 'Details'),
                enabled: context.knobs.boolean(label: 'Enabled', initial: true),
                size: context.knobs.options<DotsMainButtonSize>(
                    label: 'Size',
                    initial: DotsMainButtonSize.large,
                    options: DotsMainButtonSize.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList()),
                variant: context.knobs.options<DotsMainButtonVariant>(
                    label: 'Variant',
                    initial: DotsMainButtonVariant.main,
                    options: DotsMainButtonVariant.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList()),
                onTap: () {},
              ),
            ),
          ),
          Story(
            name: 'Progress Bar',
            builder: (context) => DotsProgressBar(
              percentage: context.knobs.slider(
                label: 'Percentage',
                initial: 0.5,
                min: 0,
                max: 1,
              ),
              parts: context.knobs
                  .slider(
                    label: 'Parts',
                    initial: 2,
                    min: 1,
                    max: 3,
                  )
                  .toInt(),
              width: context.knobs.slider(
                label: 'Width',
                initial: 110,
                min: 50,
                max: 300,
              ),
            ),
          ),
          Story(
            name: 'Action Sheet',
            description: 'Demo page for action sheet',
            builder: (context) => DotsActionSheet(
              title: context.knobs.text(label: 'title', initial: 'Title'),
              description: context.knobs.text(label: 'description', initial: 'Description'),
              primaryButtonText:
                  context.knobs.text(label: 'primaryButtonText', initial: 'Button text'),
              secondaryButtonText: context.knobs.nullable.text(
                label: 'secondaryButtonText',
                initial: 'Secondary button text',
              ),
              topWidget: Container(
                height: context.knobs.slider(
                  label: 'Top widget height',
                  initial: 100,
                  min: 0,
                  max: 500,
                ),
                color: context.dotsTheme.colors.bgContainerTertiary,
              ),
              onClose: () {},
              bottomWidget: Container(
                height: context.knobs.slider(
                  label: 'Bottom widget height',
                  initial: 100,
                  min: 0,
                  max: 800,
                ),
                color: context.dotsTheme.colors.bgContainerTertiary,
              ),
              stepProgress: context.knobs.slider(
                label: 'Step progress',
                initial: 0.5,
                min: 0,
                max: 1,
              ),
              bigAspectRatio: context.knobs.boolean(
                label: 'Big aspect ratio',
                initial: true,
              ),
              scrollController: ScrollController(),
            ),
          ),
        ],
      );
}

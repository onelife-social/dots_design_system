import 'package:dots_design_system/dots_design_system.dart';
import 'package:example/theme/colors_demo_page.dart';
import 'package:example/theme/typography_demo_page.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

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
            name: 'container',
            description: 'Demo page for container',
            builder: (context) {
              final showBgImage = context.knobs.boolean(
                label: 'Show background image?',
                initial: false,
              );
              return DotsMainContainer(
                variant: context.knobs.options<DotsMainContainerVariant>(
                  label: 'Variant',
                  initial: DotsMainContainerVariant.main,
                  options: DotsMainContainerVariant.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList(),
                ),
                width:
                    context.knobs.nullable.slider(label: 'Width', initial: 300, min: 50, max: 500),
                height:
                    context.knobs.nullable.slider(label: 'Height', initial: 200, min: 50, max: 400),
                backgroundImage: showBgImage
                    ? DecorationImage(
                        image: NetworkImage(
                          context.knobs.text(
                            label: 'Background image',
                            initial: 'https://picsum.photos/250?image=9',
                          ),
                        ),
                        fit: BoxFit.cover,
                      )
                    : null,
              );
            },
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
        ],
      );
}

import 'package:dots_design_system/dots_design_system.dart';
import 'package:example/components/icons_demo_page.dart';
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
                icon: context.knobs.nullable.options<DotsIconData>(
                    label: 'Icon',
                    initial: DotsIconData.trash,
                    options: DotsIconData.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList()),
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
            name: 'icons',
            description: 'Demo page for icons',
            builder: (context) => IconsDemoPage(
              color: Color(
                  context.knobs.sliderInt(label: 'Color', max: 4294967295, initial: 4080218930)),
              size: context.knobs.slider(label: 'Size', max: 100, initial: 100),
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
              primaryButton: DotsMainButton(
                content: context.knobs.text(label: 'Primary button text', initial: 'Primary'),
                details: context.knobs.nullable.text(
                  label: 'Primary button details',
                  initial: 'Details',
                ),
                enabled: context.knobs.boolean(label: 'Primary button enabled', initial: true),
                variant: DotsMainButtonVariant.main,
                size: DotsMainButtonSize.mainAction,
                onTap: () {},
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

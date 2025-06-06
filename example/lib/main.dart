import 'package:dots_design_system/dots_design_system.dart';
import 'package:example/stories/main_stories.dart';
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
            context.dotsTheme.typo;
            final imageUrl = context.knobs.nullable.text(
              label: 'Background image',
              initial: 'https://picsum.photos/250?image=9',
              enabled: false,
            );
            return Scaffold(
                backgroundColor: context.dotsTheme.colors.bgBase,
                body: Container(
                    decoration: BoxDecoration(
                        image: imageUrl != null
                            ? DecorationImage(
                                image: NetworkImage(
                                  imageUrl,
                                ),
                                fit: BoxFit.cover,
                              )
                            : null),
                    child: Center(child: child)));
          }),
        ),
        stories: allStories,
      );
}

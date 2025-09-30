import 'package:dots_design_system/dots_design_system.dart';
import 'package:example/stories/main_stories.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() async {
  try {
    await ShadersLoader.preloadAll();
  } catch (e) {
    print('Error preloading shaders: $e');
  }
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

            final lowQuality = ['https://picsum.photos/250?image=12'];

            final picsumImages = [
              'https://picsum.photos/id/0/5000/3333',
              'https://picsum.photos/id/1/5000/3333',
              'https://picsum.photos/id/2/5000/3333',
              'https://picsum.photos/id/3/5000/3333',
              'https://picsum.photos/id/4/5000/3333',
              'https://picsum.photos/id/5/5000/3334',
              'https://picsum.photos/id/6/5000/3333',
              'https://picsum.photos/id/7/4728/3168',
              'https://picsum.photos/id/8/5000/3333',
              'https://picsum.photos/id/9/5000/3269',
              'https://picsum.photos/id/10/2500/1667',
              'https://picsum.photos/id/11/2500/1667',
              'https://picsum.photos/id/12/2500/1667',
              'https://picsum.photos/id/13/2500/1667',
              'https://picsum.photos/id/14/2500/1667',
              'https://picsum.photos/id/15/2500/1667',
              'https://picsum.photos/id/16/2500/1667',
              'https://picsum.photos/id/17/2500/1667',
              'https://picsum.photos/id/18/2500/1667',
              'https://picsum.photos/id/19/2500/1667',
              'https://picsum.photos/id/20/3670/2462',
              'https://picsum.photos/id/21/3008/2008',
              'https://picsum.photos/id/22/4434/3729',
              'https://picsum.photos/id/23/3887/4899',
              'https://picsum.photos/id/24/4855/1803',
              'https://picsum.photos/id/25/5000/3333',
              'https://picsum.photos/id/26/4209/2769',
              'https://picsum.photos/id/27/3264/1836',
              'https://picsum.photos/id/28/4928/3264',
              'https://picsum.photos/id/29/4000/2670',
            ];

            final imageUrl = context.knobs.options<String?>(
              label: 'Custom background',
              options: [
                const Option(label: 'None', value: null),
                Option(label: 'Low Quality', value: lowQuality[0]),
                ...List.generate(
                  picsumImages.length,
                  (i) => Option(label: 'HD ${i + 1}', value: picsumImages[i]),
                ),
              ],
              initial: null,
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

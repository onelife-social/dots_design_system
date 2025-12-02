import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get photoStories => [
      Story(
        name: 'Photo components/Profile photo',
        description: 'Demo page for Profile photo',
        builder: (context) => ColoredBox(
          color: context.dotsTheme.colors.bgContainerSecondary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DotsProfilePhoto(
              imageProvider: NetworkImage(context.knobs
                  .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9')),
            ),
          ),
        ),
      ),
      Story(
        name: 'Photo components/ Profile photo with bite',
        description: 'Demo page for Profile photo with bite',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotsProfilePhotoBited(
            width: 44,
            height: 44,
            imageProvider: NetworkImage(context.knobs
               .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9')),
            reaction: context.knobs.nullable.text(
              label: 'Reaction',
              initial: '😋',
            ),
          ),
        ),
      ),
      Story(
        name: 'Photo components/ Squircle photo',
        description: 'Demo page for Squircle photo',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotsSquircleImage(
            image: NetworkImage(
              context.knobs.text(
                label: 'Image URL',
                initial: 'https://picsum.photos/250?image=9',
              ),
            ),
            defaultImagePath: ImagesPaths.defaultSectionPlanning,
            squircleStyle: context.dotsTheme.styles.squircle16,
            onError: (error, stackTrace) {
            },
            uploadError: context.knobs.boolean(
              label: 'Upload error',
              initial: true,
            ),
            uploadErrorIcon: context.knobs.options<DotsIconData>(
              label: 'Icon Data Upload Error',
              initial: DotsIconData.cloudFail,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            borderColor: context.dotsTheme.colors.bgBtnImage.withOpacity(0.6),
          ),
        ),
      ),
    ];

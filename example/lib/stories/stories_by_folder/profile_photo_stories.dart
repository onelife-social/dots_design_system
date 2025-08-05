import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get profilePhotoStories => [
      Story(
        name: 'Profile photo/Profile photo',
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
        name: 'Profile photo/ Profile photo with bite',
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
    ];

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get memoryUploadStories => [
      Story(
        name: 'Memory Upload/upload item state',
        description: 'Demo page for Memory upload item state',
        builder: (context) => ColoredBox(
          color: context.dotsTheme.colors.bgContainerSecondary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DotsUploadItem(
              image: NetworkImage(context.knobs
                  .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9')),
              defaultImagePath: ImagesPaths.defaultSectionPlanning,
              variant: context.knobs.options<UploadItemVariant>(
                label: 'Variant',
                initial: UploadItemVariant.processing,
                options: UploadItemVariant.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList(),
              ),
              onError: (error, stackTrace) {
              },
              textDate: context.knobs.text(
                label: 'Date text',
                initial: 'June 20, 2023',
              ),
              processText: context.knobs.text(
                label: 'Process text',
                initial: 'Uploading...',
              ),
              timeElapsed: context.knobs.text(
                label: 'Time elapsed text',
                initial: '2 min ago',
              ),
              percentage: context.knobs.slider(
                label: 'Upload percentage',
                initial: 0.5,
                max: 1,
                min: 0,
              ),
              btnText: context.knobs.text(
                label: 'Button text',
                initial: 'Retry',
              ),
              btnOnTap: () {
              },
            ),
          ),
        ),
      ),
     
    ];

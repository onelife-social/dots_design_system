
import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get memoryDetailsStories => [
  Story(
    name: 'Memory Details/ Memory Details Entry Viewer',
    description: 'Demo page for Memory Details Entry Viewer',
    builder: (context) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: DotsEntryViewer(
          variant: context.knobs.options(
            label: 'Variant',
            initial: DotsEntryViewerVariant.main,
            options: DotsEntryViewerVariant.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList(),
          ),
          userImage: NetworkImage(context.knobs
              .text(label: 'User Image URL', initial: 'https://picsum.photos/250?image=9')),
          userName: context.knobs.text(label: 'User Name', initial: 'John Doe'),
          isLiked: context.knobs.boolean(label: 'Is Liked', initial: false),
          emojiReaction: context.knobs.nullable.text(
            label: 'Emoji Reaction',
            initial: '😋',
          ),
          onError: (exception, stackTrace) {
          },
        ),
      ),
    ),
  ),
  Story(
    name: 'Memory Details/ Memory Details',
    description: 'Demo page for Memory Details',
    builder: (context) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: DotsMemoryDetails(
          image: NetworkImage(context.knobs
              .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=68')),
          onImageError: (exception, stackTrace) {
          },
          uploadBytext: context.knobs.text(label: 'Upload By Text', initial: 'Uploaded by Alice to'),
          groupName: context.knobs.text(label: 'Group Name', initial: 'Familia Martínez-Ramírez🧢 '),
          date: context.knobs.text(label: 'Date', initial: '23 julio 2023'),
          time: context.knobs.text(label: 'Time', initial: '12:00'),
        ),
      ),
    ),
  ),
];

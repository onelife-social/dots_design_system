import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_design_system/dots_design_system.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get chatStories => [
      Story(
        name: 'Chat/Chat Item',
        description: 'Demo page for Chat Item',
        builder: (context) {
          return MessagePreview(
            image: CachedNetworkImage(
              imageUrl: context.knobs
                  .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9'),
            ),
            album: context.knobs.text(label: 'Album', initial: 'Holidays'),
            senderName: context.knobs.text(label: 'Sender Name', initial: 'John Doe'),
            text: context.knobs.text(label: 'Message Text', initial: 'Hello, how are you?'),
            time: context.knobs.text(label: 'Time', initial: '11:11'),
            newMessages: context.knobs.sliderInt(
              label: 'New messages',
              initial: 19,
            ),
          );
        },
      ),
    ];

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get notificationsStories => [
      Story(
        name: 'Notifications/Activity Preview Item',
        description: 'Demo page for Activity Preview Item',
        builder: (context) => Container(
          width: 300,
          height: 1000,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActivityOverviewItem(
                  image: NetworkImage(
                    context.knobs.text(
                      label: 'Main Image',
                      initial: 'https://picsum.photos/250?image=9',
                    ),
                  ),
                  icon: DotsIcon(
                    iconData: context.knobs.options<DotsIconData>(
                      label: 'Icon',
                      initial: DotsIconData.emojiLove,
                      options: DotsIconData.values
                          .map((item) => Option(label: item.name, value: item))
                          .toList(),
                    ),
                    size: 48,
                  ),
                  count: int.parse(
                    context.knobs.text(
                      label: 'Count',
                      initial: '4321',
                    ),
                  ),
                  title: context.knobs.text(
                    label: 'Title',
                    initial: 'Views en Memories',
                  ),
                  reactionsCount: int.parse(
                    context.knobs.text(
                      label: 'Reactions Count',
                      initial: '20',
                    ),
                  ),
                  userImages: [
                    NetworkImage(context.knobs.text(
                        label: 'User Image 1',
                        initial: 'https://picsum.photos/250?image=24',
                      ),
                    ),
                    NetworkImage(context.knobs.text(
                        label: 'User Image 2',
                        initial: 'https://picsum.photos/250?image=66',
                      ),
                    )
                  ])
            ],
          ),
        ),
      ),
      Story(
        name: 'Notifications/Banner',
        description: 'Demo page for Notification Banner',
        builder: (context) => ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 358,
          ),
          child: NotificationBanner(
            title: context.knobs.text(
              label: 'Title',
              initial: 'Formato de notificación fija',
            ),
            body: context.knobs.text(
              label: 'Body',
              initial:
                  'Este texto sirve para que una notificación importante que se tiene que quedar fija.',
            ),
            actionButtonText: context.knobs.text(
              label: 'Action Button Text',
              initial: 'Botón acción',
            ),
            onActionTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Action button tapped!'),
                ),
              );
            },
            onClose: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Close button tapped!'),
                ),
              );
            },
          ),
        ),
      ),
      Story(
        name: 'Notifications/Activity Preview Grid',
        description: 'Demo grid for Activity Preview',
        builder: (context) {
          final screenHeight = MediaQuery.of(context).size.height;
          final cellHeight = screenHeight * 0.256;

          return Padding(
            padding: const EdgeInsets.all(26),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: cellHeight,
                    child: ActivityPreview(
                      variant: context.knobs.options<ActivityPreviewVariant>(
                        label: 'Variant 1',
                        initial: ActivityPreviewVariant.reactions,
                        options: ActivityPreviewVariant.values
                            .map((item) => Option(label: item.name, value: item))
                            .toList(),
                      ),
                      image: NetworkImage(
                        context.knobs.text(
                          label: 'Image 1',
                          initial: 'https://picsum.photos/250?image=9',
                        ),
                      ),
                      reactions: [
                        context.knobs.options<String>(
                          label: 'Emoji 1-1',
                          initial: '😍',
                          options: [
                            Option(label: 'Enamorado', value: '😍'),
                            Option(label: 'Fuego', value: '🔥'),
                            Option(label: 'Risa', value: '😂'),
                            Option(label: 'Aplausos', value: '👏'),
                            Option(label: 'Corazón', value: '❤️'),
                            Option(label: 'Like', value: '👍'),
                          ],
                        ),
                        context.knobs.options<String>(
                          label: 'Emoji 1-2',
                          initial: '🔥',
                          options: [
                            Option(label: 'Enamorado', value: '😍'),
                            Option(label: 'Fuego', value: '🔥'),
                            Option(label: 'Risa', value: '😂'),
                            Option(label: 'Aplausos', value: '👏'),
                            Option(label: 'Corazón', value: '❤️'),
                            Option(label: 'Like', value: '👍'),
                          ],
                        ),
                        context.knobs.options<String>(
                          label: 'Emoji 1-3',
                          initial: '😂',
                          options: [
                            Option(label: 'Enamorado', value: '😍'),
                            Option(label: 'Fuego', value: '🔥'),
                            Option(label: 'Risa', value: '😂'),
                            Option(label: 'Aplausos', value: '👏'),
                            Option(label: 'Corazón', value: '❤️'),
                            Option(label: 'Like', value: '👍'),
                          ],
                        ),
                        context.knobs.options<String>(
                          label: 'Emoji 1-4',
                          initial: '👏',
                          options: [
                            Option(label: 'Enamorado', value: '😍'),
                            Option(label: 'Fuego', value: '🔥'),
                            Option(label: 'Risa', value: '😂'),
                            Option(label: 'Aplausos', value: '👏'),
                            Option(label: 'Corazón', value: '❤️'),
                            Option(label: 'Like', value: '👍'),
                          ],
                        ),
                      ],
                      number: context.knobs.text(
                        label: 'Number 1',
                        initial: '123',
                      ),
                    ),
                  ),
                  const SizedBox(width: 20), 
                  SizedBox(
                    height: cellHeight,
                    child: ActivityPreview(
                      variant: context.knobs.options<ActivityPreviewVariant>(
                        label: 'Variant 2',
                        initial: ActivityPreviewVariant.reactions,
                        options: ActivityPreviewVariant.values
                            .map((item) => Option(label: item.name, value: item))
                            .toList(),
                      ),
                      image: NetworkImage(
                        context.knobs.text(
                          label: 'Image 2',
                          initial: 'https://picsum.photos/250?image=10',
                        ),
                      ),
                      reactions: [
                        context.knobs.options<String>(
                          label: 'Emoji 2-1',
                          initial: '😂',
                          options: [
                            Option(label: 'Enamorado', value: '😍'),
                            Option(label: 'Fuego', value: '🔥'),
                            Option(label: 'Risa', value: '😂'),
                            Option(label: 'Aplausos', value: '👏'),
                            Option(label: 'Corazón', value: '❤️'),
                            Option(label: 'Like', value: '👍'),
                          ],
                        ),
                        context.knobs.options<String>(
                          label: 'Emoji 2-2',
                          initial: '👏',
                          options: [
                            Option(label: 'Enamorado', value: '😍'),
                            Option(label: 'Fuego', value: '🔥'),
                            Option(label: 'Risa', value: '😂'),
                            Option(label: 'Aplausos', value: '👏'),
                            Option(label: 'Corazón', value: '❤️'),
                            Option(label: 'Like', value: '👍'),
                          ],
                        ),
                      ],
                      number: context.knobs.text(
                        label: 'Number 2',
                        initial: '456',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ];

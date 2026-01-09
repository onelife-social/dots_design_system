import 'package:dots_design_system/dots_design_system.dart';
import 'package:example/stories/helpers/color_knob_options.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get notificationsStories => [
      Story(
        name: 'Notifications/ DotsNotificationItem',
        description: 'Demo page for DotsNotificationItem',
        builder: (context) {
          final variant = context.knobs.options<DotsNotificationItemVariant>(
            label: 'Variant',
            initial: DotsNotificationItemVariant.main,
            options: DotsNotificationItemVariant.values
                .map((item) => Option(label: item.name, value: item))
                .toList(),
          );
          return Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: context.screenWidth,
              height: context.screenHeight,
              alignment: Alignment.center,
              child: DotsNotificationItem(
                variant: variant,
                mainBtnText: context.knobs.text(label: 'Main Button Text', initial: 'Ver'),
                onMainBtnTap: () {},
                iconColor: basicColorSelector(context, 'Icon Color'),
                iconData: context.knobs.options<DotsIconData>(
                  label: 'Icon',
                  initial: DotsIconData.cake,
                  options: DotsIconData.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList(),
                ),
                profileImage: NetworkImage(
                  context.knobs.text(
                      label: 'Profile Image URL', initial: 'https://picsum.photos/250?image=15'),
                ),
                actionImage: NetworkImage(
                  context.knobs.text(
                      label: 'Action Image URL', initial: 'https://picsum.photos/250?image=9'),
                ),
                actionImageText: context.knobs.text(label: 'Action Image Text', initial: '+12'),
                title: context.knobs.text(label: 'Title', initial: '¡Recupera todas las fotos!'),
                description: context.knobs.text(
                    label: 'Description',
                    initial:
                        'Sigue estos sencillos pasos para recuperar todos los Memories en tu álbum. '),
                maxLines: int.tryParse(context.knobs.text(label: 'Max Lines', initial: '2')),
                date: context.knobs.text(label: 'Date', initial: '13:45'),
                onTap: () {},
              ),
            ),
          );
        },
      ),
      Story(
        name: 'Notifications/Activity Preview Item',
        description: 'Demo page for Activity Preview Item',
        builder: (context) {
          final imageCount = context.knobs.options<int>(
            label: 'Image Count',
            initial: 2,
            options: [
              Option(label: '1', value: 1),
              Option(label: '2', value: 2),
            ],
          );

          final images = List<ImageProvider>.generate(
            imageCount,
            (i) => NetworkImage(
              context.knobs.text(
                label: 'Image ${i + 1}',
                initial: 'https://picsum.photos/250?image=${9 + i * 15}',
              ),
            ),
          );

          return Container(
            width: 300,
            height: 1000,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActivityOverviewItem(
                  images: images,
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
                  variant: context.knobs.options<ActivityPreviewVariant>(
                    label: 'Variant',
                    initial: ActivityPreviewVariant.reactions,
                    options: ActivityPreviewVariant.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList(),
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
                    NetworkImage(
                      context.knobs.text(
                        label: 'User Image 1',
                        initial: 'https://picsum.photos/250?image=24',
                      ),
                    ),
                    NetworkImage(
                      context.knobs.text(
                        label: 'User Image 2',
                        initial: 'https://picsum.photos/250?image=66',
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
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
        name: 'Notifications/BannerImage',
        description: 'Demo page for Notification Banner Image',
        builder: (context) => ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 358,
          ),
          child: NotificationBannerImage(
            showCloseButton: context.knobs.boolean(
              label: 'Show Close Button',
              initial: true,
            ),
            imageProvider: NetworkImage(
              context.knobs.text(
                label: 'Image URL',
                initial: 'https://picsum.photos/400/200?image=1',
              ),
            ),
            imageSize: double.tryParse(
              context.knobs.text(
                label: 'Image Size',
                initial: '100',
              ),
            ),
            imagePadding: double.tryParse(
              context.knobs.text(
                label: 'Image Padding',
                initial: '20',
              ),
            )!,
            title: context.knobs.text(
              label: 'Title',
              initial: 'Formato de notificación fija',
            ),
            description: context.knobs.text(
              label: 'Description',
              initial:
                  'Este texto sirve para que una notificación importante que se tiene que quedar fija.',
            ),
            appendedDescription: context.knobs.text(
              label: 'Appended Description',
              initial: 'Ver ejemplo',
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
          final screenHeight = context.screenHeight;
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

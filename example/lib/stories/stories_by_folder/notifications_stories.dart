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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
      Story(
        name: 'Notifications/Alert',
        description: 'Demo page for Alert',
        builder: (context) {
          String textfieldContent = '';

          final selectorItemList = List.generate(
            3,
            (i) => DotsListItemModel(
              label: 'Section name ${i + 1}',
              image: NetworkImage('https://picsum.photos/250?image=9'),
              variant: DotsListsItemVariant.selector,
            ),
          );

          return StatefulBuilder(
            builder: (context, setState) {
              final variant = context.knobs.options<DotsAlertVariant>(
                label: 'Variant',
                initial: DotsAlertVariant.noButtons,
                options:
                    DotsAlertVariant.values.map((v) => Option(label: v.name, value: v)).toList(),
              );

              final iconData = context.knobs.options<DotsIconData>(
                label: 'Icon',
                initial: DotsIconData.alertCircle,
                options: DotsIconData.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList(),
              );

              final title = context.knobs.text(
                label: 'Title',
                initial: 'Título',
              );
              final message = context.knobs.text(
                label: 'Message',
                initial:
                    'Descripción debe ser relevante y tener relación con el flujo que interrumpe.',
              );

              final mainButtonText = context.knobs.text(
                label: 'Main Button Text',
                initial: 'Acción',
              );
              final secondaryButtonText = context.knobs.text(
                label: 'Secondary Button Text',
                initial: 'Cancelar',
              );

              final inputHint = context.knobs.text(
                label: 'Input Hint',
                initial: 'Input content',
              );
              final showCloseButton = context.knobs.boolean(
                label: 'Show close button',
                initial: true,
              );

              switch (variant) {
                case DotsAlertVariant.oneButton:
                  return DotsAlert.oneButton(
                    iconData: iconData,
                    title: title,
                    message: message,
                    mainButtonText: mainButtonText,
                    mainButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Main button tapped!')),
                      );
                    },
                    onClose: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Close button tapped!')),
                      );
                    },
                    showCloseButton: showCloseButton,
                  );

                case DotsAlertVariant.twoHorizontalButtons:
                  return DotsAlert.twoHorizontalButtons(
                    iconData: iconData,
                    title: title,
                    message: message,
                    mainButtonText: mainButtonText,
                    mainButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Main button tapped!')),
                      );
                    },
                    secondaryButtonText: secondaryButtonText,
                    secondaryButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Secondary button tapped!')),
                      );
                    },
                    onClose: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Close button tapped!')),
                      );
                    },
                    showCloseButton: showCloseButton,
                  );
                case DotsAlertVariant.twoHorizontalButtonsDestructive:
                  return DotsAlert.twoHorizontalButtonsDestructive(
                    iconData: iconData,
                    title: title,
                    message: message,
                    mainButtonText: mainButtonText,
                    mainButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Main button tapped!')),
                      );
                    },
                    secondaryButtonText: secondaryButtonText,
                    secondaryButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Secondary button tapped!')),
                      );
                    },
                    onClose: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Close button tapped!')),
                      );
                    },
                    showCloseButton: showCloseButton,
                  );

                case DotsAlertVariant.twoVerticalButtons:
                  return DotsAlert.twoVerticalButtons(
                    iconData: iconData,
                    title: title,
                    message: message,
                    mainButtonText: mainButtonText,
                    mainButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Main button tapped!')),
                      );
                    },
                    secondaryButtonText: secondaryButtonText,
                    secondaryButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Secondary button tapped!')),
                      );
                    },
                    onClose: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Close button tapped!')),
                      );
                    },
                    showCloseButton: showCloseButton,
                  );

                case DotsAlertVariant.input:
                  return DotsAlert.input(
                    iconData: iconData,
                    title: title,
                    onInputChanged: (value) => setState(() => textfieldContent = value),
                    inputHint: inputHint,
                    mainButtonText: mainButtonText,
                    mainButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Main button tapped! - Text: $textfieldContent')),
                      );
                    },
                    secondaryButtonText: secondaryButtonText,
                    secondaryButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Secondary button tapped!')),
                      );
                    },
                    onClose: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Close button tapped!')),
                      );
                    },
                    showCloseButton: showCloseButton,
                  );

                case DotsAlertVariant.selector:
                  return DotsAlert.selector(
                    iconData: iconData,
                    title: title,
                    message: message,
                    selectorItemList: [
                      for (int i = 0; i < selectorItemList.length; i++)
                        DotsListItemModel(
                          label: selectorItemList[i].label,
                          image: selectorItemList[i].image,
                          variant: selectorItemList[i].variant,
                          onTap: () {
                            setState(() {
                              selectorItemList[i] = DotsListItemModel(
                                label: selectorItemList[i].label,
                                image: selectorItemList[i].image,
                                variant:
                                    selectorItemList[i].variant == DotsListsItemVariant.radioButton
                                        ? DotsListsItemVariant.selector
                                        : DotsListsItemVariant.radioButton,
                              );
                            });
                          },
                        ),
                    ],
                    mainButtonText: mainButtonText,
                    mainButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Main button tapped! - Selected: ${selectorItemList.where((item) => item.variant == DotsListsItemVariant.radioButton).map((item) => item.label).join(', ')}',
                          ),
                        ),
                      );
                    },
                    secondaryButtonText: secondaryButtonText,
                    secondaryButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Secondary button tapped!')),
                      );
                    },
                    onClose: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Close button tapped!')),
                      );
                    },
                    showCloseButton: showCloseButton,
                  );

                case DotsAlertVariant.noButtons:
                  return DotsAlert.noButtons(
                    iconData: iconData,
                    title: title,
                    message: message,
                    onClose: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Close button tapped!')),
                      );
                    },
                    showCloseButton: showCloseButton,
                  );
              }
            },
          );
        },
      ),
    ];

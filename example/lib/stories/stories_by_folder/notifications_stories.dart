import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get notificationsStories => [
      Story(
        name: 'Notifications/Activity Overview Item',
        description: 'Demo page for Activity Overview Item',
        builder: (context) => Container(
          width: 300,
          height: 1000,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActivityOverviewItem(
                  imageUrl: 'https://picsum.photos/250?image=9',
                  icon: DotsIcon(
                    iconData: context.knobs.options<DotsIconData>(
                      label: 'Icon',
                      initial: DotsIconData.eye,
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
                  userImageUrls: [
                    'https://picsum.photos/250?image=1',
                    'https://picsum.photos/250?image=2'
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
    ];

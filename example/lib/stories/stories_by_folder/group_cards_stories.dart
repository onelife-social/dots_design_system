import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get groupCards => [
      Story(
        name: 'Cards/Album Group Cards',
        description: 'Demo page for album group cards',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: AlbumGroupCard(
            imageProvider: NetworkImage(
              context.knobs.text(
                label: 'Container background image',
                initial: 'https://picsum.photos/250?image=9',
              ),
            ),
            title: context.knobs.text(label: 'Group Name', initial: 'My Group'),
            variant: context.knobs.options<AlbumGroupCardVariant>(
              label: 'Variant',
              initial: AlbumGroupCardVariant.small,
              options: AlbumGroupCardVariant.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList(),
            ),
            tagIconData: context.knobs.nullable.options<DotsIconData>(
              label: 'Icon Data Tag',
              initial: DotsIconData.prime1,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            onTap: () {},
            onError: (exception, stackTrace) {},
          ),
        ),
      ),
      Story(
        name: 'Cards/Event Group Cards',
        description: 'Demo page for event group cards',
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: EventGroupCard(
                variant: context.knobs.options<EventGroupCardVariant>(
                  label: 'Variant',
                  initial: EventGroupCardVariant.small,
                  options: EventGroupCardVariant.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList(),
                ),
                imageProvider: NetworkImage(
                  context.knobs.text(
                    label: 'Container background image',
                    initial: 'https://picsum.photos/250?image=9',
                  ),
                ),
                title: context.knobs.text(label: 'Group Name', initial: 'My Group'),
                tagIconData: context.knobs.nullable.options<DotsIconData>(
                  label: 'Icon Data Tag',
                  initial: DotsIconData.prime1,
                  options: DotsIconData.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList(),
                ),
                onTap: () {},
                onError: (exception, stackTrace) {},
                actions: [
                  GroupEventCardModel(
                    text: 'Chat',
                    icon: DotsIconData.chat,
                    onTap: () {},
                  ),
                  GroupEventCardModel(
                    text: 'Subir',
                    icon: DotsIconData.camera,
                    onTap: () {},
                  ),
                  GroupEventCardModel(
                    text: 'Planning',
                    icon: DotsIconData.planner,
                    onTap: () {},
                  ),
                ],
                secondaryText: context.knobs.text(
                  label: 'Button Text',
                  initial: 'Reducir tamaño',
                ),
              ),
            ),
          );
        },
      ),
    ];

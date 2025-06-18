import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';


List<Story> get groupCards => [
      Story(
        name: 'Cards/Memories Group Cards',
        description: 'Demo page for memories group cards',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: MemoriesGroupCards(
            imageProvider: NetworkImage(
                      context.knobs.text(
                        label: 'Container background image',
                        initial: 'https://picsum.photos/250?image=9',
                      ),
                    ),
            groupName: context.knobs.text(label: 'Group Name', initial: 'My Group'),
            variant: context.knobs.options<AlbumGroupCardsVariant>(
              label: 'Variant',
              initial: AlbumGroupCardsVariant.small,
              options: AlbumGroupCardsVariant.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList(),
            ),
            isPrime: context.knobs.boolean(label: 'Is Prime', initial: false),
            iconDataTag: context.knobs.options<DotsIconData>(
              label: 'Icon Data Tag',
              initial: DotsIconData.prime1,
              options: DotsIconData.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList(),
            ),
            onTap: () {},
            onError: (exception, stackTrace) {
            },
          ),
        ),
      ),
      Story(
        name: 'Cards/Event Group Cards',
        description: 'Demo page for event group cards',
        builder: (context) {
          final variant = context.knobs.options<GroupEventCardsVariant>(
            label: 'Variant',
            initial: GroupEventCardsVariant.small,
            options: GroupEventCardsVariant.values
                .map((item) => Option(label: item.name, value: item))
                .toList(),
          );

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: variant == GroupEventCardsVariant.small
                  ? GroupEventCards.small(
                      imageProvider: NetworkImage(
                        context.knobs.text(
                          label: 'Container background image',
                          initial: 'https://picsum.photos/250?image=9',
                        ),
                      ),
                      groupName: context.knobs.text(label: 'Group Name', initial: 'My Group'),
                      isPrime: context.knobs.boolean(label: 'Is Prime', initial: false),
                      iconDataTag: context.knobs.options<DotsIconData>(
                        label: 'Icon Data Tag',
                        initial: DotsIconData.prime1,
                        options: DotsIconData.values
                            .map((item) => Option(label: item.name, value: item))
                            .toList(),
                      ),
                      onTap: () {},
                      onError: (exception, stackTrace) {},
                    )
                  : GroupEventCards.large(
                      variant: variant,
                      imageProvider: NetworkImage(
                        context.knobs.text(
                          label: 'Container background image',
                          initial: 'https://picsum.photos/250?image=9',
                        ),
                      ),
                      groupName: context.knobs.text(label: 'Group Name', initial: 'My Group'),
                      isPrime: context.knobs.boolean(label: 'Is Prime', initial: false),
                      iconDataTag: context.knobs.options<DotsIconData>(
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
                      activeText: context.knobs.text(
                        label: 'Active Event Text',
                        initial: 'Evento activo',
                      ),
                      btnText: context.knobs.text(
                        label: 'Button Text',
                        initial: 'Reducir tamaño',
                      ),
                    ),
            ),
          );
        },
      ),
    ];

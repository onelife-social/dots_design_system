import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';


List<Story> get albumCards => [
      Story(
        name: 'Cards/Memories Album Cards',
        description: 'Demo page for memories album cards',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: MemoriesAlbumCards(
            imageProvider: NetworkImage(
                      context.knobs.text(
                        label: 'Container background image',
                        initial: 'https://picsum.photos/250?image=9',
                      ),
                    ),
            albumName: context.knobs.text(label: 'Album Name', initial: 'My Album'),
            variant: context.knobs.options<MemoriesAlbumCardsVariant>(
              label: 'Variant',
              initial: MemoriesAlbumCardsVariant.small,
              options: MemoriesAlbumCardsVariant.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList(),
            ),
            isPrime: context.knobs.boolean(label: 'Is Prime', initial: false),
            onTap: () {},
            onError: (exception, stackTrace) {
            },
          ),
        ),
      ),
      Story(
        name: 'Cards/Event Album Cards',
        description: 'Demo page for event album cards',
        builder: (context) {
          final variant = context.knobs.options<EventAlbumCardsVariant>(
            label: 'Variant',
            initial: EventAlbumCardsVariant.small,
            options: EventAlbumCardsVariant.values
                .map((item) => Option(label: item.name, value: item))
                .toList(),
          );

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: variant == EventAlbumCardsVariant.small
                  ? EventAlbumCards.small(
                      imageProvider: NetworkImage(
                        context.knobs.text(
                          label: 'Container background image',
                          initial: 'https://picsum.photos/250?image=9',
                        ),
                      ),
                      albumName: context.knobs.text(label: 'Album Name', initial: 'My Album'),
                      isPrime: context.knobs.boolean(label: 'Is Prime', initial: false),
                      onTap: () {},
                      onError: (exception, stackTrace) {},
                    )
                  : EventAlbumCards.large(
                      variant: variant,
                      imageProvider: NetworkImage(
                        context.knobs.text(
                          label: 'Container background image',
                          initial: 'https://picsum.photos/250?image=9',
                        ),
                      ),
                      albumName: context.knobs.text(label: 'Album Name', initial: 'My Album'),
                      isPrime: context.knobs.boolean(label: 'Is Prime', initial: false),
                      onTap: () {},
                      onError: (exception, stackTrace) {},
                      actions: [
                        EventGroupCardModel(
                          text: 'Chat',
                          icon: DotsIconData.chat,
                          onTap: () {},
                        ),
                        EventGroupCardModel(
                          text: 'Subir',
                          icon: DotsIconData.camera,
                          onTap: () {},
                        ),
                        EventGroupCardModel(
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

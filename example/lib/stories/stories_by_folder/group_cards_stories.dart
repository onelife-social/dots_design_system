import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../components/album_group_card_demo_page.dart';

List<Story> get cards => [
      Story(
        name: 'Cards/Recap Card Locked',
        description: 'Recap Page locked',
        builder: (context) => RecapCardLocked(
          width: context.knobs.slider(label: 'Width', initial: 254, min: 254, max: 382),
          variant: context.knobs.options<RecapCardLockedVariant>(
            label: 'Variant',
            initial: RecapCardLockedVariant.countdown,
            options: RecapCardLockedVariant.values
                .map((item) => Option(label: item.name, value: item))
                .toList(),
          ),
          title: context.knobs.text(label: 'Title', initial: 'Recap Noviembre'),
          imageProvider: NetworkImage(context.knobs.text(
              label: 'Container background image', initial: 'https://picsum.photos/250?image=9')),
          defaultImage: NetworkImage('https://picsum.photos/250?image=9'),
          buttonText: context.knobs.text(label: 'Button Text', initial: 'Subir'),
          description: context.knobs.text(
              label: 'Description',
              initial: 'Para desbloquear este recap, necesitas subir 16 fotos y 4 vídeos.'),
          countdownDate: DateTime.now().add(
            Duration(
                days: context.knobs.sliderInt(label: 'Days', initial: 0, min: 0, max: 99),
                hours: context.knobs.sliderInt(label: 'Hours', initial: 0, min: 0, max: 23),
                minutes: context.knobs.sliderInt(label: 'Minutes', initial: 5, min: 0, max: 59),
                seconds: context.knobs.sliderInt(label: 'Seconds', initial: 0, min: 0, max: 59)),
          ),
          daysLabel: context.knobs.text(label: 'Days Label', initial: 'días'),
          hoursLabel: context.knobs.text(label: 'Hours Label', initial: 'horas'),
          minutesLabel: context.knobs.text(label: 'Minutes Label', initial: 'min.'),
          secondsLabel: context.knobs.text(label: 'Seconds Label', initial: 'seg.'),
          onButtonTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('onButtonTap'),
              ),
            );
          },
        ),
      ),
      Story(
        name: 'Cards/Recap Card Active',
        description: 'Recap in block 1 - state active',
        builder: (context) => RecapCard.active(
          width: context.knobs.slider(label: 'Width', initial: 254, min: 254, max: 382),
          buttonText: context.knobs.text(label: 'Button Text', initial: 'Ver Recap'),
          badgeText: context.knobs.text(label: 'Badge Text', initial: '¡Nuevo!'),
          title: context.knobs.text(label: 'Title', initial: 'Recap 15s'),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('onTap'),
              ),
            );
          },
          imageProvider: NetworkImage(
            context.knobs.text(
                label: 'Container background image', initial: 'https://picsum.photos/250?image=9'),
          ),
          textImageProvider: NetworkImage(
            context.knobs.text(label: 'Text image', initial: ''),
          ),
        ),
      ),
      Story(
        name: 'Cards/Recap Card Blocked',
        description: 'Recap in block 1 - state blocked',
        builder: (context) => RecapCard.blocked(
          width: context.knobs.slider(label: 'Width', initial: 254, min: 254, max: 382),
          buttonText: context.knobs.text(label: 'Button Text', initial: 'Subir 50 memories'),
          title: context.knobs.text(label: 'Title', initial: 'Recap 15s'),
          onInfoTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('onInfoTap'),
              ),
            );
          },
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('onTap'),
              ),
            );
          },
          imageProvider: NetworkImage(
            context.knobs.text(
                label: 'Container background image', initial: 'https://picsum.photos/250?image=9'),
          ),
          textImageProvider: NetworkImage(
            context.knobs.text(label: 'Text image', initial: ''),
          ),
        ),
      ),
      Story(
        name: 'Cards/Recap Card Generated',
        description: 'Recap in block 1 - state generated',
        builder: (context) => RecapCard.generated(
          width: context.knobs.slider(label: 'Width', initial: 254, min: 254, max: 382),
          albumName: context.knobs.text(label: 'Album Name', initial: 'Familia'),
          createdBy: context.knobs.text(label: 'Created By', initial: 'Creado por ti'),
          title: context.knobs.text(label: 'Title', initial: 'Recap 15s'),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('onTap'),
              ),
            );
          },
          onInfoTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('onInfoTap'),
              ),
            );
          },
          imageProvider: NetworkImage(
            context.knobs.text(
                label: 'Container background image', initial: 'https://picsum.photos/250?image=9'),
          ),
          textImageProvider: NetworkImage(
            context.knobs.text(label: 'Text image', initial: ''),
          ),
        ),
      ),
      Story(
        name: 'Cards/Album Group Cards',
        description: 'Demo page for album group cards',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: AlbumGroupCardDemoPage(
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
            blurSigma: context.knobs
                .sliderInt(label: 'Blur Sigma', initial: 20, min: 0, max: 200)
                .toDouble(),
            edgeSize: context.knobs
                .sliderInt(label: 'Edge Size', initial: 100, min: 0, max: 500)
                .toDouble(),
            isBlocked: context.knobs.boolean(label: 'Is Blocked', initial: false),
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
                isBlocked: context.knobs.boolean(label: 'Is Blocked', initial: false),
              ),
            ),
          );
        },
      ),
      Story(
        name: 'Cards/Prompt Card',
        description: 'Demo page for prompt cards',
        builder: (context) {
          final theme = context.dotsTheme;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: PromptCard(
                title: context.knobs.text(label: 'Title', initial: 'Su primer día en casa'),
                icon: context.knobs.options<DotsIconData>(
                  label: 'Icon',
                  initial: DotsIconData.house,
                  options: DotsIconData.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList(),
                ),
                primaryColor: context.knobs.options<Color>(
                  label: 'Primary Color',
                  initial: theme.colors.friends001,
                  options: [
                    Option(label: 'Orange (friends001)', value: theme.colors.friends001),
                    Option(label: 'Blue (child001)', value: theme.colors.child001),
                    Option(label: 'Green (family001)', value: theme.colors.family001),
                    Option(label: 'Pink (birthday007)', value: theme.colors.birthday007),
                    Option(label: 'Purple (hobby001)', value: theme.colors.hobby001),
                  ],
                ),
                secondaryColor: context.knobs.options<Color>(
                  label: 'Secondary Color',
                  initial: theme.colors.friends008,
                  options: [
                    Option(label: 'Orange (friends008)', value: theme.colors.friends008),
                    Option(label: 'Blue (child006)', value: theme.colors.child006),
                    Option(label: 'Green (family004)', value: theme.colors.family004),
                    Option(label: 'Pink (birthday003)', value: theme.colors.birthday003),
                    Option(label: 'Purple (hobby002)', value: theme.colors.hobby002),
                  ],
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Card tapped')),
                  );
                },
              ),
            ),
          );
        },
      ),
    ];

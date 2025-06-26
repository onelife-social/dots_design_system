import 'package:dots_design_system/dots_design_system.dart';
import 'package:example/components/carrousel_demo_page.dart';
import 'package:example/components/dots_menu_demo_page.dart';
import 'package:example/components/memory_card_demo_page.dart';
import 'package:example/components/segmented_control_handle.dart';
import 'package:example/components/empty_state_card_demo.dart';
import 'package:example/stories/stories_by_folder/button_stories.dart';
import 'package:example/stories/stories_by_folder/selector_radio_button_stories.dart';
import 'package:example/stories/stories_by_folder/theme_stories.dart';
import 'package:example/stories/stories_by_folder/toast_stories.dart';
import 'package:example/stories/stories_by_folder/top_bar_stories.dart';
import 'package:example/stories/stories_by_folder/group_cards_stories.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

List<Story> get allStories => [
      ...themeStories,
      ...buttonStories,
      ...topBarStories,
      ...groupCards,
      ...selectorRadioButtonStories,
      Story(
        name: 'Container',
        description: 'Demo page for container',
        builder: (context) {
          final showBgImage = context.knobs.boolean(
            label: 'Show container background image?',
            initial: false,
          );
          return DotsMainContainer(
            variant: context.knobs.options<DotsMainContainerVariant>(
              label: 'Variant',
              initial: DotsMainContainerVariant.main,
              options: DotsMainContainerVariant.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList(),
            ),
            width: context.knobs.nullable.slider(label: 'Width', initial: 300, min: 50, max: 500),
            height: context.knobs.nullable.slider(label: 'Height', initial: 200, min: 50, max: 400),
            forceHeight: context.knobs.boolean(
              label: 'Force height',
              initial: true,
            ),
            backgroundImage: showBgImage
                ? DecorationImage(
                    image: NetworkImage(
                      context.knobs.text(
                        label: 'Container background image',
                        initial: 'https://picsum.photos/250?image=9',
                      ),
                    ),
                    fit: BoxFit.cover,
                  )
                : null,
          );
        },
      ),
      Story(
        name: 'Progress Bar',
        builder: (context) => DotsProgressBar(
          percentage: context.knobs.slider(
            label: 'Percentage',
            initial: 0.5,
            min: 0,
            max: 1,
          ),
          parts: context.knobs
              .slider(
                label: 'Parts',
                initial: 2,
                min: 1,
                max: 3,
              )
              .toInt(),
          width: context.knobs.slider(
            label: 'Width',
            initial: 110,
            min: 50,
            max: 300,
          ),
        ),
      ),
      Story(
        name: 'Action Sheet',
        description: 'Demo page for action sheet',
        builder: (context) => DotsActionSheet(
          title: context.knobs.text(label: 'title', initial: 'Title'),
          description: context.knobs.text(label: 'description', initial: 'Description'),
          primaryButton: context.knobs.boolean(label: 'Show primary button', initial: true)
              ? DotsMainButton(
                  content: context.knobs.text(label: 'Primary button text', initial: 'Primary'),
                  details: context.knobs.nullable.text(
                    label: 'Primary button details',
                    initial: 'Details',
                  ),
                  enabled: context.knobs.boolean(label: 'Primary button enabled', initial: true),
                  variant: DotsMainButtonVariant.main,
                  size: DotsMainButtonSize.mainAction,
                  onTap: () {},
                )
              : null,
          secondaryButton: context.knobs.boolean(label: 'Show secondary button', initial: true)
              ? DotsMainButton(
                  content: context.knobs.text(label: 'Secondary button text', initial: 'Secondary'),
                  details: context.knobs.nullable.text(
                    label: 'Secondary button details',
                    initial: 'Details',
                  ),
                  enabled: context.knobs.boolean(label: 'Secondary button enabled', initial: true),
                  variant: DotsMainButtonVariant.secondary,
                  size: DotsMainButtonSize.mainAction,
                  onTap: () {},
                )
              : null,
          buttonPositioning: context.knobs.options<DotsActionSheetButtonPositioning>(
            label: 'Button positioning',
            initial: DotsActionSheetButtonPositioning.row,
            options: DotsActionSheetButtonPositioning.values
                .map((item) => Option(label: item.name, value: item))
                .toList(),
          ),
          topWidget: Container(
            height: context.knobs.slider(
              label: 'Top widget height',
              initial: 100,
              min: 0,
              max: 500,
            ),
            color: context.dotsTheme.colors.bgContainerTertiary,
          ),
          onClose: () {},
          bottomWidget: Container(
            height: context.knobs.slider(
              label: 'Bottom widget height',
              initial: 100,
              min: 0,
              max: 800,
            ),
            color: context.dotsTheme.colors.bgContainerTertiary,
          ),
          stepProgress: context.knobs.slider(
            label: 'Step progress',
            initial: 0.5,
            min: 0,
            max: 1,
          ),
          bigAspectRatio: context.knobs.boolean(
            label: 'Big aspect ratio',
            initial: true,
          ),
          scrollController: ScrollController(),
          backButtonShaderMask: context.knobs.boolean(
            label: 'Back button shader mask',
            initial: false,
          ),
        ),
      ),
      Story(
        name: 'Segmented control bar',
        description: 'Demo page for Segmented control bar',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: SegmentedControlHandle(
            key: ValueKey('SegmentedControlHandle'),
            leftOptionName: context.knobs.text(label: 'Option 1', initial: 'Option 1'),
            rightOptionName: context.knobs.text(label: 'Option 2', initial: 'Option 2'),
          ),
        ),
      ),
      Story(
        name: 'Profile photo',
        description: 'Demo page for Profile photo',
        builder: (context) => ColoredBox(
          color: context.dotsTheme.colors.bgContainerSecondary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DotsProfilePhoto(
              imageProvider: NetworkImage(context.knobs
                  .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9')),
            ),
          ),
        ),
      ),
      Story(
        name: 'Menu',
        description: 'Demo page for Menu',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotsMenuDemoPage(
            itemSelected: context.knobs.options<DotsMenuDemoPageItem>(
              label: 'Default Selection',
              initial: DotsMenuDemoPageItem.none,
              options: DotsMenuDemoPageItem.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList(),
            ),
          ),
        ),
      ),
      Story(
        name: 'Memory Card',
        description: 'Demo page for Memory Card',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: MemoryCardDemoPage(
            groupName: context.knobs.text(label: 'Boda', initial: 'Boda'),
            variant: context.knobs.options<MemoryCardVariant>(
              label: 'Variant',
              initial: MemoryCardVariant.update,
              options: MemoryCardVariant.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList(),
            ),
            image: CachedNetworkImage(
              imageUrl: context.knobs
                  .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9'),
            ),
          ),
        ),
      ),
      Story(
        name: 'Carrousel',
        description: 'Demo page for Carrousel',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: CarrouselDemoPage(
            memories: [
              MemoryCard(
                image: CachedNetworkImage(
                  imageUrl: context.knobs
                      .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9'),
                ),
                groupName: 'Boda',
                variant: MemoryCardVariant.update,
                onTap: () {},
                onError: null,
              ),
              MemoryCard(
                image: CachedNetworkImage(
                  imageUrl: context.knobs
                      .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9'),
                ),
                groupName: 'Pescado',
                variant: MemoryCardVariant.update,
                onTap: () {},
                onError: null,
              ),
              MemoryCard(
                image: CachedNetworkImage(
                  imageUrl: context.knobs
                      .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9'),
                ),
                groupName: 'Amigos',
                variant: MemoryCardVariant.dotsIntelligence,
                onTap: () {},
                onError: null,
              ),
              MemoryCard(
                image: CachedNetworkImage(
                  imageUrl: context.knobs
                      .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9'),
                ),
                groupName: 'Vacaciones en Islandia',
                variant: MemoryCardVariant.dotsIntelligence,
                onTap: () {},
                onError: null,
              ),
              MemoryCard(
                image: CachedNetworkImage(
                  imageUrl: context.knobs
                      .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9'),
                ),
                groupName: '15 Cumpleaños',
                variant: MemoryCardVariant.update,
                onTap: () {},
                onError: null,
              ),
              MemoryCard(
                image: CachedNetworkImage(
                  imageUrl: context.knobs
                      .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9'),
                ),
                groupName: 'Trabajo',
                variant: MemoryCardVariant.update,
                onTap: () {},
                onError: null,
              ),
              MemoryCard(
                image: CachedNetworkImage(
                  imageUrl: context.knobs
                      .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9'),
                ),
                groupName: 'De tranquis',
                variant: MemoryCardVariant.update,
                onTap: () {},
                onError: null,
              ),
              MemoryCard(
                image: CachedNetworkImage(
                  imageUrl: context.knobs
                      .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9'),
                ),
                groupName: 'De risas',
                variant: MemoryCardVariant.update,
                onTap: () {},
                onError: null,
              ),
            ],
          ),
        ),
      ),
      Story(
        name: 'Tag',
        description: 'Demo page for tag',
        builder: (context) => DotsTag(
          content: context.knobs.text(label: 'Content', initial: 'Tag text'),
          size: context.knobs.options<DotsTagSize>(
              label: 'Size',
              initial: DotsTagSize.medium,
              options:
                  DotsTagSize.values.map((item) => Option(label: item.name, value: item)).toList()),
          variant: context.knobs.options<DotsTagVariant>(
              label: 'Variant',
              initial: DotsTagVariant.main,
              options: DotsTagVariant.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList()),
        ),
      ),
      Story(
        name: 'Empty State Card',
        description: 'Demo page for Empty State Card',
        builder: (context) => EmptyStateCardDemo(
          imageProvider: NetworkImage(
            context.knobs.text(
              label: 'Container background image',
              initial: 'https://picsum.photos/250?image=9',
            ),
          ),
          title: context.knobs
              .text(label: 'Title', initial: '¿Quieres guardar la historia de tu familia?'),
          description: context.knobs.text(
              label: 'Description',
              initial:
                  'Desde las risas en la cocina hasta la foto que siempre se repite en Navidad...'),
          button: DotsMainButton(
            size: DotsMainButtonSize.medium,
            variant: DotsMainButtonVariant.main,
            expand: false,
            content: context.knobs.text(label: 'Button Text', initial: 'Crear álbum'),
            onTap: () {},
          ),
        ),
      ),
      Story(
        name: 'PlanSelector',
        description: 'Demo page for PlanSelector',
        builder: (context) => Container(
          width: 130,
          height: 1000,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DotsPlanSelector(
                title: context.knobs.text(label: 'Title', initial: 'Premium'),
                description: context.knobs.nullable
                    .text(label: 'Description', initial: 'Enjoy premium features!'),
                variant: context.knobs.options<DotsPlanSelectorVariant>(
                  label: 'Variant',
                  initial: DotsPlanSelectorVariant.premium,
                  options: DotsPlanSelectorVariant.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList(),
                ),
                selected: context.knobs.boolean(label: 'Selected', initial: false),
                onTap: context.knobs.boolean(label: 'Has onTap', initial: true) ? () {} : null,
              ),
            ],
          ),
        ),
      ),
      ...toastStories
    ];

import 'package:dots_design_system/dots_design_system.dart';
import 'package:example/components/blur_container_demo_page.dart';
import 'package:example/components/carrousel_demo_page.dart';
import 'package:example/components/dots_menu_demo_page.dart';
import 'package:example/components/dots_text_animations_demo_page.dart';
import 'package:example/components/folder_carrousel_demo_page.dart';
import 'package:example/components/item_input_demo.dart';
import 'package:example/components/memory_card_demo_page.dart';
import 'package:example/components/segmented_control_handle.dart';
import 'package:example/components/empty_state_card_demo.dart';
import 'package:example/stories/stories_by_folder/action_sheet_stories.dart';
import 'package:example/stories/stories_by_folder/badge_stories.dart';
import 'package:example/stories/stories_by_folder/button_stories.dart';
import 'package:example/stories/stories_by_folder/dropdown_stories.dart';
import 'package:example/stories/stories_by_folder/selector_radio_button_stories.dart';
import 'package:example/stories/stories_by_folder/theme_stories.dart';
import 'package:example/stories/stories_by_folder/toast_stories.dart';
import 'package:example/stories/stories_by_folder/top_bar_stories.dart';
import 'package:example/stories/stories_by_folder/group_cards_stories.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:example/stories/helpers/color_knob_options.dart';
import 'package:example/stories/stories_by_folder/notifications_stories.dart';

List<Story> get allStories => [
      ...notificationsStories,
      ...themeStories,
      ...badgeStories,
      ...buttonStories,
      ...toastStories,
      ...topBarStories,
      ...groupCards,
      ...selectorRadioButtonStories,
      ...actionSheetStories,
      ...dropdownStories,
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
        name: 'Segmented control bar',
        description: 'Demo page for Segmented control bar',
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SegmentedControlHandle(
              key: ValueKey('SegmentedControlHandle'),
              leftOptionName: context.knobs.text(label: 'Option 1', initial: 'Option 1'),
              rightOptionName: context.knobs.text(label: 'Option 2', initial: 'Option 2'),
              selectedColor: knobColorSelector(context, 'Selected color'),
              backgroundColor: knobColorSelector(context, 'Background color'),
            ),
          );
        },
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
        name: 'Empty State Card',
        description: 'Demo page for Empty State Card',
        builder: (context) => EmptyStateCardDemo(
          variant: context.knobs.options<DotsEmptyStateCardVariant>(
            label: 'Variant',
            initial: DotsEmptyStateCardVariant.image,
            options: DotsEmptyStateCardVariant.values
                .map((item) => Option(label: item.name, value: item))
                .toList(),
          ),
          icon: DotsIcon(
            iconData: context.knobs.options<DotsIconData>(
              label: 'Icon',
              initial: DotsIconData.search,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            size: 48,
          ),
          imageProvider: context.knobs.nullable.text(
                    label: 'Image URL',
                    initial: 'https://picsum.photos/250?image=9',
                  ) !=
                  null
              ? NetworkImage(context.knobs.nullable.text(
                  label: 'Image URL',
                  initial: 'https://picsum.photos/250?image=9',
                )!)
              : null,
          title: context.knobs.text(label: 'Title', initial: 'No data available'),
          description: context.knobs.text(label: 'Description', initial: 'Please try again later'),
          button: context.knobs.boolean(label: 'Show Button', initial: true)
              ? DotsMainButton(
                  size: DotsMainButtonSize.medium,
                  variant: DotsMainButtonVariant.main,
                  expand: false,
                  content: context.knobs.text(label: 'Button Text', initial: 'Crear álbum'),
                  onTap: () {},
                )
              : null,
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
                enabled: context.knobs.boolean(label: 'Enabled', initial: true),
                selected: context.knobs.boolean(label: 'Selected', initial: false),
                onTap: context.knobs.boolean(label: 'Has onTap', initial: true) ? () {} : null,
              ),
            ],
          ),
        ),
      ),
      Story(
        name: 'DotsTextFields',
        description: 'Demo page for DotsTextFields',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotsTextField(
            alignCenter: context.knobs.boolean(
              label: 'Align Center',
              initial: false,
            ),
            initialValue:
                context.knobs.nullable.text(label: 'Initial Value', initial: 'Sample text'),
            iconData: context.knobs.nullable.options<DotsIconData>(
              label: 'Icon Data',
              initial: DotsIconData.search,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            hintText: context.knobs.nullable.text(label: 'Hint Text', initial: 'Enter text') ??
                'Enter text',
            onChanged: (value) {},
            isError: context.knobs.boolean(label: 'Is Error', initial: false),
            errorText: context.knobs.nullable.text(label: 'Error Text', initial: 'Error message'),
            iconDataButton: context.knobs.options<DotsIconData>(
              label: 'Close Button Icon',
              initial: DotsIconData.cross,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            buttonVariant: context.knobs.options<DotsCloseButtonVariant>(
              label: 'Close Button Variant',
              initial: DotsCloseButtonVariant.inverted,
              options: DotsCloseButtonVariant.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList(),
            ),
            buttonSize: context.knobs.options<DotsCloseButtonSize>(
              label: 'Close Button Size',
              initial: DotsCloseButtonSize.extraSmall,
              options: DotsCloseButtonSize.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList(),
            ),
          ),
        ),
      ),
      Story(
        name: 'Dots text animations',
        description: 'Demo page for Dots text animations',
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: DotsTextAnimationsDemoPage(
              text: 'Texto de prueba',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
      ...toastStories,
      Story(
        name: 'Dots text Item input',
        description: 'Demo page for Dots Item input',
        builder: (context) {
          return Container(
            width: 400,
            padding: const EdgeInsets.all(16.0),
            child: ItemInputDemo(
              label: context.knobs.text(label: 'Label', initial: 'Enter text'),
              value: context.knobs.text(label: 'Value', initial: 'Sample'),
              iconData: context.knobs.options<DotsIconData>(
                label: 'Icon',
                initial: DotsIconData.search,
                options: DotsIconData.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList(),
              ),
              count: context.knobs.sliderInt(
                label: 'Count',
                initial: 3,
                min: 0,
                max: 100,
              ),
            ),
          );
        },
      ),
      Story(
        name: 'DotsNavBar',
        description: 'Demo page for DotsNavBar',
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: DotsNavBar(
              selectedIndex: context.knobs.sliderInt(
                label: 'Selected Index',
                initial: 0,
                min: 0,
                max: 2,
              ),
              items: [
                DotsNavBarItem(
                  label: context.knobs.text(label: 'Create', initial: 'Create'),
                  iconData: context.knobs.options<DotsIconData>(
                    label: 'First Icon',
                    initial: DotsIconData.add,
                    options: DotsIconData.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList(),
                  ),
                  onTap: () {},
                ),
                DotsNavBarItem(
                  label: context.knobs.text(label: 'Home', initial: 'Home'),
                  iconData: context.knobs.options<DotsIconData>(
                    label: 'Second Icon',
                    initial: DotsIconData.home,
                    options: DotsIconData.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList(),
                  ),
                  onTap: () {},
                ),
                DotsNavBarItem(
                  label: context.knobs.text(label: 'Gallery', initial: 'Gallery'),
                  iconData: context.knobs.options<DotsIconData>(
                    label: 'Third Icon',
                    initial: DotsIconData.gallery,
                    options: DotsIconData.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList(),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          );
        },
      ),
      Story(
        name: 'Folder Carrousel',
        description: 'Demo page for Folder Carrousel',
        builder: (context) {
          return FolderCarrouselDemoPage();
        },
      ),
      Story(
        name: 'Blur container',
        description: 'Demo page for blur container',
        builder: (context) {
          return BlurContainerDemoPage(
            text: context.knobs.text(label: 'Text', initial: 'Blurred Text'),
            imageUrl: context.knobs.text(
              label: 'Image URL',
              initial: 'https://picsum.photos/250?image=9',
            ),
            sigma: context.knobs.slider(
              label: 'Blur Sigma',
              initial: 5.0,
              min: 0.0,
              max: 5.0,
            ),
          );
        },
      ),
      Story(
        name: 'DotsListsItem',
        description: 'Demo page for DotsListsItem',
        builder: (context) {
          final variant = context.knobs.options<DotsListsItemVariant>(
            label: 'Variant',
            initial: DotsListsItemVariant.main,
            options: DotsListsItemVariant.values
                .map((item) => Option(label: item.name, value: item))
                .toList(),
          );
          final iconData = context.knobs.options<DotsIconData>(
            label: 'Icon',
            initial: DotsIconData.home,
            options: DotsIconData.values
                .map((item) => Option(label: item.name, value: item))
                .toList(),
          );
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.5,
              alignment: Alignment.center,
              child: DotsListsItem(
                image: NetworkImage('https://picsum.photos/250?image=9'),
                label: context.knobs.text(label: 'Label', initial: 'Sample Label'),
                onTap: () {},
                variant: variant,
                iconData: iconData,
              ),
            ),
          );
        },
      ),
      Story(
        name: 'DotsNotificationItem',
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
                  context.knobs.text(label: 'Profile Image URL', initial: 'https://picsum.photos/250?image=15'),
                ),
                actionImage: NetworkImage(
                  context.knobs.text(label: 'Action Image URL', initial: 'https://picsum.photos/250?image=9'),
                ),
                title: context.knobs.text(label: 'Title', initial: '¡Recupera todas las fotos!'),
                description: context.knobs.text(label: 'Description', initial: 'Sigue estos sencillos pasos para recuperar todos los Memories en tu álbum. '),
                date: context.knobs.text(label: 'Date', initial: '13:45'),
                onTap: () {},
              ),
            ),
          );
        },
      ),
      Story(
        name: 'DotsImageThumbnail',
        description: 'Demo page for DotsImageThumbnail',
        builder: (context) {
          final variant = context.knobs.options<DotsImageThumbnailVariant>(
            label: 'Variant',
            initial: DotsImageThumbnailVariant.image,
            options: DotsImageThumbnailVariant.values
                .map((item) => Option(label: item.name, value: item))
                .toList(),
          );
          return Center(
            child: DotsImageThumbnail(
              variant: variant,
              image: NetworkImage(
                context.knobs.text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9'),
              ),
              iconColor: basicColorSelector(context, 'Icon Color'),
              iconData: context.knobs.options<DotsIconData>(
                label: 'Icon',
                initial: DotsIconData.user,
                options: DotsIconData.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList(),
              ),
              iconSize: context.knobs.slider(
                label: 'Icon Size',
                initial: 20,
                min: 10,
                max: 40,
              ),
            ),
          );
        },
      ),
    ];

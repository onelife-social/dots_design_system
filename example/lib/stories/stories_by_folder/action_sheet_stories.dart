import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get actionSheetStories => [
      Story(
        name: 'Action Sheet/Alert',
        description: 'Demo page for Group Alerts popup',
        builder: (context) {
          return DotsActionSheetSpotlight(
            variant: DotsActionSheetSpotlightVariant.alert,
            title: context.knobs.text(label: 'Title', initial: 'Boda M&L'),
            label: context.knobs.text(label: 'Label', initial: 'hace 3 min'),
            bodyTitle: context.knobs.text(label: 'Alert Title', initial: '¡El bus sale en 10min!'),
            description: context.knobs.text(
                label: 'Alert Description',
                initial: 'Breve descripción de la acción que se va a realizar o de su estado'),
            image: NetworkImage('https://picsum.photos/250?image=9'),
            iconData: context.knobs.options<DotsIconData>(
              label: 'Icon Data',
              initial: DotsIconData.volume,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            primaryButton: DotsMainButton(
              content: context.knobs.text(label: 'Primary button text', initial: 'Ir a álbum'),
              variant: DotsMainButtonVariant.main,
              size: DotsMainButtonSize.mainAction,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ir al álbum'),
                  ),
                );
              },
            ),
            onClose: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('onClose'),
                ),
              );
            },
            imageWidth: context.knobs.slider(label: 'Image width', initial: 96, min: 0, max: 400),
            imageHeight: context.knobs.slider(label: 'Image height', initial: 96, min: 0, max: 400),
            iconSize: context.knobs.slider(label: 'Icon size', initial: 20, min: 0, max: 50),
            iconOffset: context.knobs.slider(label: 'Icon offset', initial: 4, min: -20, max: 80),
          );
        },
      ),
      Story(
        name: 'Action Sheet/Birthday',
        description: 'Demo page for user Birthday popup',
        builder: (context) {
          return DotsActionSheetSpotlight(
            variant: DotsActionSheetSpotlightVariant.user,
            title: context.knobs.text(label: 'Title', initial: '¡Hoy es el cumpleaños de Carmen!'),
            label: context.knobs.text(label: 'Label', initial: '@carmenmu17 · 24 años'),
            description: context.knobs.text(
                label: 'Description', initial: 'Tenéis 4 álbumes y 345 Memories compartidos.'),
            image: NetworkImage('https://picsum.photos/250?image=9'),
            iconData: context.knobs.options<DotsIconData>(
              label: 'Icon Data',
              initial: DotsIconData.cake,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            primaryButton: DotsMainButton(
              content: context.knobs.text(label: 'Primary button text', initial: 'Cerrar'),
              variant: DotsMainButtonVariant.secondary,
              size: DotsMainButtonSize.mainAction,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cerrar'),
                  ),
                );
              },
            ),
            onClose: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('onClose'),
                ),
              );
            },
            imageWidth: context.knobs.slider(label: 'Image width', initial: 96, min: 0, max: 400),
            iconSize: context.knobs.slider(label: 'Icon size', initial: 20, min: 0, max: 50),
            iconOffset: context.knobs.slider(label: 'Icon offset', initial: 4, min: -20, max: 80),
          );
        },
      ),
      Story(
        name: 'Action Sheet/Aniversary',
        description: 'Demo page for Aniversary/Pet birthday/Son-daughter birthday popup',
        builder: (context) {
          return DotsActionSheetSpotlight(
            variant: DotsActionSheetSpotlightVariant.album,
            title: context.knobs.text(label: 'Title', initial: '¡Hoy cumplís 8 años juntos!'),
            description: context.knobs.text(
                label: 'Description',
                initial: 'Tenéis 345 Memories compartidos. Revíverlos y añade nuevos recuerdos.'),
            image: NetworkImage('https://picsum.photos/250?image=9'),
            iconData: context.knobs.options<DotsIconData>(
              label: 'Icon Data',
              initial: DotsIconData.heart,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            primaryButton: DotsMainButton(
              content: context.knobs.text(label: 'Primary button text', initial: 'Ir al álbum'),
              variant: DotsMainButtonVariant.main,
              size: DotsMainButtonSize.mainAction,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ir al álbum'),
                  ),
                );
              },
            ),
            onClose: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('onClose'),
                ),
              );
            },
            imageWidth: context.knobs.slider(label: 'Image width', initial: 96, min: 0, max: 400),
            imageHeight: context.knobs.slider(label: 'Image height', initial: 96, min: 0, max: 400),
            iconSize: context.knobs.slider(label: 'Icon size', initial: 20, min: 0, max: 50),
            iconOffset: context.knobs.slider(label: 'Icon offset', initial: 4, min: -20, max: 80),
          );
        },
      ),
      Story(
        name: 'Action Sheet/DotsActionSheet',
        description: 'Demo page for action sheet',
        builder: (context) {
          final textFieldController = TextEditingController();
          final focus = FocusNode();

          return StatefulBuilder(
            builder: (context, setState) {
              focus.addListener(() {
                setState(() {});
              });

              void onTapBtn() {
                textFieldController.clear();
                setState(() {});
              }

              return DotsActionSheet(
                title: context.knobs.text(label: 'title', initial: 'Title'),
                description: context.knobs.text(label: 'description', initial: 'Description'),
                variant: context.knobs.options<DotsActionSheetVariant>(
                  label: 'Variant',
                  initial: DotsActionSheetVariant.standard,
                  options: DotsActionSheetVariant.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList(),
                ),
                primaryButton: context.knobs.boolean(label: 'Show primary button', initial: true)
                    ? DotsMainButton(
                        content:
                            context.knobs.text(label: 'Primary button text', initial: 'Primary'),
                        details: context.knobs.nullable.text(
                          label: 'Primary button details',
                          initial: 'Details',
                        ),
                        enabled:
                            context.knobs.boolean(label: 'Primary button enabled', initial: true),
                        variant: DotsMainButtonVariant.main,
                        size: DotsMainButtonSize.mainAction,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Primary button tapped!'),
                            ),
                          );
                        },
                      )
                    : null,
                secondaryButton: context.knobs
                        .boolean(label: 'Show secondary button', initial: true)
                    ? DotsMainButton(
                        content: context.knobs
                            .text(label: 'Secondary button text', initial: 'Secondary'),
                        details: context.knobs.nullable.text(
                          label: 'Secondary button details',
                          initial: 'Details',
                        ),
                        enabled:
                            context.knobs.boolean(label: 'Secondary button enabled', initial: true),
                        variant: DotsMainButtonVariant.secondary,
                        size: DotsMainButtonSize.mainAction,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Secondary button tapped!'),
                            ),
                          );
                        },
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
                showCloseButton: context.knobs.boolean(label: 'Show close button', initial: false),
                onClose: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('onClose'),
                    ),
                  );
                },
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
                textFieldController: textFieldController,
                focus: focus,
                onTapTextFieldBtn: onTapBtn,
                onChanged: (value) {
                  setState(() {});
                },
              );
            },
          );
        },
      ),
      Story(
        name: 'Action Sheet/DotsActionSheetSearch',
        description: 'Demo page for action sheet search',
        builder: (context) => DotsActionSheetSearch(
          hintText: context.knobs.text(label: 'hintText', initial: 'Search...'),
          title: context.knobs.text(label: 'title', initial: 'Title'),
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
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Primary button tapped!'),
                      ),
                    );
                  },
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
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Secondary button tapped!'),
                      ),
                    );
                  },
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
        name: 'Action Sheet/Base',
        description: 'Demo page for action sheet',
        builder: (context) => DotsActionSheetBase(
          onClose: () {},
          title: context.knobs.text(label: 'title', initial: 'Title'),
          subtitle: context.knobs.nullable.text(label: 'subtitle', initial: 'subtitle'),
          onBackButtonTap:
              context.knobs.boolean(label: 'Show back button', initial: true) ? () {} : null,
          bottomPosition: context.knobs.slider(
            label: 'Bottom position',
            initial: 56,
            min: 0,
            max: 200,
          ),
          horizontalPadding: context.knobs.slider(
            label: 'Horizontal padding',
            initial: 16,
            min: 0,
            max: 50,
          ),
          maxHeight: context.knobs.nullable.slider(
            label: 'Max height',
            initial: null,
            min: 350,
            max: 800,
          ),
          showBlurBackground: context.knobs.boolean(
            label: 'Show blur background',
            initial: true,
          ),
          child: Container(
            height: context.knobs.slider(
              label: 'Top widget height',
              initial: 200,
              min: 0,
              max: 500,
            ),
            color: context.dotsTheme.colors.bgContainerTertiary,
          ),
        ),
      ),
      Story(
        name: 'Action Sheet/DotsActionSheetInput',
        description: 'Demo page for DotsActionSheetInput',
        builder: (context) {
          final initialText =
              context.knobs.nullable.text(label: 'Initial Value', initial: 'Sample') ?? '';
          final textFieldController = TextEditingController(text: initialText);
          final colorController = ValueNotifier<DotsColorOption>(DotsColorOption.textQuarternary);

          return StatefulBuilder(
            builder: (context, setState) {
              final selectedColor = colorController.value;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: DotsActionSheetInput(
                  variant: context.knobs.options<ActionSheetInputVariant>(
                    label: 'Variant',
                    initial: ActionSheetInputVariant.main,
                    options: ActionSheetInputVariant.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList(),
                  ),
                  title: context.knobs.nullable.text(label: 'Title', initial: 'Action Sheet'),
                  subtitle:
                      context.knobs.nullable.text(label: 'Subtitle', initial: 'Select an option'),
                  onBackButtonTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Back button tapped!'),
                      ),
                    );
                  },
                  onClose: () {},
                  showBlurBackground:
                      context.knobs.boolean(label: 'Show Blur Background', initial: true),
                  iconData: context.knobs.options<DotsIconData>(
                    label: 'Folder Icon Data',
                    initial: DotsIconData.add,
                    options: DotsIconData.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList(),
                  ),
                  onIconTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Icon Btn tapped!'),
                      ),
                    );
                  },
                  textFieldController: textFieldController,
                  onMainButtonTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Main button tapped!'),
                      ),
                    );
                  },
                  actionButtonText:
                      context.knobs.nullable.text(label: 'Action Button Text', initial: 'Confirm'),
                  colorController: colorController,
                  selectedColor: selectedColor,
                  dateLabel:
                      context.knobs.nullable.text(label: 'Date Label', initial: 'Select a date'),
                  dateValue:
                      context.knobs.nullable.text(label: 'Date Value', initial: '2023-01-01'),
                  dateIconData: context.knobs.options<DotsIconData>(
                    label: 'Date Icon Data',
                    initial: DotsIconData.calendar,
                    options: DotsIconData.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList(),
                  ),
                  onDateTap: () {},
                  image: NetworkImage('https://picsum.photos/250?image=9'),
                  userLabel: context.knobs.nullable.text(label: 'User Label', initial: 'User'),
                  inputHintText: context.knobs.nullable
                      .text(label: 'Input Hint Text', initial: 'Type something...'),
                ),
              );
            },
          );
        },
      ),
      Story(
        name: 'Action Sheet/DotsActionSheetList',
        description: 'Demo page for DotsActionSheetList',
        builder: (context) {
          final count = context.knobs.sliderInt(
            label: 'Count',
            initial: 3,
            min: 0,
            max: 10,
          );

          final albumsNotifier = ValueNotifier<List<String>>(
            List.generate(count, (i) => 'Album ${i + 1}'),
          );

          final items = List.generate(
            count,
            (i) => DotsListItemModel(
              label: 'Album ${i + 1}',
              image: NetworkImage('https://picsum.photos/250?image=9'),
              variant: DotsListsItemVariant.selector,
            ),
          );

          final scrollController = ScrollController();
          bool isScrolled = false;
          bool searchBtnHide = true;

          return StatefulBuilder(
            builder: (context, setState) {
              scrollController.addListener(() {
                final scrolled = scrollController.offset > 0;
                if (scrolled != isScrolled) {
                  setState(() {
                    isScrolled = scrolled;
                    searchBtnHide = !scrolled;
                  });
                }
              });
              return ValueListenableBuilder<List<String>>(
                valueListenable: albumsNotifier,
                builder: (context, albums, _) {
                  final List<SelectedItem> selectedAlbums = albums
                      .asMap()
                      .entries
                      .map((entry) => SelectedItem(id: entry.key, name: entry.value))
                      .toList();

                  return DotsActionSheetList(
                    variant: context.knobs.options<ActionSheetListVariant>(
                      label: 'Variant',
                      initial: ActionSheetListVariant.main,
                      options: ActionSheetListVariant.values
                          .map((item) => Option(label: item.name, value: item))
                          .toList(),
                    ),
                    isLabelButtonAvailable:
                        context.knobs.boolean(label: 'Is Available', initial: false),
                    title: context.knobs.text(label: 'Title', initial: 'Select an album'),
                    description:
                        context.knobs.text(label: 'Description', initial: 'This is a description'),
                    onClose: () {},
                    onBackButtonTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Back button tapped!'),
                        ),
                      );
                    },
                    onCloseButtonTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Close button tapped!'),
                        ),
                      );
                    },
                    onMainButtonTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Main button tapped!'),
                        ),
                      );
                    },
                    mainButtonText:
                        context.knobs.text(label: 'Action Button Text', initial: 'Siguiente'),
                    mainButtonIcon: context.knobs.options<DotsIconData>(
                      label: 'Main Button Icon',
                      initial: DotsIconData.add,
                      options: DotsIconData.values
                          .map((item) => Option(label: item.name, value: item))
                          .toList(),
                    ),
                    labelButtonText:
                        context.knobs.text(label: 'Label Button Text', initial: 'Label'),
                    selectedItemNames: selectedAlbums,
                    onBtnChipTap: (int index) {
                      final newList = List<String>.from(albums);
                      newList.removeAt(index);
                      albumsNotifier.value = newList;
                    },
                    inputIcon: context.knobs.options<DotsIconData>(
                      label: 'Input Icon',
                      initial: DotsIconData.search,
                      options: DotsIconData.values
                          .map((item) => Option(label: item.name, value: item))
                          .toList(),
                    ),
                    hintInputText:
                        context.knobs.text(label: 'Hint Input Text', initial: 'Busca un álbum...'),
                    listTitle: context.knobs.text(label: 'List Title', initial: 'Albums'),
                    listItems: [
                      for (int i = 0; i < items.length; i++)
                        DotsListItemModel(
                          label: items[i].label,
                          image: items[i].image,
                          variant: items[i].variant,
                          onTap: () {
                            setState(() {
                              items[i] = DotsListItemModel(
                                label: items[i].label,
                                image: items[i].image,
                                variant: items[i].variant == DotsListsItemVariant.radioButton
                                    ? DotsListsItemVariant.selector
                                    : DotsListsItemVariant.radioButton,
                              );
                            });
                          },
                        ),
                    ],
                    isEmptySearch: context.knobs.boolean(label: 'isEmptySearch', initial: false),
                    emptyListTitle: context.knobs.text(
                      label: 'Empty List Title',
                      initial: 'No results found',
                    ),
                    emptyListDescription: context.knobs.text(
                      label: 'Empty List Description',
                      initial: 'Try searching for something else',
                    ),
                    emptyListIconData: context.knobs.options<DotsIconData>(
                      label: 'Empty List Icon',
                      initial: DotsIconData.search,
                      options: DotsIconData.values
                          .map((item) => Option(label: item.name, value: item))
                          .toList(),
                    ),
                    emptyListImage: NetworkImage('https://picsum.photos/250?image=9'),
                    isScrolled: isScrolled,
                    searchBtnHide: searchBtnHide,
                    searchBtnIcon: context.knobs.options<DotsIconData>(
                      label: 'Search Button Icon',
                      initial: DotsIconData.search,
                      options: DotsIconData.values
                          .map((item) => Option(label: item.name, value: item))
                          .toList(),
                    ),
                    onSearchBtnTap: () {
                      setState(() {
                        searchBtnHide = true;
                      });
                    },
                    scrollController: scrollController,
                  );
                },
              );
            },
          );
        },
      ),
      Story(
        name: 'Action Sheet/DotsActionSheetListIcon',
        description: 'Demo page for DotsActionSheetListIcon',
        builder: (context) {
          final List<DotsActionSheetIconModel> iconModels = DotsIconData.values.map((icon) {
            return DotsActionSheetIconModel(
              icon: icon,
              variant: DotsIconButtonVariant.noBackground,
              size: DotsIconButtonSize.extraLarge,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${icon.name} tapped!'),
                  ),
                );
              },
            );
          }).toList();

          return DotsActionSheetListIcon(
            title: context.knobs.text(label: 'Title', initial: 'Select an item'),
            onBackButtonTap: context.knobs.boolean(label: 'Show back button', initial: true)
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Back button tapped!'),
                      ),
                    );
                  }
                : null,
            onClose: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Close button tapped!'),
                ),
              );
            },
            icons: iconModels,
          );
        },
      ),
      Story(
        name: 'Action Sheet/DotsActionSheetRadioButtons',
        description: 'Demo page for DotsActionSheetRadioButtons',
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return DotsActionSheetRadioButtons(
                topWidget: CachedNetworkImage(
                  imageUrl: context.knobs
                      .text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9'),
                  width: 96,
                ),
                title: context.knobs.text(label: 'Title', initial: 'Título'),
                subtitle: context.knobs.text(
                  label: 'Subtitle',
                  initial: 'Breve descripción de la acción que se va a realizar o de su estado',
                ),
                items: [
                  RadioCardIcons(
                    title: '250 memories organizados al día',
                    details1: '8 min/día',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped: 250 memories organizados al día')),
                    ),
                    variant: RadioCardIconsVariant.selector,
                  ),
                  RadioCardIcons(
                    title: '500 memories organizados al día',
                    details1: '12 min/día',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped: 500 memories organizados al día')),
                    ),
                    variant: RadioCardIconsVariant.selector,
                  ),
                  RadioCardIcons(
                    title: '1000 memories organizados al día',
                    details1: '15 min/día',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped: 1000 memories organizados al día')),
                    ),
                    variant: RadioCardIconsVariant.selector,
                  ),
                  RadioCardIcons(
                    title: '1500 memories organizados al día',
                    details1: '20 min/día',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped: 1500 memories organizados al día')),
                    ),
                    variant: RadioCardIconsVariant.selector,
                  ),
                  RadioCardIcons(
                    title: '2000 memories organizados al día',
                    details1: '25 min/día',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped: 2000 memories organizados al día')),
                    ),
                    variant: RadioCardIconsVariant.selector,
                  ),
                  RadioCardIcons(
                    title: '2500 memories organizados al día',
                    details1: '30 min/día',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped: 2500 memories organizados al día')),
                    ),
                    variant: RadioCardIconsVariant.selector,
                  ),
                  RadioCardIcons(
                    title: '3000 memories organizados al día',
                    details1: '35 min/día',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped: 3000 memories organizados al día')),
                    ),
                    variant: RadioCardIconsVariant.selector,
                  ),
                ],
                buttonLabel: 'Siguiente',
                onTapButton: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped: button')),
                ),
                onClose: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped: close / tapped outside to close')),
                ),
              );
            },
          );
        },
      ),
      Story(
        name: 'Action Sheet/Settings',
        description: 'Demo page for action sheet settings',
        builder: (context) {
          return DotsActionSheetSettings(
            image: NetworkImage('https://picsum.photos/250?image=9'),
            title: context.knobs.text(label: 'Title', initial: 'Ajustes del álbum'),
            imageWidth: context.knobs.slider(label: 'Image width', initial: 100, min: 50, max: 200),
            imageHeight:
                context.knobs.slider(label: 'Image height', initial: 100, min: 50, max: 200),
            showBlurBackground: context.knobs.boolean(label: 'Show blur background', initial: true),
            bottomPosition:
                context.knobs.slider(label: 'Bottom position', initial: 56, min: 0, max: 200),
            onClose: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('onClose')),
              );
            },
            onTapCloseButton: context.knobs.boolean(label: 'Show close button', initial: true)
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Close button tapped')),
                    );
                  }
                : null,
            buttons: [
              DotsSystemButton(
                content: 'Editar álbum',
                icon: DotsIconData.draw,
                variant: DotsSystemButtonVariant.active,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit album')),
                  );
                },
              ),
              DotsSystemButton(
                content: 'Compartir álbum',
                icon: DotsIconData.share,
                variant: DotsSystemButtonVariant.active,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share album')),
                  );
                },
              ),
              DotsSystemButton(
                content: 'Eliminar álbum',
                icon: DotsIconData.trash,
                variant: DotsSystemButtonVariant.destructive,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Delete album')),
                  );
                },
              ),
            ],
          );
        },
      ),
    ];

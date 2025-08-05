import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get actionSheetStories => [
      Story(
        name: 'Action Sheet/DotsActionSheet',
        description: 'Demo page for action sheet',
        builder: (context) => DotsActionSheet(
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
        name: 'Action Sheet/DotsActionSheetSearch',
        description: 'Demo page for action sheet search',
        builder: (context) => DotsActionSheetSearch(
          hintText: context.knobs.text(label: 'hintText', initial: 'Search...'),
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
                  subtitle: context.knobs.nullable.text(label: 'Subtitle', initial: 'Select an option'),
                  onBackButtonTap: () {},
                  onClose: () {},
                  showBlurBackground: context.knobs.boolean(label: 'Show Blur Background', initial: true),
                  iconData: context.knobs.options<DotsIconData>(
                    label: 'Folder Icon Data',
                    initial: DotsIconData.add,
                    options: DotsIconData.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList(),
                  ),
                  onIconTap: () {},
                  initialValue: context.knobs.nullable.text(label: 'Initial Value', initial: 'Sample'),
                  onMainButtonTap: () {},
                  actionButtonText: context.knobs.nullable.text(label: 'Action Button Text', initial: 'Confirm'),
                  colorController: colorController,
                  selectedColor: selectedColor,
                  dateLabel: context.knobs.nullable.text(label: 'Date Label', initial: 'Select a date'),
                  dateValue: context.knobs.nullable.text(label: 'Date Value', initial: '2023-01-01'),
                  dateIconData: context.knobs.options<DotsIconData>(
                    label: 'Date Icon Data',
                    initial: DotsIconData.calendar,
                    options: DotsIconData.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList(),
                  ),
                  onDateTap: () {},
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
                return DotsActionSheetList(
                  variant: context.knobs.options<ActionSheetListVariant>(
                    label: 'Variant',
                    initial: ActionSheetListVariant.main,
                    options: ActionSheetListVariant.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList(),
                  ),
                  isLabelButtonAvailable: context.knobs.boolean(label: 'Is Available', initial: false),
                  title: context.knobs.text(label: 'Title', initial: 'Select an album'),
                  onClose: () {},
                  onBackButtonTap: () {},
                  onMainButtonTap: () {},
                  mainButtonText: context.knobs.text(label: 'Action Button Text', initial: 'Siguiente'),
                  mainButtonIcon: context.knobs.options<DotsIconData>(
                    label: 'Main Button Icon',
                    initial: DotsIconData.add,
                    options: DotsIconData.values
                        .map((item) => Option(label: item.name, value: item))
                        .toList(),
                  ),
                  labelButtonText: context.knobs.text(label: 'Label Button Text', initial: 'Label'),
                  selectedAlbumNames: albums,
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
                  hintInputText: context.knobs.text(label: 'Hint Input Text', initial: 'Busca un álbum...'),
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
    ];

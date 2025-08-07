import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum ActionSheetListVariant {
  main,
  ghost;

  bool get isMain => this == ActionSheetListVariant.main;
  bool get isGhost => this == ActionSheetListVariant.ghost;
}

class DotsActionSheetList extends StatelessWidget {

  /// The [variant] parameter determines the type of action sheet.
  /// - [ActionSheetListVariant.main] is the default variant & have a mainButton.
  /// - [ActionSheetListVariant.ghost] have a btn to create a album.
  final ActionSheetListVariant variant;

  /// The [title] parameter is the title of the action sheet.
  final String title;

  /// The [onBackButtonTap] is a callback for the back button.
  final Function()? onBackButtonTap;

  /// The [bottomPosition] is the position of the action sheet from the bottom.
  final double bottomPosition;

  /// The [onClose] is a callback for closing the action sheet tapping outside.
  final VoidCallback? onClose;

  /// The [showBlurBackground] parameter determines if the background should be blurred.
  final bool showBlurBackground;

  /// The [onLabelButtonTap] is a callback for the main button tap.
  final Function()? onLabelButtonTap;

  /// The [labelButtonText] is the text for the label button.
  final String? labelButtonText;

  /// The [onMainButtonTap] is a callback for the main button tap.
  final Function() onMainButtonTap;

  /// The [mainButtonText] is the text for the main button.
  final String mainButtonText;

  /// The [mainButtonIcon] is the icon for the main button.
  final DotsIconData mainButtonIcon;

  /// The [inputIcon] is the icon for the input field.
  final DotsIconData inputIcon;

  /// The [hintInputText] is the hint text for the input field.
  final String? hintInputText;

  /// The [onInputChanged] is a callback for the input field changes.
  final ValueChanged<String>? onInputChanged;

  /// The [selectedAlbumNames] is a text list of selected albums at the action sheet.
  final List<String>? selectedAlbumNames;

  /// The [onBtnChipTap] is a callback for the filter chip tap.
  final Function(int)? onBtnChipTap;

  /// The [searchBtnHide] is a boolean to determine if the search button at the selected list is hidden.
  final bool searchBtnHide;

  /// The [searchBtnIcon] is the icon for the search button.
  final DotsIconData searchBtnIcon;

  /// The [onSearchBtnTap] is a callback for the search button tap.
  final Function()? onSearchBtnTap;

  /// The [isScrolled] is a boolean to determine if the list is scrolled.
  final bool isScrolled;

  /// The [isLabelButtonAvailable] is a boolean to determine the label button is available.
  final bool isLabelButtonAvailable;

  /// The [listTitle] is the title for the list of items in the action sheet.
  final String? listTitle;

  /// The [listItems] is a list of items to be displayed in the action sheet.
  /// Each item is a [DotsListItemModel] widget.
  final List<DotsListItemModel>? listItems;

  /// The [isEmptySearch] is a boolean to determine if the search is empty.
  final bool isEmptySearch;

  /// The [emptyListTitle] is the title for the empty state of the list.
  final String? emptyListTitle;

  /// The [emptyListDescription] is the description for the empty state of the list.
  final String? emptyListDescription;

  /// The [emptyListIconData] is the icon data for the empty state of the list.
  final DotsIconData? emptyListIconData;

  /// The [emptyListImage] is the image for the empty state of the list.
  final ImageProvider? emptyListImage;

  /// The [scrollController] is the controller for the scroll view.
  final ScrollController? scrollController;

  /// The [textFieldController] is the controller for the text field.
  final TextEditingController? textFieldController;

  /// The [focus] is a boolean to determine if the text field is focused.
  final FocusNode? focus;

  /// The [onTapTextFieldBtn] is a callback for the text field button tap.
  final VoidCallback? onTapTextFieldBtn;

  const DotsActionSheetList({
    super.key,
    this.variant = ActionSheetListVariant.main,
    required this.title,
    required this.onMainButtonTap,
    required this.mainButtonText,
    this.textFieldController,
    this.focus,
    this.onTapTextFieldBtn,
    this.bottomPosition = 56,
    this.mainButtonIcon = DotsIconData.add,
    this.onLabelButtonTap,
    this.labelButtonText,
    this.onBackButtonTap,
    this.onClose,
    this.showBlurBackground = true,
    this.inputIcon = DotsIconData.search,
    this.hintInputText,
    this.onInputChanged,
    this.selectedAlbumNames,
    this.onBtnChipTap,
    this.isScrolled = false,
    this.isLabelButtonAvailable = false,
    this.listTitle,
    this.listItems,
    this.emptyListTitle,
    this.emptyListDescription,
    this.emptyListIconData,
    this.emptyListImage,
    this.isEmptySearch = false,
    this.searchBtnHide = true,
    this.searchBtnIcon = DotsIconData.search,
    this.onSearchBtnTap,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Stack(
      children: [
        GestureDetector(
          onTap: onClose,
          child: Container(
            child: showBlurBackground
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Colors.black.dotsWithOpacity(0.3),
                    ),
                  )
                : null,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: bottomPosition,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: context.getByRatio(657, 480),
              ),
              decoration: BoxDecoration(
                color: theme.colors.bgBaseContrast,
                borderRadius: DotsBorderRadius.r32,
              ),
              width: double.infinity,
              child: ClipRRect(
                borderRadius: DotsBorderRadius.r32, 
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _Header(
                        title: title,
                      onBackButtonTap: onBackButtonTap,
                      variant: variant,
                      onLabelButtonTap: onLabelButtonTap,
                      labelButtonText: labelButtonText,
                      inputIcon: inputIcon,
                      hintInputText: hintInputText,
                      onInputChanged: onInputChanged,
                      isScrolled: isScrolled,
                      selectedAlbumNames: selectedAlbumNames,
                      onBtnChipTap: onBtnChipTap,
                      isLabelButtonAvailable: isLabelButtonAvailable,
                      searchBtnHide: searchBtnHide,
                      searchBtnIcon: searchBtnIcon,
                      onSearchBtnTap: onSearchBtnTap,
                      textFieldController: textFieldController,
                      focus: focus,
                      onTapTextFieldBtn: onTapTextFieldBtn,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: _Body(
                              listTitle: listTitle,
                              listItems: listItems,
                              isEmptySearch: isEmptySearch,
                              emptyListTitle: emptyListTitle,
                              emptyListDescription: emptyListDescription,
                              emptyListIconData: emptyListIconData,
                              emptyListImage: emptyListImage,
                              scrollController: scrollController,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            height: 70,
                            child: IgnorePointer(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: [0.0, 0.2, 1.0],
                                    colors: [
                                      theme.colors.bgBaseContrast,
                                      theme.colors.bgBaseContrast.dotsWithOpacity(0.7),
                                      theme.colors.bgBaseContrast.dotsWithOpacity(0.0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _Footer(
                      variant: variant,
                      mainButtonText: mainButtonText,
                      onMainButtonTap: onMainButtonTap,
                      mainButtonIcon: mainButtonIcon,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final Function()? onBackButtonTap;
  final ActionSheetListVariant variant;
  final Function()? onLabelButtonTap;
  final String? labelButtonText;
  final DotsIconData inputIcon;
  final String? hintInputText;
  final ValueChanged<String>? onInputChanged;
  final List<String>? selectedAlbumNames;
  final Function(int)? onBtnChipTap;
  final bool isScrolled;
  final bool isLabelButtonAvailable;
  final bool searchBtnHide;
  final DotsIconData searchBtnIcon;
  final Function()? onSearchBtnTap;
  final TextEditingController? textFieldController;
  final FocusNode? focus;
  final VoidCallback? onTapTextFieldBtn;

  const _Header({
    required this.variant,
    required this.title,
    this.onBackButtonTap,
    this.onLabelButtonTap,
    this.labelButtonText,
    this.inputIcon = DotsIconData.search,
    this.hintInputText,
    this.onInputChanged,
    this.selectedAlbumNames,
    this.onBtnChipTap,
    this.isScrolled = false,
    this.isLabelButtonAvailable = false,
    this.searchBtnHide = true,
    this.searchBtnIcon = DotsIconData.search,
    this.onSearchBtnTap,
    this.textFieldController,
    this.focus,
    this.onTapTextFieldBtn,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Container(
      decoration: BoxDecoration(
        border: isScrolled
          ? Border(
              bottom: BorderSide(
                color: theme.colors.labelSecondary,
                width: 0.5,
              ),
            )
          : null,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: context.getByRatio(16, 10), left: 16, right: 16),
              child: Row(
                children: [
                  if (onBackButtonTap != null) ...[
                    Container(
                      alignment: Alignment.centerLeft,
                      width: variant.isMain ? 44 : 80,
                      child: DotsIconButton(
                        icon: DotsIconData.chevronLeft,
                        size: DotsIconButtonSize.medium,
                        variant: DotsIconButtonVariant.noBackground,
                        onTap: onBackButtonTap,
                      ),
                    ),
                  ],
                  Expanded(
                    child: Center(
                      child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        title,
                        style: theme.typo.secondary.title02H6,
                        textAlign: TextAlign.center,
                      ),
                      ),
                    ),
                  ),
                  if (!variant.isGhost)  
                    const SizedBox(width: 24)
                  else
                    Container(
                      alignment: Alignment.centerRight,
                      width: 80,
                      child: DotsMainButton(
                        content: labelButtonText ?? '',
                        variant: DotsMainButtonVariant.main,
                        size: DotsMainButtonSize.small,
                        enabled: isLabelButtonAvailable,
                        onTap: onLabelButtonTap,
                        expand: false,
                      ),
                    ),
                ],
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 150),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) {
                            return Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.diagonal3Values(animation.value, 1.0, 1.0),
                              child: child,
                            );
                          },
                          child: child,
                        ),
                      );
                    },
                    child: (!isScrolled || searchBtnHide)
                        ? Padding(
                            key: const ValueKey('searchField'),
                            padding: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: context.getByRatio(16, 10),
                            ),
                            child: DotsTextField(
                              controller: textFieldController,
                              focusNode: focus,
                              onTapBtn: onTapTextFieldBtn,
                              iconData: inputIcon,
                              hintText: hintInputText,
                              onChanged: onInputChanged,
                            ),
                          )
                        : const SizedBox(
                            key: ValueKey('emptyField'),
                          ),
                  ),
                if (selectedAlbumNames?.isNotEmpty == true)
                  Padding(
                    padding:  EdgeInsets.only(bottom: context.getByRatio(16, 10)),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (isScrolled && !searchBtnHide)
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: DotsIconButton(
                                  icon: searchBtnIcon,
                                  size: DotsIconButtonSize.small,
                                  variant: DotsIconButtonVariant.solid,
                                  iconSize: 14,
                                  onTap: onSearchBtnTap,
                                ),
                              ),
                            for (int i = 0; i < selectedAlbumNames!.length; i++)
                              Padding(
                                padding: EdgeInsets.only(
                                  left: i == 0
                                      ? (searchBtnHide ? 16 : 4)
                                      : 0,
                                  right: 4,
                                ),
                                child: DotsFilterChip(
                                  label: selectedAlbumNames?[i],
                                  onTap: () => onBtnChipTap?.call(i),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {

  final String? listTitle;
  final List<DotsListItemModel>? listItems;
  final bool isEmptySearch;
  final String? emptyListTitle;
  final String? emptyListDescription;
  final DotsIconData? emptyListIconData;
  final ImageProvider? emptyListImage;
  final ScrollController? scrollController;

  const _Body({
    super.key,
    this.listTitle,
    this.listItems,
    this.isEmptySearch = false,
    this.emptyListTitle,
    this.emptyListDescription,
    this.emptyListIconData,
    this.emptyListImage,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    if (listItems == null || listItems!.isEmpty) {
      return ClipRect(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: isEmptySearch
                ? DotsEmptyStateCard(
                    variant: DotsEmptyStateCardVariant.icon,
                    title: emptyListTitle ?? '',
                    description: emptyListDescription ?? '',
                    icon: DotsIcon(
                      iconData: emptyListIconData ?? DotsIconData.search,
                      size: 48,
                      color: theme.colors.textQuarternary,
                    ),
                  )
                : DotsEmptyStateCard(
                    variant: DotsEmptyStateCardVariant.image,
                    title: emptyListTitle ?? '',
                    description: emptyListDescription ?? '',
                    imageProvider: emptyListImage,
                  ),
          ),
        ),
      );
    } else {
      return ClipRect(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listTitle ?? '',
                    style: theme.typo.main.labelDefaultBold.copyWith(
                      color: theme.colors.textTertiary,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 12),
                  for (final item in listItems!)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: DotsListsItem(
                        label: item.label,
                        iconData: item.iconData,
                        image: item.image,
                        variant: item.variant,
                        onTap: item.onTap,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

class _Footer extends StatelessWidget {
  final ActionSheetListVariant variant;
  final String mainButtonText;
  final Function() onMainButtonTap;
  final DotsIconData mainButtonIcon;

  const _Footer({
    super.key,
    required this.variant,
    required this.mainButtonText,
    required this.onMainButtonTap,
    this.mainButtonIcon = DotsIconData.add,

  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Container(
      color: theme.colors.transparent,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Center(
        child: variant.isMain
            ? DotsMainButton(
                content: mainButtonText,
                variant: DotsMainButtonVariant.main,
                size: DotsMainButtonSize.mainAction,
                onTap: onMainButtonTap,
              )
            : DotsIconButton(
                icon: mainButtonIcon,
                onTap: onMainButtonTap,
                label: mainButtonText,
                labelStyle: theme.typo.main.labelDefaultBold.copyWith(
                  color: theme.colors.textPrimary,
                ),
                variant: DotsIconButtonVariant.active,
                size: DotsIconButtonSize.small,
                direction: DotsIconButtonDirection.row,
              ),
      ),
    );
  }
}
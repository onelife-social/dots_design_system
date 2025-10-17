import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum ActionSheetListVariant {
  main,
  ghost;

  bool get isMain => this == ActionSheetListVariant.main;
  bool get isGhost => this == ActionSheetListVariant.ghost;
}

class SelectedItem {
  final int id;
  final String name;

  SelectedItem({
    required this.id,
    required this.name,
  });
}

class DotsActionSheetList extends StatelessWidget {
  /// The [variant] parameter determines the type of action sheet.
  /// - [ActionSheetListVariant.main] is the default variant & have a mainButton.
  /// - [ActionSheetListVariant.ghost] have a btn to create a album.
  final ActionSheetListVariant variant;

  /// The [title] parameter is the title of the action sheet.
  final String title;

  /// The [description] parameter is the description of the action sheet.
  final String? description;

  /// The [onBackButtonTap] is a callback for the back button.
  final Function()? onBackButtonTap;

  /// The [bottomPosition] is the position of the action sheet from the bottom.
  final double bottomPosition;

  /// The [onClose] is a callback for closing the action sheet tapping outside.
  final VoidCallback? onClose;

  /// The [onCloseButtonTap] is a callback for the close button tap.
  final VoidCallback? onCloseButtonTap;

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

  /// The [selectedItemNames] is a text list of selected albums at the action sheet.
  final List<SelectedItem>? selectedItemNames;

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

  /// The [emptyImageWidth] is the width for the empty state image.
  final double? emptyImageWidth;

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
    this.description,
    this.textFieldController,
    this.focus,
    this.onTapTextFieldBtn,
    this.bottomPosition = 56,
    this.mainButtonIcon = DotsIconData.add,
    this.onLabelButtonTap,
    this.labelButtonText,
    this.onBackButtonTap,
    this.onClose,
    this.onCloseButtonTap,
    this.showBlurBackground = true,
    this.inputIcon = DotsIconData.search,
    this.hintInputText,
    this.onInputChanged,
    this.selectedItemNames,
    this.onBtnChipTap,
    this.isScrolled = false,
    this.isLabelButtonAvailable = false,
    this.listTitle,
    this.listItems,
    this.emptyListTitle,
    this.emptyListDescription,
    this.emptyListIconData,
    this.emptyListImage,
    this.emptyImageWidth,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Grabber(),
                    ),
                    _Header(
                      title: title,
                      description: description,
                      onBackButtonTap: onBackButtonTap,
                      variant: variant,
                      onLabelButtonTap: onLabelButtonTap,
                      onCloseButtonTap: onCloseButtonTap,
                      labelButtonText: labelButtonText,
                      inputIcon: inputIcon,
                      hintInputText: hintInputText,
                      onInputChanged: onInputChanged,
                      isScrolled: isScrolled,
                      selectedItems: selectedItemNames,
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
                              imageWidth: emptyImageWidth,
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
                      enabled: selectedItemNames?.isNotEmpty == true,
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
  final String? description;
  final Function()? onBackButtonTap;
  final ActionSheetListVariant variant;
  final Function()? onLabelButtonTap;
  final Function()? onCloseButtonTap;
  final String? labelButtonText;
  final DotsIconData inputIcon;
  final String? hintInputText;
  final ValueChanged<String>? onInputChanged;
  final List<SelectedItem>? selectedItems;
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
    this.description,
    this.onLabelButtonTap,
    this.onCloseButtonTap,
    this.labelButtonText,
    this.inputIcon = DotsIconData.search,
    this.hintInputText,
    this.onInputChanged,
    this.selectedItems,
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
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: description != null ? 4 : context.getByRatio(16, 10),
                left: 16,
                right: 16,
              ),
              child: Row(
                children: [
                  if (onBackButtonTap != null)
                    Container(
                      alignment: Alignment.centerLeft,
                      width: variant.isMain ? 44 : 80,
                      child: DotsIconButton(
                        icon: DotsIconData.chevronLeft,
                        size: DotsIconButtonSize.medium,
                        variant: DotsIconButtonVariant.noBackground,
                        onTap: onBackButtonTap,
                      ),
                    )
                  else
                    SizedBox(width: !variant.isGhost ? 24 : 80),
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
                  if (!variant.isGhost && onCloseButtonTap != null)
                    DotsCloseButton(
                      icon: DotsIconData.cross,
                      size: DotsCloseButtonSize.medium,
                      variant: DotsCloseButtonVariant.softContrast,
                      onTap: onCloseButtonTap,
                    )
                  else if (onLabelButtonTap != null)
                    SizedBox(
                      width: 80,
                      child: DotsMainButton(
                        content: labelButtonText ?? '',
                        variant: DotsMainButtonVariant.main,
                        size: DotsMainButtonSize.small,
                        enabled: isLabelButtonAvailable,
                        onTap: onLabelButtonTap,
                        expand: false,
                      ),
                    )
                  else
                    SizedBox(width: 24),
                ],
              ),
            ),
            if (description != null)
              Padding(
                padding: EdgeInsets.only(left: 32, right: 32, bottom: context.getByRatio(16, 10)),
                child: Text(
                  textAlign: TextAlign.center,
                  description ?? '',
                  style: theme.typo.main.bodyDefaultRegular.copyWith(
                    color: theme.colors.textQuarternary,
                  ),
                ),
              ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              alignment: Alignment.bottomCenter,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: AnimatedBuilder(
                      animation: animation,
                      builder: (context, c) => Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.diagonal3Values(animation.value, 1, 1),
                        child: c,
                      ),
                      child: child,
                    ),
                  );
                },
                child: (!isScrolled || searchBtnHide)
                    ? Padding(
                        key: const ValueKey('searchField'),
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
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
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  final slide = Tween<Offset>(
                    begin: const Offset(0, 0.08),
                    end: Offset.zero,
                  ).animate(animation);
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(position: slide, child: child),
                  );
                },
                child: (selectedItems?.isNotEmpty == true)
                    ? Padding(
                        key: ValueKey<int>(selectedItems!.length),
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            child: Row(
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
                                for (int i = 0; i < selectedItems!.length; i++)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: i == 0 ? (searchBtnHide ? 16 : 4) : 0,
                                      right: 4,
                                    ),
                                    child: DotsFilterChip(
                                      label: selectedItems![i].name,
                                      onTap: () => onBtnChipTap?.call(selectedItems![i].id),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(
                        key: ValueKey('noChips'),
                      ),
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
  final double? imageWidth;

  const _Body({
    this.listTitle,
    this.listItems,
    this.isEmptySearch = false,
    this.emptyListTitle,
    this.emptyListDescription,
    this.emptyListIconData,
    this.emptyListImage,
    this.scrollController,
    this.imageWidth,
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
                    imageWidth: imageWidth,
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
                  if (listTitle != null && listTitle!.isNotEmpty) ...[
                    Text(
                      listTitle ?? '',
                      style: theme.typo.main.labelDefaultBold.copyWith(
                        color: theme.colors.textTertiary,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 12),
                  ],
                  for (final item in listItems!)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: DotsListsItem(
                        label: item.label,
                        iconData: item.iconData,
                        picType: item.picType,
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
  final bool enabled;

  const _Footer({
    super.key,
    required this.variant,
    required this.mainButtonText,
    required this.onMainButtonTap,
    this.mainButtonIcon = DotsIconData.add,
    this.enabled = true,
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
                enabled: enabled,
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

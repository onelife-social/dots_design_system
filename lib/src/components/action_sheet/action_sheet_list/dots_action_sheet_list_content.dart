import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheetListContent extends StatelessWidget {
  final ActionSheetListVariant variant;
  final String title;
  final String? description;
  final Function()? onBackButtonTap;
  final Function()? onCloseButtonTap;
  final Function()? onLabelButtonTap;
  final String? labelButtonText;
  final Function() onMainButtonTap;
  final String? mainButtonText;
  final DotsIconData mainButtonIcon;
  final DotsIconData inputIcon;
  final String? hintInputText;
  final ValueChanged<String>? onInputChanged;
  final List<SelectedItem>? selectedItemNames;
  final Function(int)? onBtnChipTap;
  final bool isScrolled;
  final bool isLabelButtonAvailable;
  final bool isMainButtonAvailable;
  final bool searchBtnHide;
  final DotsIconData searchBtnIcon;
  final Function()? onSearchBtnTap;
  final String? listTitle;
  final List<DotsListItemModel>? listItems;
  final Map<String, List<DotsListItemModel>>? groupedListItems;
  final bool isEmptySearch;
  final String? emptyListTitle;
  final String? emptyListDescription;
  final DotsIconData? emptyListIconData;
  final ImageProvider? emptyListImage;
  final double? emptyImageWidth;
  final ScrollController? scrollController;
  final TextEditingController? textFieldController;
  final FocusNode? focus;
  final VoidCallback? onTapTextFieldBtn;

  const DotsActionSheetListContent({
    super.key,
    this.variant = ActionSheetListVariant.main,
    required this.title,
    required this.onMainButtonTap,
    required this.mainButtonText,
    this.description,
    this.textFieldController,
    this.focus,
    this.onTapTextFieldBtn,
    this.mainButtonIcon = DotsIconData.add,
    this.onLabelButtonTap,
    this.labelButtonText,
    this.onBackButtonTap,
    this.onCloseButtonTap,
    this.inputIcon = DotsIconData.search,
    this.hintInputText,
    this.onInputChanged,
    this.selectedItemNames,
    this.onBtnChipTap,
    this.isScrolled = false,
    this.isLabelButtonAvailable = false,
    this.isMainButtonAvailable = false,
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
    this.groupedListItems,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return ClipRRect(
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
                    groupedListItems: groupedListItems,
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
            enabled: isMainButtonAvailable,
          ),
        ],
      ),
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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 16,
                  bottom: description != null ? 4 : context.getByRatio(16, 10),
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        if (onBackButtonTap != null)
                          Container(
                            width: 80,
                            alignment: Alignment.centerLeft,
                            child: DotsIconButton(
                              icon: DotsIconData.chevronLeft,
                              size: DotsIconButtonSize.medium,
                              variant: DotsIconButtonVariant.noBackground,
                              onTap: onBackButtonTap,
                            ),
                          )
                        else
                          const SizedBox(
                            width: 80,
                          ),
                        Expanded(
                          child: Text(
                            title,
                            style: theme.typo.secondary.title02H6,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        (onLabelButtonTap != null && (variant.isGhost || onCloseButtonTap == null))
                            ? SizedBox(
                                width: 80,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Spacer(),
                                    Container(
                                      constraints: BoxConstraints(maxWidth: 80),
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
                              )
                            : const SizedBox(
                                width: 80,
                              ),
                      ],
                    ),
                    if (description != null)
                      Padding(
                        padding: EdgeInsets.only(
                          left: 32,
                          right: 32,
                          bottom: context.getByRatio(16, 10),
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          description ?? '',
                          style: theme.typo.main.bodyDefaultRegular.copyWith(
                            color: theme.colors.textQuarternary,
                          ),
                        ),
                      ),
                  ],
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
                          child: DotsTextFieldButton(
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
          if (!variant.isGhost && onCloseButtonTap != null)
            Positioned(
              top: 0,
              right: 16,
              child: DotsCloseButton(
                icon: DotsIconData.cross,
                size: DotsCloseButtonSize.medium,
                variant: DotsCloseButtonVariant.softContrast,
                addBlur: false,
                onTap: onCloseButtonTap,
              ),
            ),
        ],
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
  final Map<String, List<DotsListItemModel>>? groupedListItems;

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
    this.groupedListItems,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    if ((listItems == null || listItems!.isEmpty) &&
        (groupedListItems == null || groupedListItems!.isEmpty)) {
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
    } else if (listItems != null && listItems!.isNotEmpty) {
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
    } else if (groupedListItems != null && groupedListItems!.isNotEmpty) {
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
                  for (final entry in groupedListItems!.entries) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: theme.colors.labelSecondary.dotsWithOpacity(0.1),
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                entry.key,
                                style: theme.typo.main.labelSmallMedium.copyWith(
                                  color: theme.colors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    for (final item in entry.value)
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
                ],
              ),
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class _Footer extends StatelessWidget {
  final ActionSheetListVariant variant;
  final String? mainButtonText;
  final Function() onMainButtonTap;
  final DotsIconData mainButtonIcon;
  final bool enabled;

  const _Footer({
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
        child: mainButtonText == null
            ? Offstage()
            : variant.isMain
            ? DotsMainButton(
                content: mainButtonText!,
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

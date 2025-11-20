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
  final String? mainButtonText;

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

  /// The [groupedListItems] is a map of items to be displayed in the action sheet.
  /// Each item is a [DotsListItemModel] widget.
  final Map<String, List<DotsListItemModel>>? groupedListItems;

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
    this.groupedListItems,
  });

  @override
  Widget build(BuildContext context) {
    return DotsActionSheetContainer(
      bottomPosition: bottomPosition,
      horizontalPadding: 16,
      maxHeight: context.getByRatio(657, 480),
      showBlurBackground: showBlurBackground,
      onClose: onClose,
      applyHorizontalPadding: false,
      containerPadding: EdgeInsets.zero,
      child: DotsActionSheetListContent(
        variant: variant,
        title: title,
        description: description,
        onBackButtonTap: onBackButtonTap,
        onCloseButtonTap: onCloseButtonTap,
        onLabelButtonTap: onLabelButtonTap,
        labelButtonText: labelButtonText,
        onMainButtonTap: onMainButtonTap,
        mainButtonText: mainButtonText,
        mainButtonIcon: mainButtonIcon,
        inputIcon: inputIcon,
        hintInputText: hintInputText,
        onInputChanged: onInputChanged,
        selectedItemNames: selectedItemNames,
        onBtnChipTap: onBtnChipTap,
        isScrolled: isScrolled,
        isLabelButtonAvailable: isLabelButtonAvailable,
        searchBtnHide: searchBtnHide,
        searchBtnIcon: searchBtnIcon,
        onSearchBtnTap: onSearchBtnTap,
        listTitle: listTitle,
        listItems: listItems,
        groupedListItems: groupedListItems,
        isEmptySearch: isEmptySearch,
        emptyListTitle: emptyListTitle,
        emptyListDescription: emptyListDescription,
        emptyListIconData: emptyListIconData,
        emptyListImage: emptyListImage,
        emptyImageWidth: emptyImageWidth,
        scrollController: scrollController,
        textFieldController: textFieldController,
        focus: focus,
        onTapTextFieldBtn: onTapTextFieldBtn,
      ),
    );
  }
}

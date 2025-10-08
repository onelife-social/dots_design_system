import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class FolderCarrousel extends StatelessWidget {
  /// Array of button data to build buttons automatically with a [BtnFolder] widget
  final List<BtnFolderData> buttonsData;

  /// List of widgets to render directly inside the folder carrousel which override ButtonsData
  final List<DefaultFolderWidget>? customWidgets;

  // Variable to determine if the edit icon should be shown.
  final bool showEditIcon;

  /// Optional scroll controller for the carrousel
  final ScrollController? controller;

  const FolderCarrousel({
    super.key,
    required this.buttonsData,
    required this.showEditIcon,
    this.customWidgets,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      for (int i = 0; i < buttonsData.length; i++)
        BtnFolder(
          icon: buttonsData[i].icon,
          text: buttonsData[i].text,
          onTap: buttonsData[i].onTap,
          onLongPress: buttonsData[i].onPressed,
          isSelected: buttonsData[i].isSelected,
          iconSelectedColor: buttonsData[i].iconSelectedColor,
          isEditable: buttonsData[i].isEditable,
          showEditIcon: showEditIcon,
        ),
    ];

    if (customWidgets != null) {
      for (final custom in customWidgets!) {
        final index = custom.index == -1 ? children.length : custom.index.clamp(0, children.length);

        children.insert(index, custom.widget);
      }
    }

    final List<Widget> spacedChildren = [];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i != children.length - 1) {
        spacedChildren.add(const SizedBox(width: 6));
      }
    }

    return SingleChildScrollView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      child: Row(children: spacedChildren),
    );
  }
}

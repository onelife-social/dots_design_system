import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class FolderCarrousel extends StatelessWidget {
  /// Array of button data to build buttons automatically with a [BtnFolder] widget
  final List<BtnFolderData> buttonsData;

  /// List of widgets to render directly inside the folder carrousel which override ButtonsData
  final List<Widget>? customWidgets;

  // Variable to determine if the edit icon should be shown.
  final bool showEditIcon;

  const FolderCarrousel(
      {super.key, required this.buttonsData, required this.showEditIcon, this.customWidgets});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 6,
          children: customWidgets ??
              [
                for (int i = 0; i < buttonsData.length; i++) ...[
                  BtnFolder(
                    icon: buttonsData[i].icon,
                    text: buttonsData[i].text,
                    onPressed: buttonsData[i].onPressed,
                    isSelected: buttonsData[i].isSelected,
                    iconSelectedColor: buttonsData[i].iconSelectedColor,
                    isEditable: buttonsData[i].isEditable,
                    showEditIcon: showEditIcon,
                  ),
                ],
              ],
        ),
      ),
    );
  }
}

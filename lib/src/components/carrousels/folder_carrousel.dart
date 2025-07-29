import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class FolderCarrousel extends StatelessWidget {
  final List<BtnFolderData> buttonsData;

  // Variable to determine if the edit icon should be shown.
  final bool showEditIcon;

  const FolderCarrousel({
    super.key,
    required this.buttonsData,
    required this.showEditIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
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
              if (i != buttonsData.length - 1) const SizedBox(width: 6),
            ],
          ],
        ),
      ),
    );
  }
}

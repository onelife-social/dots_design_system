import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class BtnFolderDemoPage extends StatefulWidget {
  final String text;
  final Color? iconColor;
  final DotsIcon icon;
  final bool showEditIcon;
  final bool isEditable;

  const BtnFolderDemoPage({
    super.key,
    required this.text,
    required this.iconColor,
    required this.icon,
    required this.showEditIcon,
    required this.isEditable,
  });

  @override
  State<BtnFolderDemoPage> createState() => _BtnFolderDemoPageState();
}

class _BtnFolderDemoPageState extends State<BtnFolderDemoPage> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
          child: BtnFolder(
            icon: widget.icon.iconData,
            text: widget.text,
            onPressed: () {
              setState(() {
                isSelected = !isSelected;
              });
            },
            isSelected: isSelected,
            iconSelectedColor: widget.iconColor ?? DotsColors.light.gradientInitialLinealPurple,
            showEditIcon: widget.showEditIcon,
            isEditable: widget.isEditable,
          ),
        ),
      ],
    );
  }
}

import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';


class DotsFloatingButton extends StatelessWidget {
  const DotsFloatingButton({
    super.key,
    required this.content,
    this.icon,
    this.onTap,
    this.blur = true,
  });

  /// The text to display on the button.
  final String content;

  /// The icon to display on the button.
  ///
  /// If not provided, no icon will be displayed.
  final DotsIconData? icon;

  /// Callback when the button is tapped.
  final Function()? onTap;
  
  /// Whether to apply a blur effect to the button background.
  final bool blur;

  

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
   
    final borderRadius = BorderRadius.circular(36);

    final button = Material(
      color: theme.colors.bgSecondaryBtn,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap != null ? () => onTap!() : null,
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: const Color(0x3F000000),
                blurRadius: 15,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          height: 36,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                DotsIcon(
                  iconData: icon ?? DotsIconData.values.first,
                  size: 20,
                  color: theme.colors.labelAlwaysWhite,
                ),
              Flexible(
                child: Text(
                  content,
                  overflow: TextOverflow.ellipsis,
                  style: theme.typo.main.labelDefaultBold.copyWith(
                        color: theme.colors.labelAlwaysWhite,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (blur) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: theme.colors.labelAlwaysWhite.withOpacity(0.5),
            child: button,
          ),
        ),
      );
    }
    return button;
  }
}

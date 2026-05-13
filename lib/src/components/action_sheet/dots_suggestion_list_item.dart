import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsSuggestionListItem extends StatelessWidget {
  // Variant of the suggestion list item
  final DotsSuggestionListItemVariant type;

  // Icon shown to the left of the tile
  final Widget icon;

  // Main text shown on the tile
  final String? text;

  // Subtext shown below the main text on the tile
  final String? subtext;

  // Function triggered when tile is tapped
  final Function()? onTap;

  // Background color of the suggestion list item
  final Color? backgroundColor;

  // Background color of the icon container
  final Color? backgroundIconColor;

  const DotsSuggestionListItem({
    super.key,
    required this.icon,
    this.text,
    this.subtext,
    this.onTap,
    this.type = DotsSuggestionListItemVariant.main,
    this.backgroundColor,
    this.backgroundIconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor 
            ?? (type.isMain
                  ? theme.colors.transparent
                  : theme.colors.bgContainerSecondaryOnBackground
                ),
          borderRadius: DotsBorderRadius.r16,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Row(
            spacing: 12,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: backgroundIconColor 
                    ?? (type.isMain
                          ? theme.colors.bgContainerSecondaryOnBackground
                          : theme.colors.transparent
                        ),
                  borderRadius: DotsBorderRadius.r12,
                ),
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: DotsBorderRadius.r12,
                  child: Center(
                    child: icon
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (text != null && text!.isNotEmpty)
                      Text(
                        text!,
                        style: theme.typo.main.bodyLargeMedium.copyWith(
                          color: theme.colors.textPrimary,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    if (subtext != null && subtext!.isNotEmpty)
                      Text(
                        subtext!,
                        style: theme.typo.main.bodyDefaultRegular.copyWith(
                          color: theme.colors.textTertiary,
                        ),
                        textAlign: TextAlign.left,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DotsSuggestionListItemVariant {
  main,
  background;

  bool get isMain => this == DotsSuggestionListItemVariant.main;
  bool get isBackground => this == DotsSuggestionListItemVariant.background;
}

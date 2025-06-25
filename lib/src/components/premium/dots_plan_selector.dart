import 'package:dots_design_system/dots_design_system.dart';
import 'package:dots_design_system/src/core/images_paths.dart';
import 'package:flutter/material.dart';

enum DotsPlanSelectorVariant {
  basic,
  premium,
  premiumPlus,
}

class DotsPlanSelector extends StatelessWidget {
  const DotsPlanSelector({
    super.key,
    required this.title,
    required this.description,
    required this.variant,
    required this.selected,
    this.onTap,
  });
  final String title;
  final String description;
  final DotsPlanSelectorVariant variant;
  final bool selected;
  final Function()? onTap;

  String get imagePath {
    switch (variant) {
      case DotsPlanSelectorVariant.basic:
        return ImagesPaths.bgBasic;
      case DotsPlanSelectorVariant.premium:
        return ImagesPaths.bgPremium;
      case DotsPlanSelectorVariant.premiumPlus:
        return ImagesPaths.bgPremiumPlus;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final textColor = selected ? theme.colors.labelAlwaysWhite : theme.colors.textPrimary;
    return Material(
      color: theme.colors.bgContainerSecondaryOnBackground,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: selected ? DecorationImage(image: AssetImage(imagePath)) : null,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            width: 114,
            height: 80,
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: theme.typo.main.bodyLargeBold.copyWith(color: textColor),
                  textAlign: TextAlign.center,
                ),
                Text(
                  description,
                  style: theme.typo.main.labelSmallRegular.copyWith(color: textColor),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

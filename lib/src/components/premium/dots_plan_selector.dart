import 'package:dots_design_system/dots_design_system.dart';
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
    this.description,
    required this.variant,
    required this.selected,
    this.onTap,
    this.enabled = true,
  });
  final String title;
  final String? description;
  final DotsPlanSelectorVariant variant;
  final bool selected;
  final bool enabled;
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

  Color getTextColor(DotsTheme theme) {
    if (enabled) {
      if (selected) {
        return theme.colors.labelAlwaysWhite;
      } else {
        return theme.colors.textPrimary;
      }
    } else {
      return theme.colors.textQuarternary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final textColor = getTextColor(theme);
    return Material(
      color: theme.colors.bgContainerSecondaryOnBackground,
      borderRadius: DotsBorderRadius.r16,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: DotsBorderRadius.r16,
          image: selected && enabled
              ? DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover)
              : null,
        ),
        child: InkWell(
          borderRadius: DotsBorderRadius.r16,
          onTap: enabled ? onTap : null,
          child: Container(
            width: double.infinity,
            height: context.screenHeight * context.getByRatio(0.095, 0.111),
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: theme.typo.main.bodyDefaultBold.copyWith(color: textColor),
                  textAlign: TextAlign.center,
                ),
                if (description?.isNotEmpty ?? false)
                  Text(
                    description ?? '',
                    style: theme.typo.main.labelSmallRegular.copyWith(color: textColor),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

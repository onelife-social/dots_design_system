import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum CreateCardVariant {
  label,
  button;

  bool get isLabel => this == CreateCardVariant.label;
  bool get isButton => this == CreateCardVariant.button;
}

class CreateCard extends StatelessWidget {
  const CreateCard({
    super.key,
    required this.title,
    this.icon,
    this.primaryColor,
    this.secondaryColor,
    this.width = 164,
    this.variant = CreateCardVariant.label,
    this.onTap,
  });

  final String title;
  final DotsIconData? icon;
  final Color? primaryColor;
  final Color? secondaryColor;
  final double width;
  final CreateCardVariant variant;
  final VoidCallback? onTap;

  static const double _height = 112;
  static const double _borderRadius = 24;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: _height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius),
          color: variant.isButton ? theme.colors.bgContainerSecondaryOnBackground : null,
          gradient: variant.isLabel && primaryColor != null
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [primaryColor!, secondaryColor ?? primaryColor!],
                )
              : null,
        ),
        child: variant.isButton
            ? _PromptCardCreateContent(title: title)
            : _PromptCardSuggestionContent(title: title, icon: icon!),
      ),
    );
  }
}

class _PromptCardSuggestionContent extends StatelessWidget {
  const _PromptCardSuggestionContent({
    required this.title,
    required this.icon,
  });

  final String title;
  final DotsIconData icon;

  static const double _iconSize = 32;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DotsIcon(
                iconData: icon,
                size: _iconSize,
              ),
              const Spacer(),
              Text(
                title,
                style: theme.typo.main.bodyLargeMedium.copyWith(
                  color: theme.colors.labelAlwaysWhite,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Positioned(
          right: 11,
          top: 11,
          child: DotsIconButton(
            icon: DotsIconData.add,
            size: DotsIconButtonSize.medium,
            backgroundColor: theme.colors.bgBtnImage.dotsWithOpacity(0.4),
            color: theme.colors.labelAlwaysWhite,
            state: DotsIconButtonState.disabled,
          ),
        ),
      ],
    );
  }
}

class _PromptCardCreateContent extends StatelessWidget {
  const _PromptCardCreateContent({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Center(
        child: DotsIconButton(
          icon: DotsIconData.add,
          size: DotsIconButtonSize.large,
          direction: DotsIconButtonDirection.column,
          backgroundColor: theme.colors.bgContainerSecondaryOnBackground,
          color: theme.colors.textPrimary,
          label: title,
          labelStyle: theme.typo.main.labelDefaultRegular.copyWith(
            color: theme.colors.textPrimary,
          ),
        ),
      ),
    );
  }
}

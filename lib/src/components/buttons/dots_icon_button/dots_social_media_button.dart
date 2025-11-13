import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

/// A button widget for social media actions with icon and label.
class DotsSocialMediaButton extends StatelessWidget {
  /// The social media variant.
  final DotsSocialMediaVariant variant;

  /// Optional label to display under the icon.
  final String? label;

  /// The size of the button.
  final DotsIconButtonSize size;

  /// Callback when the button is tapped.
  final VoidCallback? onTap;

  const DotsSocialMediaButton({
    super.key,
    required this.variant,
    this.label,
    this.size = DotsIconButtonSize.large,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: size.isExtraSmall ? 0 : 2,
        children: [
          _Image(variant: variant, size: size),
          _Label(variant: variant, size: size, label: label),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final DotsSocialMediaVariant variant;
  final DotsIconButtonSize size;

  const _Image({
    required this.variant,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final file = switch (variant) {
      DotsSocialMediaVariant.instagram => 'btn-instagram.png',
      DotsSocialMediaVariant.tiktok => 'btn-tiktok.png',
      DotsSocialMediaVariant.whatsapp => 'btn-whatsapp.png',
    };

    return Image.asset(
      'packages/dots_design_system/assets/social_media/$file',
      height: size.size,
      width: size.size,
    );
  }
}

class _Label extends StatelessWidget {
  final DotsSocialMediaVariant variant;
  final DotsIconButtonSize size;
  final String? label;

  const _Label({
    required this.variant,
    required this.size,
    required this.label,
  });

  String getLabel() {
    return label ??
        switch (variant) {
          DotsSocialMediaVariant.instagram => 'Instagram',
          DotsSocialMediaVariant.tiktok => 'TikTok',
          DotsSocialMediaVariant.whatsapp => 'WhatsApp',
        };
  }

  TextStyle getStyle(BuildContext context) {
    final theme = context.dotsTheme;
    final color = theme.colors.textPrimary;

    return switch (size) {
      DotsIconButtonSize.extraSmall => theme.typo.main.labelSmallRegular.copyWith(color: color),
      DotsIconButtonSize.small => theme.typo.main.labelDefaultRegular.copyWith(color: color),
      DotsIconButtonSize.medium => theme.typo.main.labelSmallRegular.copyWith(color: color),
      DotsIconButtonSize.large => theme.typo.main.labelDefaultRegular.copyWith(color: color),
      DotsIconButtonSize.extraLarge => theme.typo.main.labelDefaultRegular.copyWith(color: color),
      DotsIconButtonSize.enormous => theme.typo.main.bodyDefaultMedium.copyWith(color: color),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getLabel(),
      style: getStyle(context),
    );
  }
}

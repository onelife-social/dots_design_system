import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum HomeTopBarVariant {
  icons,
  button,
}

class HomeTopBarDemo extends StatelessWidget {
  const HomeTopBarDemo({
    super.key,
    required this.variant,
    required this.title,
    this.showTag = false,
    this.showImageUrl = false,

  });

  final HomeTopBarVariant variant;
  final String title;
  final bool showTag;
  
  
  final dynamic showImageUrl;

  get tag => showTag
      ? '5'
      : null;
  get imageUrl => showImageUrl ?? 'https://picsum.photos/200/300';

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    switch (variant) {
      case HomeTopBarVariant.icons:
        return DotsHomeTopBar.title(
          title: title,
          imgProfile: DotsProfilePhoto(
            imageUrl: imageUrl,
            onTap: () {},
          ),
          rightIcon: DotsIconButton(
              icon: DotsIconData.heart,
              size: DotsIconButtonSize.extraSmall,
              onTap: () {},
              color: theme.colors.textTertiary,
              variant: DotsIconButtonVariant.noBackground,
            ),
          secondRightIcon: DotsIconButton(
              icon: DotsIconData.chat,
              size: DotsIconButtonSize.extraSmall,
              tag: tag,
              color: theme.colors.textTertiary,
              onTap: () {},
              variant: DotsIconButtonVariant.noBackground,
            ),
        );
      case HomeTopBarVariant.button:
        return DotsHomeTopBar.widget(
          imgProfile: null,
          rightIcon: null,
          secondRightIcon: null,
          child: DotsMainButton(
            content: 'Button Content',
            size: DotsMainButtonSize.large,
            variant: DotsMainButtonVariant.secondary,
            expand: false,
            onTap: () {},
          ),
        );
      default:
        return DotsHomeTopBar.onlyStatusBar();
    }
  }
}

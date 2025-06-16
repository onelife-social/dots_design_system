import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum HomeTopBarVariant {
  icons,
  button,
  search;

  bool get isIcons => this == HomeTopBarVariant.icons;
  bool get isButton => this == HomeTopBarVariant.button;
  bool get isSearch => this == HomeTopBarVariant.search;
}

class HomeTopBarDemo extends StatelessWidget {
  const HomeTopBarDemo({
    super.key,
    required this.variant,
    required this.title,
    this.showTag = false,
    this.showImageUrl = false,
    this.imageUrl,
  });

  final HomeTopBarVariant variant;
  final String title;
  final bool showTag;
  final bool? showImageUrl;
  final String? imageUrl;

  String? get tag => showTag == true ? '5' : null;

  String? get demoImageUrl => showImageUrl == true ? imageUrl : null;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    switch (variant) {
      case HomeTopBarVariant.icons:
        return DotsHomeTopBar.title(
          title: title,
          imgProfile: demoImageUrl != null
              ? DotsProfilePhoto(
                  imageProvider: NetworkImage(demoImageUrl!),
                  onTap: () {},
                )
              : null,
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
        return DotsHomeTopBar.title(
          title: title,
          imgProfile: demoImageUrl != null
              ? DotsProfilePhoto(
                  imageProvider: NetworkImage(demoImageUrl!),
                  onTap: () {},
                )
              : null,
          rightIcon: DotsMainButton(
            content: 'Action',
            size: DotsMainButtonSize.small,
            variant: DotsMainButtonVariant.main,
            expand: false,
            onTap: () {},
          ),
        );
      case HomeTopBarVariant.search:
        return DotsHomeTopBar.widget(
          showGradient: true,
          imgProfile: null,
          rightIcon: null,
          secondRightIcon: null,
          child: DotsFloatingButton(
            content: 'Buscar',
            icon: DotsIconData.search,
            blur: true,
            onTap: () {},
          ),
        );
      default:
        return DotsHomeTopBar.onlyStatusBar();
    }
  }
}

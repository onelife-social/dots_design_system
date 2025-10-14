import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.imageProvider,
    required this.name,
    required this.details,
    required this.onTap,
  });

  final ImageProvider imageProvider;

  final String name;
  final String details;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DotsDecoratedBox(
        styleType: context.dotsTheme.styles.floatingBtnShadow,
        child: DotsDecoratedBox(
          styleType: context.dotsTheme.styles.squircle24,
          decoration: BoxDecoration(
            color: context.dotsTheme.colors.bgStrong,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6.5),
            width: 170,
            height: 45,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.dotsTheme.colors.bgStrong,
                  ),
                  child: ClipOval(
                    child: Image(
                      image: imageProvider,
                      width: 26,
                      height: 26,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return DotsIcon(
                          iconData: DotsIconData.user,
                          size: 16,
                          color: context.dotsTheme.colors.textPrimary,
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: context.dotsTheme.typo.main.bodyDefaultMedium.copyWith(
                          color: context.dotsTheme.colors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        details,
                        style: context.dotsTheme.typo.main.labelSmallRegular.copyWith(
                          color: context.dotsTheme.colors.textQuarternary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                DotsIcon(
                  iconData: DotsIconData.addCircle,
                  size: 20,
                  color: context.dotsTheme.colors.labelHighlight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

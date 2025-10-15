import 'package:flutter/material.dart';

import '../../../dots_design_system.dart';
import '../../core/values/paths/images_paths.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.imageProvider,
    required this.name,
    required this.details,
    required this.onTap,
  });

  // The image provider to display the profile image.
  final ImageProvider imageProvider;

  // The name of the user to display in the component.
  final String name;

  // The details to display in the component.
  final String details;

  // Callback when the component is pressed.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 45,
        width: 170,
        child: DotsDecoratedBox(
          styleType: context.dotsTheme.styles.floatingBtnShadow,
          child: DotsDecoratedBox(
            styleType: context.dotsTheme.styles.squircle24,
            decoration: BoxDecoration(
              color: context.dotsTheme.colors.bgStrong,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6.5),
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
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Image.asset(
                            ImagesPaths.defaultUserItem,
                            width: 26,
                            height: 26,
                            fit: BoxFit.cover,
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            ImagesPaths.defaultUserItem,
                            width: 26,
                            height: 26,
                            fit: BoxFit.cover,
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
      ),
    );
  }
}

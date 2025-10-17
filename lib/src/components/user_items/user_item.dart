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
    this.onError,
  });

  // The image provider to display the profile image.
  final ImageProvider imageProvider;

  // The name of the user to display in the component.
  final String name;

  // The details to display in the component.
  final String details;

  // Callback when the component is pressed.
  final VoidCallback onTap;

  // Callback for image load error.
  /// Called when the image fails to load.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  static Image defaultImage = Image.asset(
    ImagesPaths.defaultUserItem,
    width: 26,
    height: 26,
    fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    final dotsTheme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 45,
        width: 170,
        child: DotsDecoratedBox(
          styleType: dotsTheme.styles.floatingBtnShadow,
          child: DotsDecoratedBox(
            styleType: dotsTheme.styles.squircle24,
            decoration: BoxDecoration(
              color: dotsTheme.colors.bgStrong,
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
                      color: dotsTheme.colors.bgStrong,
                    ),
                    child: ClipOval(
                      child: Image(
                        image: imageProvider,
                        width: 26,
                        height: 26,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return defaultImage;
                        },
                        errorBuilder: (context, error, stackTrace) {
                          if (onError != null) onError!(error, stackTrace);
                          return defaultImage;
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
                          style: dotsTheme.typo.main.bodyDefaultMedium.copyWith(
                            color: dotsTheme.colors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          details,
                          style: dotsTheme.typo.main.labelSmallRegular.copyWith(
                            color: dotsTheme.colors.textQuarternary,
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

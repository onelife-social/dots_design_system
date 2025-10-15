import 'package:dots_design_system/src/components/user_items/user_info.dart';
import 'package:flutter/material.dart';
import '../../../dots_design_system.dart';

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
                  UserInfo(
                    imageProvider: imageProvider,
                    name: name,
                    details: details,
                    onError: onError,
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

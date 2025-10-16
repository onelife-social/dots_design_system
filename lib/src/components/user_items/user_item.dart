import 'package:dots_design_system/src/components/user_items/user_info.dart';
import 'package:flutter/material.dart';
import '../../../dots_design_system.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.data,
    required this.onTap,
  });

  /// User information data to display.
  final UserInfoData data;

  /// Callback when the component is pressed.
  final VoidCallback onTap;

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
                  UserInfo(data: data),
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

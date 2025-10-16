import 'package:flutter/material.dart';
import '../../../dots_design_system.dart';
import '../../core/values/paths/images_paths.dart';

class UserInfoData {
  /// The image provider to display the profile image.
  final ImageProvider? imageProvider;

  /// The name of the user to display in the component.
  final String name;

  /// The details to display in the component.
  final String? details;

  /// Callback for image load error.
  final void Function(Object exception, StackTrace? stackTrace)? imageOnError;

  const UserInfoData({
    this.imageProvider,
    required this.name,
    this.details,
    this.imageOnError,
  });
}

class UserInfo extends StatelessWidget {
  /// User information data to display.
  final UserInfoData data;

  const UserInfo({
    super.key,
    required this.data,
  });

  static Image defaultImage = Image.asset(
    ImagesPaths.defaultUserItem,
    width: 26,
    height: 26,
    fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    final dotsTheme = context.dotsTheme;

    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          if (data.imageProvider != null)
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dotsTheme.colors.bgStrong,
              ),
              child: ClipOval(
                child: Image(
                  image: data.imageProvider!,
                  width: 26,
                  height: 26,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return defaultImage;
                  },
                  errorBuilder: (context, error, stackTrace) {
                    if (data.imageOnError != null) data.imageOnError!(error, stackTrace);
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
                  data.name,
                  style: dotsTheme.typo.main.bodyDefaultMedium.copyWith(
                    color: dotsTheme.colors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (data.details != null)
                  Text(
                    data.details!,
                    style: dotsTheme.typo.main.labelSmallRegular.copyWith(
                      color: dotsTheme.colors.textQuarternary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

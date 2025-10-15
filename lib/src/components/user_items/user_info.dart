import 'package:flutter/material.dart';
import '../../../dots_design_system.dart';
import '../../core/values/paths/images_paths.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.imageProvider,
    required this.name,
    required this.details,
    this.onError,
  });

  final ImageProvider imageProvider;
  final String name;
  final String details;
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

    return Expanded(
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
        ],
      ),
    );
  }
}

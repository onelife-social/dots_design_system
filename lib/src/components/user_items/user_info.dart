import 'package:flutter/material.dart';
import '../../../dots_design_system.dart';
import '../../core/values/paths/images_paths.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
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
            )
          else if (data.aliasLabelImageText != null)
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dotsTheme.colors.bgContainerSecondaryOnBackground,
              ),
              child: Center(
                child: Text(
                  data.aliasLabelImageText!,
                  style: dotsTheme.typo.number.numBodyDefaultMedium.copyWith(
                    color: dotsTheme.colors.textTertiary,
                  ),
                ),
              ),
            ),
          Expanded(
            child: data.details == null || data.details!.isEmpty
                ? Container(
                    constraints: const BoxConstraints(minHeight: 26),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data.name,
                      style: dotsTheme.typo.main.bodyDefaultMedium.copyWith(
                        color: dotsTheme.colors.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : Column(
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

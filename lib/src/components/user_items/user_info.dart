import 'package:flutter/material.dart';
import '../../../dots_design_system.dart';

class UserInfoTheme {
  final TextStyle nameStyle;
  final TextStyle detailsStyle;
  final TextStyle aliasLabelImageStyle;

  const UserInfoTheme({
    required this.nameStyle,
    required this.detailsStyle,
    required this.aliasLabelImageStyle,
  });
}

UserInfoTheme getUserInfoThemeBySize(DotsTheme theme, UserInfoSize size) {
  switch (size) {
    case UserInfoSize.small:
      return UserInfoTheme(
        nameStyle: theme.typo.main.bodyDefaultMedium,
        detailsStyle: theme.typo.main.labelSmallRegular,
        aliasLabelImageStyle: theme.typo.number.numBodyDefaultMedium,
      );
    case UserInfoSize.large:
      return UserInfoTheme(
        nameStyle: theme.typo.main.bodyLargeMedium,
        detailsStyle: theme.typo.main.labelDefaultRegular,
        aliasLabelImageStyle: theme.typo.number.numTitleH5Medium,
      );
  }
}

class UserInfo extends StatelessWidget {
  /// User information data to display.
  final UserInfoData data;
  final UserInfoSize size;

  const UserInfo({super.key, required this.data, this.size = UserInfoSize.small});

  Image get defaultImage => Image.asset(
    ImagesPaths.defaultUserItem,
    width: size.imageSize,
    height: size.imageSize,
    fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    final dotsTheme = context.dotsTheme;
    final styles = getUserInfoThemeBySize(dotsTheme, size);

    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          if (data.imageProvider != null)
            Container(
              width: size.imageSize,
              height: size.imageSize,
              decoration: BoxDecoration(shape: BoxShape.circle, color: dotsTheme.colors.bgStrong),
              child: ClipOval(
                child: Image(
                  image: data.imageProvider!,
                  width: size.imageSize,
                  height: size.imageSize,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return defaultImage;
                  },
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded || frame != null) {
                      return child;
                    }
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
              width: size.imageSize,
              height: size.imageSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dotsTheme.colors.bgContainerSecondaryOnBackground,
              ),
              child: Center(
                child: Text(
                  data.aliasLabelImageText!,
                  style: styles.aliasLabelImageStyle.copyWith(color: dotsTheme.colors.textTertiary),
                ),
              ),
            ),
          Expanded(
            child: data.details == null || data.details!.isEmpty
                ? Container(
                    constraints: BoxConstraints(minHeight: size.imageSize),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data.name,
                      style: styles.nameStyle.copyWith(color: dotsTheme.colors.textPrimary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.name,
                        style: styles.nameStyle.copyWith(color: dotsTheme.colors.textPrimary),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        data.details!,
                        style: styles.detailsStyle.copyWith(
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

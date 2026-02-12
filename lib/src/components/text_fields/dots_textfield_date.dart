import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsTextFieldDate extends StatelessWidget {
  /// The icon data for the TextField.
  ///
  /// If null, no icon will be displayed.
  final DotsIconData? iconData;

  /// The text to display in the widget.
  final String? label;

  /// The date to display in the widget.
  final String date;

  /// The time to display in the widget.
  final String? time;

  /// Callback when the text in the TextField changes.
  final VoidCallback onTap;

  /// Whether the widget is in an error state.
  final bool isError;

  /// Text displayed as error.
  final String? errorText;

  /// Whether to display a background color.
  ///
  /// Defaults to `true`.
  final bool background;

  const DotsTextFieldDate({
    super.key,
    this.iconData,
    this.label,
    required this.date,
    this.time,
    required this.onTap,
    this.isError = false,
    this.errorText,
    this.background = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    Widget buildTextWidget(String? text) {
      if (text?.isEmpty == true) return Offstage();

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          constraints: const BoxConstraints(/* minHeight: 28, */ minWidth: 56),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: theme.colors.bgSecondaryBtn,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            text!,
            style: theme.typo.main.bodyDefaultMedium.copyWith(
              color: isError ? theme.colors.labelDestructive : theme.colors.textPrimary,
            ),
          ),
        ),
      );

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
            decoration: BoxDecoration(
              color: theme.colors.bgSecondaryBtn,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              text!,
              style: theme.typo.main.bodyDefaultMedium.copyWith(
                color: isError ? theme.colors.labelDestructive : theme.colors.textPrimary,
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 44,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: background ? theme.colors.bgContainerSecondaryOnBackground : null,
              shape: RoundedRectangleBorder(borderRadius: DotsBorderRadius.r1000),
            ),
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (iconData != null) ...[
                        DotsIcon(
                          iconData: iconData!,
                          color: theme.colors.textSecondary,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                      ],
                      if (label?.isNotEmpty == true)
                        Text(
                          label!,
                          style: theme.typo.main.bodyDefaultRegular.copyWith(
                            color: theme.colors.textPrimary,
                          ),
                        ),
                      const Spacer(),
                      Row(
                        spacing: 4,
                        children: [
                          const SizedBox(width: 12),
                          buildTextWidget(date),
                          buildTextWidget(time),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (background && isError && errorText?.isNotEmpty == true) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    errorText!,
                    style: theme.typo.main.labelDefaultRegular.copyWith(
                      color: theme.colors.labelDestructive,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

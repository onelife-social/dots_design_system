import 'package:dots_design_system/dots_design_system.dart';
import 'package:dots_design_system/src/components/common/dots_shader_mask.dart';
import 'package:dots_design_system/src/components/tag/tags_lib.dart';
import 'package:flutter/material.dart';

import 'dots_tag_theme.dart';

class DotsTag extends StatelessWidget {
  const DotsTag({
    super.key,
    required this.content,
    this.size = DotsTagSize.medium,
    this.variant = DotsTagVariant.main,
  });

  /// The text to display on the tag.
  final String content;

  /// The size of the tag.
  ///
  /// Defaults to [DotsTagSize.medium].
  final DotsTagSize size;

  /// The visual variant of the tag.
  ///
  /// Defaults to [DotsTagVariant.main].
  final DotsTagVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final tagTheme = getTagThemeByTagVariant(theme, variant);
    final borderRadius = BorderRadius.circular(size.height);

    final foregroundColor =
        tagTheme.foregroundGradient == null ? tagTheme.foregroundColor : Colors.white;
    Widget tag = Material(
      color: tagTheme.backgroundColor ?? Colors.transparent,
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(borderRadius: borderRadius),
        height: size.height,
        padding: size.padding,
        child: DotsShaderMask(
          styleType: tagTheme.foregroundGradient,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  content,
                  overflow: TextOverflow.ellipsis,
                  style: size.getTextStyle(theme).copyWith(
                        color: foregroundColor,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (tagTheme.backgroundGradient != null) {
      tag = DotsDecoratedBox(
        styleType: tagTheme.backgroundGradient,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
        ),
        child: tag,
      );
    }
    if (tagTheme.blur) {
      tag = DotsDecoratedBox(
        styleType: theme.styles.bgBlur,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
        ),
        child: tag,
      );
    }

    return tag;
  }
}

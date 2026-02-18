import 'package:flutter/material.dart';

import '../../../../dots_design_system.dart';
import '../../../../utils/utils.dart';

class DotBookTextEditor extends StatelessWidget {
  /// Variant of the text editor to determine layout and content arrangement.
  final DotBookCoverType variant;

  /// Cover color used to derive text color from theme context.
  final DotBookCoverType coverVariant;

  /// Width of the image, used to scale text size.
  final double coverImageWidth;

  /// Height of the image, used to scale text size.
  final double coverImageHeight;

  /// Color of the text, used to derive text color from theme context.
  final Color textColor;

  /// Width of the text editor, used to set its size.
  final double? width;

  /// Height of the text editor, used to set its size.
  final double? height;

  /// Title text to display.
  final String title;

  /// Subtitle text to display.
  final String? subtitle;

  /// Extra information text to display (only for printedSquare variant).
  final String? xtraInfo;

  /// Callback when the editor is tapped.
  final Function()? onTap;

  const DotBookTextEditor({
    super.key,
    this.width,
    this.height,
    this.variant = DotBookCoverType.printedSquare,
    required this.coverImageWidth,
    required this.coverImageHeight,
    required this.coverVariant,
    required this.textColor,
    required this.title,
    this.subtitle,
    this.xtraInfo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: variant == DotBookCoverType.printedSquare
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (xtraInfo != null) ...[
                        Text(
                          xtraInfo!,
                          style: theme.typo.secondary.title02H1.copyWith(
                            color: textColor,
                            fontSize: DotsTextUtils.scaledFontSize(
                              referenceFontSize: 6.8,
                              imageWidth: coverImageWidth,
                              referenceWidth: kCoverImageWidth,
                            ),
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                        ),
                        const SizedBox(width: 12),
                      ],
                      if (subtitle != null)
                        Expanded(
                          child: Text(
                            subtitle!,
                            style: theme.typo.secondary.title02H1.copyWith(
                              color: textColor,
                              fontSize: DotsTextUtils.scaledFontSize(
                                referenceFontSize: 6,
                                imageWidth: coverImageWidth,
                                referenceWidth: kCoverImageWidth,
                              ),
                            ),
                            textAlign: TextAlign.right,
                            maxLines: 1,
                          ),
                        ),
                    ],
                  ),
                  const Spacer(),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      style: theme.typo.secondary.title02H1.copyWith(
                        color: textColor,
                        fontSize: DotsTextUtils.scaledFontSize(
                          referenceFontSize: 70,
                          imageWidth: coverImageWidth,
                          referenceWidth: kCoverImageWidth,
                        ),
                        height: 0.95,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  spacing: coverImageHeight * 0.0072,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final TextStyle titleStyle = theme.typo.secondary.title02H1.copyWith(
                          color: textColor,
                          fontSize: DotsTextUtils.scaledFontSize(
                            referenceFontSize: 14,
                            imageWidth: coverImageWidth,
                            referenceWidth: kCoverImageWidth,
                          ),
                        );
                        final String processedTitle = DotsTextUtils.hyphenateIfNeeded(
                          title,
                          titleStyle,
                          constraints.maxWidth,
                        );
                        return Text(
                          processedTitle,
                          style: titleStyle,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        );
                      },
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: theme.typo.secondary.title02H1.copyWith(
                          color: textColor,
                          fontSize: DotsTextUtils.scaledFontSize(
                            referenceFontSize: 5,
                            imageWidth: coverImageWidth,
                            referenceWidth: kCoverImageWidth,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}

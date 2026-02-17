import 'package:flutter/material.dart';

import '../../../../dots_design_system.dart';


class DotBookTextEditor extends StatelessWidget {

  /// Variant of the text editor to determine layout and content arrangement.
  final DotBookCoverType variant;

  /// Cover color used to derive text color from theme context.
  final DotBookCoverType coverVariant;

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
                          fontSize: 6.8,
                        ),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
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
                            fontSize: 6.8,
                          ),
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
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
                      fontSize: 65,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            )
          : Center(
              child: Column(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: theme.typo.secondary.title02H1.copyWith(
                      color: textColor,
                      fontSize: variant == DotBookCoverType.linen ? 15.35 : 16,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: theme.typo.secondary.title02H1.copyWith(
                        color: textColor,
                        fontSize: 5.7,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                ],
              ),
            ),
      ),
    );
	}
}
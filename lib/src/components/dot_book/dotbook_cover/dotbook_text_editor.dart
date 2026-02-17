import 'package:flutter/material.dart';

import '../../../../dots_design_system.dart';

enum DotBookTextEditorVariant {
	defaultVariant,
	printedSquare,
}

class DotBookTextEditor extends StatelessWidget {

  /// Variant of the text editor to determine layout and content arrangement.
  final DotBookTextEditorVariant variant;

  /// Cover color used to derive text color from theme context.
  final DotBookCoverType coverVariant;

  /// Color of the text, used to derive text color from theme context.
  final DotBookCoverColor color;

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
		this.variant = DotBookTextEditorVariant.defaultVariant,
    required this.coverVariant,
    required this.color,
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
        child: variant == DotBookTextEditorVariant.printedSquare
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (xtraInfo != null)
                      Text(
                        xtraInfo!,
                        style: theme.typo.main.bodyDefaultBold.copyWith(
                          color: color.textColor(context, coverVariant),
                        ),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: theme.typo.main.bodyDefaultBold.copyWith(
                          color: color.textColor(context, coverVariant),
                        ),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                  ],
                ),
                const Spacer(),
                Text(
                  title,
                  style: theme.typo.main.bodyDefaultBold.copyWith(
                    color: color.textColor(context, coverVariant),
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
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
                    style: theme.typo.main.bodyDefaultBold.copyWith(
                      color: color.textColor(context, coverVariant),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: theme.typo.main.bodyDefaultBold.copyWith(
                        color: color.textColor(context, coverVariant),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    )
                ],
              ),
            ),
      ),
    );
	}
}
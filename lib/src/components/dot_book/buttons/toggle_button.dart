import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotBookToggleButton extends StatelessWidget {
	/// Main title text displayed on top.
	final String title;

	/// Secondary text displayed below the title.
	final String? subtitle;

	/// Whether the button is selected.
	final bool isSelected;

	/// Callback when the button is tapped.
	final Function()? onTap;

	const DotBookToggleButton({
		super.key,
		required this.title,
		this.subtitle,
		this.isSelected = false,
		this.onTap,
	});

	@override
	Widget build(BuildContext context) {
		final theme = context.dotsTheme;

		final BoxDecoration decoration = BoxDecoration(
			color: isSelected
          ? theme.colors.bgHighlight.dotsWithOpacity(0.2)
          : theme.colors.bgContainerSecondary,
			borderRadius: DotsBorderRadius.r16,
			border: isSelected
					? Border.all(
							color: theme.colors.labelHighlight,
							width: 1,
						)
					: null,
		);

		return SizedBox(
			width: double.infinity,
			child: Material(
				color: Colors.transparent,
				borderRadius: DotsBorderRadius.r16,
				child: InkWell(
					onTap: onTap,
					borderRadius: DotsBorderRadius.r16,
					child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
						decoration: decoration,
						alignment: Alignment.center,
						child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: theme.typo.main.bodyLargeMedium.copyWith(
                    color: isSelected ? theme.colors.textPrimary : theme.colors.textQuarternary,
                  ),
                ),
                const SizedBox(height: 2),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: theme.typo.main.labelDefaultRegular.copyWith(
                      color: theme.colors.textQuarternary,
                    ),
                  ),
              ],
            ),
					),
				),
			),
		);
	}
}

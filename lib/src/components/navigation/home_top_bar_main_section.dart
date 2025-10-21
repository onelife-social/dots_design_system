import 'package:flutter/material.dart';
import 'package:dots_design_system/dots_design_system.dart';

class DotsHomeTopBarMainSection extends StatelessWidget {

  /// Title of the top bar.
  final String? title;

  /// Callback when the title is tapped.
  final Function()? onTitleTap;

  /// Custom widget to display in the top bar.
  final Widget? child;

  /// Icon button on the left side of the top bar that displays the user's profile picture.
  final Widget? imgProfile;

  /// Icon button on the right side of the top bar.
  final Widget? rightIcon;

  /// Second icon button on the right side of the top bar.
  final Widget? secondRightIcon;

  const DotsHomeTopBarMainSection({
    super.key,
    this.title,
    this.onTitleTap,
    this.child,
    this.imgProfile,
    this.rightIcon,
    this.secondRightIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: child ??
                (title != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: onTitleTap,
                            child: Text(
                              title!,
                              style: theme.typo.main.labelDefaultBold.copyWith(
                                color: theme.colors.textTertiary,
                              ),
                            ),
                          ),
                        ],
                      )
                    : null),
          ),
        ),
        Positioned.fill(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (imgProfile != null) ...[
                const SizedBox(width: 16),
                imgProfile!,
              ],
              const Spacer(),
              if (rightIcon != null) rightIcon!,
              if (secondRightIcon != null) ...[
                secondRightIcon!,
                const SizedBox(width: 16),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsSelectorRadioButton extends StatelessWidget {
  final bool isSelected;
  final String title;
  final DotsIconData icon1;
  final double icon1Size;
  final String details1;
  final DotsIconData icon2;
  final double icon2Size;
  final String details2;
  final Function()? onTap;

  const DotsSelectorRadioButton({
    super.key,
    required this.isSelected,
    required this.title,
    this.icon1 = DotsIconData.clockFilled,
    this.icon2 = DotsIconData.calendar,
    this.icon1Size = 16,
    this.icon2Size = 16,
    required this.details1,
    required this.details2,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    BoxDecoration decoration = BoxDecoration(
      color: theme.colors.bgContainerSecondary,
      borderRadius: DotsBorderRadius.r24,
    );
    if (isSelected) {
      decoration = decoration.copyWith(
        border: Border.all(
            color: theme.colors.labelHighlight,
            width: 1.5,
            strokeAlign: BorderSide.strokeAlignOutside),
        borderRadius: DotsBorderRadius.r26,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 94,
        width: double.infinity,
        margin: EdgeInsets.all(1.5),
        padding: const EdgeInsets.all(16),
        decoration: decoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: theme.typo.main.bodyDefaultBold
                          .copyWith(color: theme.colors.textPrimary)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DotsIcon(
                        iconData: icon1,
                        size: icon1Size,
                        color: theme.colors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(details1,
                          style: theme.typo.main.labelDefaultRegular
                              .copyWith(color: theme.colors.textTertiary)),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DotsIcon(
                        iconData: icon2,
                        size: icon2Size,
                        color: theme.colors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(details2,
                          style: theme.typo.main.labelDefaultRegular
                              .copyWith(color: theme.colors.textTertiary)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            DotsRadioButton(
              isSelected: isSelected,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsSelectorRadioButtonLabel extends StatelessWidget {
  final bool isSelected;
  final String title;
  final String tagText;

  final String details1;
  final String details2;
  final bool free;
  final Function()? onTap;

  const DotsSelectorRadioButtonLabel({
    super.key,
    required this.isSelected,
    required this.title,
    required this.details1,
    required this.details2,
    required this.tagText,
    required this.free,
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
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 8,
                children: [
                  DotsTag(
                    content: tagText,
                    variant: free ? DotsTagVariant.main : DotsTagVariant.premiumPlus,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.typo.secondary.title02H6
                            .copyWith(color: theme.colors.textPrimary),
                      ),
                      Text(details1,
                          style: theme.typo.main.bodyDefaultMedium
                              .copyWith(color: theme.colors.textTertiary)),
                    ],
                  ),
                  Text(details2,
                      style: theme.typo.main.labelDefaultRegular
                          .copyWith(color: theme.colors.textTertiary)),
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

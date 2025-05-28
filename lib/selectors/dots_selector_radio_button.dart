import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DotsSelectorRadioButton extends StatelessWidget {
  final bool isSelected;
  final String title;
  final SvgPicture icon1;
  final String details1;
  final SvgPicture icon2;
  final String details2;
  final Function()? onTap;

  const DotsSelectorRadioButton({
    super.key,
    required this.isSelected,
    required this.title,
    required this.icon1,
    required this.icon2,
    required this.details1,
    required this.details2,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                border: Border.all(color: theme.colors.labelHighlight, width: 1.5),
                borderRadius: BorderRadius.circular(26),
              )
            : null,
        child: Container(
          height: 94,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: theme.colors.bgContainerSecondary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text(title,
                        style: theme.typo.main.bodyDefaultBold
                            .copyWith(color: theme.colors.textPrimary)),
                    Row(
                      spacing: 4,
                      children: [
                        icon1,
                        Text(details1,
                            style: theme.typo.main.labelDefaultRegular
                                .copyWith(color: theme.colors.textTertiary)),
                      ],
                    ),
                    Row(
                      spacing: 4,
                      children: [
                        icon2,
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
      ),
    );
  }
}

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsStyleTextDemo extends StatelessWidget {
  const DotsStyleTextDemo({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          spacing: 32,
          children: [
            DotsStyleText(
              styleType: theme.styles.textPremium,
              text: 'Color Dodge Effect on textPremium',
              style: theme.typo.main.bodyDefaultMedium,
            ),
            DotsStyleText(
              styleType: theme.styles.textPremiumPlus,
              text: 'Color Dodge Effect on textPremiumPlus',
              style: theme.typo.main.bodyDefaultMedium,
            ),
            DotsStyleText(
              styleType: theme.styles.bgBasic,
              text: 'Color Dodge Effect on bgBasic',
              style: theme.typo.main.bodyDefaultMedium,
            ),
          ],
        ),
      ),
    );
  }
}

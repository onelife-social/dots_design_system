import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsDecoratedBoxDemoScreen extends StatelessWidget {
  const DotsDecoratedBoxDemoScreen({super.key, required this.radius});
  final double radius;
  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          spacing: 32,
          children: [
            DotsDecoratedBox(
              styleType: theme.styles.bgAlert,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Color Dodge Effect on bgAlert',
                  style: theme.typo.main.bodyDefaultMedium,
                ),
              ),
            ),
            DotsDecoratedBox(
              styleType: theme.styles.bgToast,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Color Dodge Effect on bgToast',
                  style: theme.typo.main.bodyDefaultMedium,
                ),
              ),
            ),
            DotsDecoratedBox(
              styleType: theme.styles.bgPremiumPlus,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Color Dodge Effect on bgPremiumPlus',
                  style: theme.typo.main.bodyDefaultMedium,
                ),
              ),
            ),
            DotsDecoratedBox(
              styleType: theme.styles.bgPremium,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Color Dodge Effect on bgPremium',
                  style: theme.typo.main.bodyDefaultMedium,
                ),
              ),
            ),
            DotsDecoratedBox(
              styleType: theme.styles.bgBasic,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Color Dodge Effect on bgBasic',
                  style: theme.typo.main.bodyDefaultMedium,
                ),
              ),
            ),
            DotsDecoratedBox(
              styleType: theme.styles.bgBlur,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Color Dodge Effect on bgBlur',
                  style: theme.typo.main.bodyDefaultMedium,
                ),
              ),
            ),
            DotsDecoratedBox(
              styleType: theme.styles.floatingBtnShadow,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Color Dodge Effect on floatingBtnShadow',
                  style: theme.typo.main.bodyDefaultMedium,
                ),
              ),
            ),
            DotsDecoratedBox(
              styleType: theme.styles.toastShadow,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Color Dodge Effect on toastShadow',
                  style: theme.typo.main.bodyDefaultMedium,
                ),
              ),
            ),
            DotsDecoratedBox(
              styleType: theme.styles.defaultShadow,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Color Dodge Effect on bgBlur',
                  style: theme.typo.main.bodyDefaultMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

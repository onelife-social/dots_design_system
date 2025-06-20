import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsDecoratedBoxDemoScreen extends StatelessWidget {
  const DotsDecoratedBoxDemoScreen(
      {super.key, required this.showSquircleClip, required this.radius});
  final bool showSquircleClip;
  final double radius;
  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          spacing: 32,
          children: [
            DotsDecoratedBox(
              styleType: theme.styles.bgAlert,
              squircleClip: showSquircleClip,
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
              squircleClip: showSquircleClip,
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
              squircleClip: showSquircleClip,
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
              squircleClip: showSquircleClip,
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
              squircleClip: showSquircleClip,
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
              squircleClip: showSquircleClip,
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

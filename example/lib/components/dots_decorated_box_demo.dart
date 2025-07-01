import 'dart:ui';

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
                  'Color Style on bgAlert',
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
                  'Color Style on bgToast',
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
                  'Color Style on bgPremiumPlus',
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
                  'Color Style on bgPremium',
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
                  'Color Style on bgBasic',
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
                  'Color Style on bgBlur',
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
                  'Color Style on floatingBtnShadow',
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
                  'Color Style on toastShadow',
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
                  'Color Style on bgBlur',
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

class BlendModeTestPage extends StatelessWidget {
  const BlendModeTestPage({super.key});

  final double blur = 5.0;

  @override
  Widget build(BuildContext context) {
    final blendModes = BlendMode.values;

    return ListView.builder(
      itemCount: blendModes.length,
      itemBuilder: (context, index) {
        final blendMode = blendModes[index];
        return Column(
          children: [
            Container(
              color: Colors.red,
              height: 40,
              width: 40,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  blendMode: blendMode,
                  child: Container(
                    height: 80,
                    width: 200,
                    child: Center(
                      child: Text(
                        blendMode.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

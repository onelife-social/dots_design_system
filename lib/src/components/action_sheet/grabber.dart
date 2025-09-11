import 'package:flutter/widgets.dart';
import 'package:dots_design_system/dots_design_system.dart';

class Grabber extends StatelessWidget {
  const Grabber({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Container(
      width: 36,
      height: 4,
      decoration: ShapeDecoration(
        color: theme.colors.bgSecondaryBtn,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.50),
        ),
      ),
    );
  }
}

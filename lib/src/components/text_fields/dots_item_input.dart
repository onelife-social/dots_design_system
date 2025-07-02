import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotsItemInputPosition {
  onlyOne,
  first,
  middle,
  last,
}

class DotsItemInput extends StatelessWidget {
  const DotsItemInput(
      {super.key,
      required this.label,
      required this.value,
      required this.icon,
      required this.position});

  final String label;
  final String value;
  final DotsIconData icon;

  final DotsItemInputPosition position;

  BorderRadiusGeometry get borderRadius {
    switch (position) {
      case DotsItemInputPosition.onlyOne:
        return const BorderRadius.all(Radius.circular(16));
      case DotsItemInputPosition.first:
        return const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        );
      case DotsItemInputPosition.middle:
        return BorderRadius.zero;
      case DotsItemInputPosition.last:
        return const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: theme.colors.bgContainerSecondary,
        borderRadius: borderRadius,
      ),
      padding: EdgeInsets.only(
        left: 12,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: Row(
        children: [
          DotsIcon(
            iconData: icon,
            color: theme.colors.textQuarternary,
            size: 20,
          ),
          SizedBox(
            width: 6,
          ),
          Expanded(
            child: Text(
              label,
              style: theme.typo.main.bodyDefaultMedium,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            height: double.infinity,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: theme.colors.bgContainerSecondaryOnBackground,
            ),
            child: Center(
              child: Text(
                value,
                style: theme.typo.main.labelDefaultBold,
              ),
            ),
          )
        ],
      ),
    );
  }
}

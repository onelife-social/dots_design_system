import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsNavBarItem {

  /// Label for the item.
  final String label;

  /// Icon data for the item.
  final DotsIconData iconData;

  /// Callback function when the item is tapped.
  ///   
  /// If not provided, the item will not respond to taps.
  final Function()? onTap;

  DotsNavBarItem({
    required this.label,
    required this.iconData,
    this.onTap,
  });
}

class DotsNavBar extends StatefulWidget {
  final List<DotsNavBarItem> items;

  const DotsNavBar({
    super.key,
    required this.items,
  }) : assert(items.length == 3);

  @override
  State<DotsNavBar> createState() => _DotsNavBarState();
}

class _DotsNavBarState extends State<DotsNavBar> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return ClipRRect(
      borderRadius: DotsBorderRadius.r36,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(5),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: theme.colors.bgFloatingBase.dotsWithOpacity(0.3),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 0.70,
                color: theme.colors.borderGlass,
              ),
              borderRadius: DotsBorderRadius.r36,
            ),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.ease,
                left: selectedIndex * 80.0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 80,
                  height: 65,
                  decoration: BoxDecoration(
                    color: theme.colors.bgFloatingActive,
                    borderRadius: DotsBorderRadius.r32,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.items.length, (index) {
                  final item = widget.items[index];
                  final Color color = selectedIndex == index
                      ? theme.colors.labelHighlight
                      : theme.colors.textSecondary;
                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedIndex = index);
                      item.onTap?.call();
                    },
                    child: Container(
                      width: 80,
                      height: 65,
                      clipBehavior: Clip.antiAlias,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: DotsBorderRadius.all32,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedScale(
                            scale: selectedIndex == index ? 1.2 : 1.0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.ease,
                            child: DotsIcon(
                              iconData: item.iconData,
                              color: color,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 2),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 250),
                            style: theme.typo.main.labelDefaultRegular.copyWith(color: color),
                            child: Text(item.label),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

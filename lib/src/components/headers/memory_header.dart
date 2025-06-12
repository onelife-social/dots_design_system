import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class MemoryHeader extends StatelessWidget {
  final String titleText;
  final String subtitleText;
  final List<Memory> memories;
  //final GroupPendingMemoriesModel groupPendingMemoriesModel; TODO: Change memories for this

  const MemoryHeader({
    super.key,
    required this.titleText,
    required this.subtitleText,
    required this.memories,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Column(
      children: [
        Text(
          titleText,
          style: theme.typo.secondary.title02H6.copyWith(
            color: theme.colors.textPrimary,
          ),
        ),
        Text(
          subtitleText,
          style: theme.typo.main.labelDefaultRegular.copyWith(
            color: theme.colors.textQuarternary,
          ),
        ),
        const SizedBox(height: 27),
        Carrousel(memories: memories),
      ],
    );
  }
}

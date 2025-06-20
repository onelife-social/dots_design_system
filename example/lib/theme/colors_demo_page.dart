import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class ColorsDemoPage extends StatelessWidget {
  const ColorsDemoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.dotsTheme.colors;

    final themeGroups = {
      'Base': {
        'bgBase': colors.bgBase,
        'bgBaseContrast': colors.bgBaseContrast,
      },
      'Container': {
        'bgContainerPrimary': colors.bgContainerPrimary,
        'bgContainerSecondary': colors.bgContainerSecondary,
        'bgContainerSecondaryOnBackground': colors.bgContainerSecondaryOnBackground,
        'bgContainerTertiary': colors.bgContainerTertiary,
      },
      'Buttons': {
        'bgSecondaryBtn': colors.bgSecondaryBtn,
        'bgFloatingBtn': colors.bgFloatingBtn,
        'bgBtnDisabled': colors.bgBtnDisabled,
      },
      'Components': {
        'bgChip': colors.bgChip,
      },
      'Text': {
        'textPrimary': colors.textPrimary,
        'textSecondary': colors.textSecondary,
        'textTertiary': colors.textTertiary,
        'textQuarternary': colors.textQuarternary,
      },
      'Label': {
        'labelPrimary': colors.labelPrimary,
        'labelSecondary': colors.labelSecondary,
        'labelAlwaysWhite': colors.labelAlwaysWhite,
      },
      'Semantic': {
        'labelHighlight': colors.labelHighlight,
        'bgHighlight': colors.bgHighlight,
        'labelDestructive': colors.labelDestructive,
        'bgDestructive': colors.bgDestructive,
        'labelActive': colors.labelActive,
        'labelInactive': colors.labelInactive,
        'bgActive': colors.bgActive,
      },
      'Miscellaneous': {
        'misc100': colors.misc100,
        'misc200': colors.misc200,
        'misc300': colors.misc300,
        'misc400': colors.misc400,
        'misc500': colors.misc500,
        'misc600': colors.misc600,
        'misc700': colors.misc700,
        'misc800': colors.misc800,
        'misc900': colors.misc900,
        'misc1000': colors.misc1000,
        'misc1100': colors.misc1100,
      },
      'Border': {
        'borderAlert': colors.borderAlert,
        'borderLabel': colors.borderLabel,
      },
    };

    return Scaffold(
      backgroundColor: context.dotsTheme.colors.bgBase,
      appBar: AppBar(
          title: Text(
        'Dots Colors Overview',
      )),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: themeGroups.entries.map((group) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                group.key,
                style: context.dotsTheme.typo.main.titleH1,
              ),
              const SizedBox(height: 8),
              ...group.value.entries.map((entry) {
                return _buildColorTile(entry.key, entry.value);
              }),
              const SizedBox(height: 20),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildColorTile(String name, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        name,
        style: TextStyle(
          color: _getTextColorForBackground(color),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getTextColorForBackground(Color background) {
    // Simple luminance check to determine black/white text
    return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}

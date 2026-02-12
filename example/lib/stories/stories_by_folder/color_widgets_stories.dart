import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get colorWidgetsStories => [
      Story(
        name: 'Dots Color widgets/ Dots Color options Row',
        description: 'Horizontal list of selectable color options',
        builder: (context) {
          return const _ColorOptionsRowStory();
        },
      ),
      Story(
        name: 'Dots Color widgets/ Dots Color selector Row',
        description: 'Horizontal list of selectable color options',
        builder: (context) {
          return const _ColorSelectorRowStory();
        },
      ),
]; 

class _ColorSelectorRowStory extends StatefulWidget { 
  const _ColorSelectorRowStory(); 

  @override 
  State<_ColorSelectorRowStory> createState() => _ColorSelectorRowStoryState(); 
}

class _ColorSelectorRowStoryState extends State<_ColorSelectorRowStory> {
  Color? _selectedColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final colors = [
      theme.colors.labelAlwaysWhite,
      theme.colors.dotbookSand,
      theme.colors.dotbookBeigeCraft,
      theme.colors.dotbookOlive, 
      theme.colors.dotbookCloud,
      theme.colors.dotbookPeach,
      theme.colors.dotbookStone,
      theme.colors.dotbookCharcoal,
    ];
    _selectedColor ??= colors.first;

    return Center(
      child: DotsColorSelectorRow(
        colors: colors,
        size: context.knobs.slider(label: 'Size', initial: 48, min: 24, max: 200),
        spacing: context.knobs.slider(label: 'Spacing', initial: 12, min: 0, max: 32),
        selectedColor: _selectedColor,
        onColorSelected: (color) {
          setState(() {
            _selectedColor = color;
          });
        },
      ),
    );
  }
}

class _ColorOptionsRowStory extends StatefulWidget {
  const _ColorOptionsRowStory();

  @override
  State<_ColorOptionsRowStory> createState() => _ColorOptionsRowStoryState();
}

class _ColorOptionsRowStoryState extends State<_ColorOptionsRowStory> {
  DotsColorOption? _selectedColor = DotsColorOptionsRow.colorOptions.first;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DotsColorOptionsRow(
        size: context.knobs.slider(label: 'Size', initial: 48, min: 24, max: 200),
        spacing: context.knobs.slider(label: 'Spacing', initial: 12, min: 0, max: 32),
        selectedColor: _selectedColor,
        onColorSelected: (color) {
          setState(() {
            _selectedColor = color;
          });
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';

class DotbookDateRangeSelectorItem {
  const DotbookDateRangeSelectorItem({
    required this.title,
    this.subtitle,
    this.isSelected = false,
    this.showContent = false,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final bool isSelected;
  final bool showContent;
  final VoidCallback? onTap;
}
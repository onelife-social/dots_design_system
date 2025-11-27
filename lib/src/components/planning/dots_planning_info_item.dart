import '../../../dots_design_system.dart';

class DotsPlanningInfoItem {
  // Icon for the info item
  final DotsIconData icon;

  // Text for the info item
  final String text;

  // Whether the text should be underlined (only for location item)
  final bool underline;

  DotsPlanningInfoItem({
    required this.icon,
    required this.text,
    this.underline = false,
  });
}
import 'package:dots_design_system/dots_design_system.dart';

class EventGroupCardModel {
  final String text;
  final DotsIconData icon;
  final Function()? onTap;

  const EventGroupCardModel({
    required this.text,
    required this.icon,
    this.onTap,
  });
}
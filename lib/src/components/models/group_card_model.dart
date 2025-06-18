import 'package:dots_design_system/dots_design_system.dart';

class GroupEventCardModel {
  final String text;
  final DotsIconData icon;
  final Function()? onTap;

  const GroupEventCardModel({
    required this.text,
    required this.icon,
    this.onTap,
  });
}
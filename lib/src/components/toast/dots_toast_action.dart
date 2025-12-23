import 'package:dots_design_system/dots_design_system.dart';
import 'package:dots_design_system/src/components/toast/dots_toast.dart';
import 'package:flutter/material.dart';

class DotsToastAction extends StatelessWidget {
  final String title;
  final DotsToastVariant variant;
  final DotsIconData? icon;

  const DotsToastAction({super.key, required this.title, required this.variant, this.icon});

  @override
  Widget build(BuildContext context) {
    return DotsToast(title: title, variant: variant, isAction: true, customIconData: icon);
  }
}

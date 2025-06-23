import 'package:dots_design_system/dots_design_system.dart';
import 'package:dots_design_system/src/components/toast/dots_toast.dart';
import 'package:flutter/material.dart';

class DotsToastInfo extends StatelessWidget {
  final String title;
  final DotsToastVariant variant;

  const DotsToastInfo({super.key, required this.title, required this.variant});

  @override
  Widget build(BuildContext context) {
    return DotsToast(title: title, variant: variant, isAction: false);
  }
}

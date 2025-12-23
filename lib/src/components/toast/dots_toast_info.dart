import 'package:dots_design_system/dots_design_system.dart';
import 'package:dots_design_system/src/components/toast/dots_toast.dart';
import 'package:flutter/material.dart';

class DotsToastInfo extends StatelessWidget {
  final String title;
  final DotsToastVariant variant;
  final Color? customIconColor;
  final Function()? onTap;
  final String? btnTitle;
  final DotsIconData? customIconData;

  const DotsToastInfo({
    super.key,
    required this.title,
    required this.variant,
    this.customIconColor,
    this.onTap,
    this.btnTitle,
    this.customIconData,
  });

  @override
  Widget build(BuildContext context) {
    return DotsToast(
      title: title,
      variant: variant,
      isAction: false,
      customIconColor: customIconColor,
      btnTitle: btnTitle,
      onTap: onTap,
      customIconData: customIconData,
    );
  }
}

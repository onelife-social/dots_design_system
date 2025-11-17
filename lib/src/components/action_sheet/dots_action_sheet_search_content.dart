import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheetSearchContent extends StatelessWidget {
  final String title;
  final String hintText;
  final Widget topWidget;
  final ValueChanged<String>? onChanged;
  final Widget? primaryButton;
  final VoidCallback? onPrimaryButtonTap;
  final TextEditingController? textFieldController;
  final FocusNode? focus;
  final VoidCallback? onTapTextFieldBtn;

  const DotsActionSheetSearchContent({
    super.key,
    required this.title,
    required this.hintText,
    required this.topWidget,
    this.onChanged,
    this.primaryButton,
    this.onPrimaryButtonTap,
    this.textFieldController,
    this.focus,
    this.onTapTextFieldBtn,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DotsActionSheetSearchHeader(
              title: title,
              onChanged: onChanged,
              hintText: hintText,
              textFieldController: textFieldController,
              focus: focus,
              onTapTextFieldBtn: onTapTextFieldBtn,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: topWidget,
              ),
            ),
          ],
        ),
        if (primaryButton != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 90,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.0, 0.5, 1.0],
                    colors: [
                      theme.colors.bgBaseContrast,
                      theme.colors.bgBaseContrast,
                      theme.colors.bgBaseContrast.dotsWithOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        if (primaryButton != null)
          Positioned.fill(
            top: null,
            bottom: 16,
            child: GestureDetector(
              onTap: onPrimaryButtonTap,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    primaryButton!,
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _DotsActionSheetSearchHeader extends StatelessWidget {
  final String title;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textFieldController;
  final FocusNode? focus;
  final VoidCallback? onTapTextFieldBtn;

  const _DotsActionSheetSearchHeader({
    required this.title,
    required this.hintText,
    this.onChanged,
    this.textFieldController,
    this.focus,
    this.onTapTextFieldBtn,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: IntrinsicHeight(
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: 190,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: context.dotsTheme.typo.secondary.title02H6,
                ),
              ),
            ),
            DotsTextField(
              controller: textFieldController,
              focusNode: focus,
              iconData: DotsIconData.search,
              iconDataButton: DotsIconData.cross,
              buttonVariant: DotsCloseButtonVariant.inverted,
              buttonSize: DotsCloseButtonSize.extraSmall,
              onChanged: onChanged,
              hintText: hintText,
              onTapBtn: onTapTextFieldBtn,
            ),
          ],
        ),
      ),
    );
  }
}


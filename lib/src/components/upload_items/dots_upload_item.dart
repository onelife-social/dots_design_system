import 'package:flutter/material.dart';

import '../../../dots_design_system.dart';

class DotsUploadItem extends StatelessWidget {

  /// Image to display in the upload item.
  final ImageProvider image;

  /// Default image path to be used when the image fails to load.
  final String defaultImagePath;

  /// Callback for image load errors.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// Variant of the upload item.
  final UploadItemVariant variant;

  /// Percentage of the upload progress, must be between 0 and 1.
  final double? percentage;

  /// Date text to display above the process text.
  final String? textDate;

  /// Process text to display discribing the upload status.
  final String? processText;

  /// Elapsed time text to display when the upload is successful.
  final String? timeElapsed;

  /// Text for the button displayed on the right side.
  final String? btnText;

  /// Callback for button tap events.
  final VoidCallback? btnOnTap;

  const DotsUploadItem({
    super.key,
    required this.image,
    required this.defaultImagePath,
    required this.variant,
    this.onError,
    this.textDate,
    this.processText,
    this.timeElapsed,
    this.percentage,
    this.btnText,
    this.btnOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    DotsIconData iconData;
    Color iconColor;

    switch (variant) {
      case UploadItemVariant.processing:
        iconData = DotsIconData.spinner;
        iconColor = theme.colors.textSecondary;
        break;
      case UploadItemVariant.success:
        iconData = DotsIconData.checkCircle;
        iconColor = theme.colors.labelHighlight;
        break;
      case UploadItemVariant.error:
        iconData = DotsIconData.crossCircle;
        iconColor = theme.colors.labelDestructive;
        break;
    }

    return Row(
      children: [
        DotsSquircleImage(
          image: image,
          defaultImagePath: defaultImagePath,
          squircleStyle: theme.styles.squircle16,
          size: 64,
          onError: onError,
          uploadError: variant.isError,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: variant.isProcessing ? 10 : 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textDate ?? '',
                  style: theme.typo.main.bodyDefaultMedium.copyWith(
                    color: theme.colors.textPrimary,
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    _RotatingIcon(
                      animate: variant.isProcessing,
                      child: DotsIcon(
                        iconData: iconData,
                        size: 14,
                        color: iconColor,
                      ),
                    ),
                    SizedBox(width: 3),
                    Text(
                      processText ?? '',
                      style: theme.typo.main.labelDefaultRegular.copyWith(
                        color: theme.colors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                if (variant.isProcessing) ...[
                  Row(
                    children: [
                      Expanded(
                        child: DotsProgressBar(
                          percentage: percentage ?? 1,
                          parts: 1,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        percentage != null ? '${(percentage! * 100).toStringAsFixed(0)}%' : '',
                        style: theme.typo.main.labelDefaultRegular.copyWith(
                          color: theme.colors.textQuarternary,
                        ),
                      )
                    ],
                  ),
                ],
                if (variant.isSuccess) ...[
                  SizedBox(height: 4),
                  Text(
                    timeElapsed ?? '',
                    style: theme.typo.main.labelDefaultRegular.copyWith(
                      color: theme.colors.textQuarternary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ],
            ),
          ),
        ),
        if (!variant.isProcessing)...[
          SizedBox(width: 12),
          if (variant.isSuccess)
            DotsMainButton(
              content: btnText ?? '',
              variant: DotsMainButtonVariant.secondary,
              size: DotsMainButtonSize.medium,
              onTap: btnOnTap,
            )
          else 
            DotsMainButton(
              content: btnText ?? '',
              variant: DotsMainButtonVariant.main,
              size: DotsMainButtonSize.medium,
              onTap: btnOnTap,
            )
        ],
      ],
    );
  }
}



class _RotatingIcon extends StatefulWidget {
  final bool animate;
  final Widget child;

  const _RotatingIcon({
    required this.animate,
    required this.child,
  });

  @override
  State<_RotatingIcon> createState() => _RotatingIconState();
}

class _RotatingIconState extends State<_RotatingIcon> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    if (widget.animate) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant _RotatingIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.animate && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.animate) {
      return widget.child;
    }
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }
}
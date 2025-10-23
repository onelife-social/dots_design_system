import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsMemoryDetails extends StatelessWidget {
  /// The image to be displayed in the memory details.
  final ImageProvider? image;

  /// Callback for image load error.
  /// Called when the image fails to load.
  final void Function(Object exception, StackTrace? stackTrace)? onImageError;

  /// The text indicating who uploaded the memory.
  final String? uploadBytext;

  /// The text indicating the group name where the memory was uploaded.
  final String? groupName;

  /// The date to be displayed below the image.
  final String? date;

  /// The time to be displayed below the date.
  final String? time;

  /// Callback when the memory details is tapped.
  final Function()? onTap;

  const DotsMemoryDetails({
    super.key,
    this.image,
    this.onImageError,
    this.uploadBytext,
    this.groupName,
    this.date,
    this.time,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final double hPad = MediaQuery.of(context).size.width * 0.156;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 88,
            height: 120,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              image: image != null
                  ? DecorationImage(
                      image: image!,
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        onImageError?.call(exception, stackTrace);
                      },
                    )
                  : null,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.50,
                  color: theme.colors.bgContainerSecondary,
                ),
                borderRadius: DotsBorderRadius.r24,
              ),
              shadows: [
                BoxShadow(
                  color: theme.colors.shadowPrimary,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: hPad),
          child: Text.rich(
            TextSpan(
              children: [
                if (uploadBytext?.isNotEmpty ?? false)
                  TextSpan(
                    text: '$uploadBytext ',
                    style: theme.typo.main.labelDefaultRegular.copyWith(
                      color: theme.colors.textTertiary,
                    ),
                  ),
                TextSpan(
                  text: groupName ?? '',
                  style: theme.typo.main.labelDefaultBold.copyWith(
                    color: theme.colors.textSecondary,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: hPad),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (time?.isNotEmpty ?? false) ? '$date, ' : date!,
                style: theme.typo.main.labelDefaultBold.copyWith(
                  color: theme.colors.textTertiary,
                ),
              ),
              Text(
                time ?? '',
                style: theme.typo.main.labelDefaultBold.copyWith(
                  color: theme.colors.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

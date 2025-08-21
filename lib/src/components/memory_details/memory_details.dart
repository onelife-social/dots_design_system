import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsMemoryDetails extends StatelessWidget {

  /// The image to be displayed in the memory details.
  final ImageProvider? image;

  /// Callback for image load error.
  /// Called when the image fails to load.
  final void Function(Object exception, StackTrace? stackTrace)? onImageError;

  /// The date to be displayed below the image.
  final String? date;

  /// The time to be displayed below the date.
  final String? time;


  const DotsMemoryDetails({
    super.key,
    this.image,
    this.onImageError,
    this.date,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Container(
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
        const SizedBox(height: 16),
        Text(
          date ?? '',
          style: theme.typo.main.labelDefaultBold.copyWith(
            color: theme.colors.textTertiary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          time ?? '',
          style: theme.typo.number.numLabelDefault.copyWith(
            color: theme.colors.textQuarternary,
          ),
        ),
      ],
    );
  }
}
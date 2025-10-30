import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum RecapCardLockedVariant {
  countdown,
  locked,
  soon;

  bool get isCountdown => this == RecapCardLockedVariant.countdown;
  bool get isLocked => this == RecapCardLockedVariant.locked;
  bool get isSoon => this == RecapCardLockedVariant.soon;
}

class RecapCardLocked extends StatelessWidget {
  /// The aspect ratio of the card.
  static const double kAspectRatio = 7 / 8;

  /// The width of the card.
  final double? width;

  /// The variant of the group card.
  final RecapCardLockedVariant variant;

  /// The image provider for the background image
  final ImageProvider imageProvider;

  /// Callback when an error occurs while loading the image.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// The title of the recap card.
  final String title;

  /// The description of the card. Why it is locked.
  final String? description;

  /// The date it will be unlocked.
  final DateTime? countdownDate;

  /// Button text that will be displayed at the bottom of the card.
  final String? buttonText;

  /// Callback when the button is tapped.
  final Function()? onButtonTap;

  /// Callback when the info icon is tapped.
  final Function()? onInfoTap;

  /// The label for days in the countdown.
  final String? daysLabel;

  /// The label for hours in the countdown.
  final String? hoursLabel;

  /// The label for minutes in the countdown.
  final String? minutesLabel;

  /// The label for seconds in the countdown.
  final String? secondsLabel;

  const RecapCardLocked({
    super.key,
    required this.variant,
    required this.imageProvider,
    required this.title,
    this.width,
    this.description,
    this.countdownDate,
    this.buttonText,
    this.onButtonTap,
    this.onInfoTap,
    this.onError,
    this.daysLabel,
    this.hoursLabel,
    this.minutesLabel,
    this.secondsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return SizedBox(
      width: width,
      child: AspectRatio(
        aspectRatio: kAspectRatio,
        child: DotsDecoratedBox(
          styleType: theme.styles.squircle52,
          child: Stack(
            children: [
              Image(
                image: imageProvider,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  if (onError != null) onError!(error, stackTrace);
                  return SizedBox();
                },
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Stack(
                  children: [
                    if (!variant.isSoon) ...[
                      Align(
                        alignment: Alignment.topRight,
                        child: DotsIconButton(
                          icon: DotsIconData.info,
                          onTap: onInfoTap,
                          style: DotsIconButtonStyle.floating,
                          size: DotsIconButtonSize.medium,
                          state: DotsIconButtonState.defaultState,
                          color: theme.colors.textPrimary,
                          backgroundColor: theme.colors.bgBtnImage,
                        ),
                      ),
                    ],
                    Center(
                      child: CountdownRecap(
                        title: title,
                        description: description ?? '',
                        countdownDate: variant.isCountdown
                            ? countdownDate ?? DateTime.now()
                            : DateTime.now(),
                        daysLabel: daysLabel ?? '',
                        hoursLabel: hoursLabel ?? '',
                        minutesLabel: minutesLabel ?? '',
                        secondsLabel: secondsLabel ?? '',
                      ),
                    ),
                    if (variant.isLocked)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: DotsMainButton(
                          content: buttonText ?? '',
                          variant: DotsMainButtonVariant.main,
                          expand: false,
                          onTap: onButtonTap,
                          icon: DotsIconData.gallery,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

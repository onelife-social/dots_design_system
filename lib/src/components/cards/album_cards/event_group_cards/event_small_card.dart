
import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class GroupEventCardSmall extends StatelessWidget {
  /// The image provider to display (NetworkImage, AssetImage, etc).
  final ImageProvider imageProvider;

  /// The name of the group to display on the card.
  final String groupName;

  /// Whether the group is a prime group.
  final bool isPrime;

  /// The icon data for the Card tag.
  final DotsIconData iconDataTag;

  /// Callback when the profile image is tapped.
  final Function()? onTap;

  /// Callback when an error occurs while loading the image.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  GroupEventCardSmall({
    required this.imageProvider,
    required this.groupName,
    required this.isPrime,
    required this.iconDataTag,
    this.onTap,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        height: 160,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            onError: onError,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: DotsBorderRadius.r32,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 43,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      theme.colors.bgContainerPrimary,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        groupName,
                        textAlign: TextAlign.center,
                        style:theme.typo.main.labelDefaultMedium.copyWith(color: theme.colors.textPrimary),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  if(isPrime)
                     Positioned(
                    left: 0,
                    top: 0,
                    child: CardTag(
                        iconData: iconDataTag,
                        size: 24,
                        iconSize: 16,
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
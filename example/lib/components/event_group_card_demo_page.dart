import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class EventGroupCardDemoPage extends StatelessWidget {
  final ImageProvider imageProvider;
  final String title;
  final EventGroupCardVariant variant;
  final DotsIconData? tagIconData;
  final String secondaryText;
  final bool isBlocked;
  final double? edgeSize;

  const EventGroupCardDemoPage({
    super.key,
    required this.imageProvider,
    required this.title,
    required this.variant,
    this.tagIconData,
    required this.secondaryText,
    this.isBlocked = false,
    this.edgeSize,
  });

  @override
  Widget build(BuildContext context) {
    final actions = [
      GroupEventCardModel(
        text: 'Chat',
        icon: DotsIconData.chat,
        onTap: () {},
      ),
      GroupEventCardModel(
        text: 'Subir',
        icon: DotsIconData.camera,
        onTap: () {},
      ),
      GroupEventCardModel(
        text: 'Planning',
        icon: DotsIconData.planner,
        onTap: () {},
      ),
    ];

    final card = EventGroupCard(
      imageProvider: imageProvider,
      title: title,
      variant: variant,
      tagIconData: tagIconData,
      onTap: () {},
      onSecondaryTap: () {},
      onError: (exception, stackTrace) {},
      actions: actions,
      secondaryText: secondaryText,
      isBlocked: isBlocked,
      edgeSize: edgeSize,
    );

    return variant == EventGroupCardVariant.small
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: card),
              const SizedBox(width: 20),
              Expanded(
                child: EventGroupCard(
                  imageProvider: imageProvider,
                  title: title,
                  variant: variant,
                  tagIconData: tagIconData,
                  onTap: () {},
                  onSecondaryTap: () {},
                  onError: (exception, stackTrace) {},
                  actions: actions,
                  secondaryText: secondaryText,
                  isBlocked: isBlocked,
                  edgeSize: edgeSize,
                ),
              ),
            ],
          )
        : Column(
            children: [
              card,
              const SizedBox(height: 20),
              EventGroupCard(
                imageProvider: imageProvider,
                title: title,
                variant: variant,
                tagIconData: tagIconData,
                onTap: () {},
                onSecondaryTap: () {},
                onError: (exception, stackTrace) {},
                actions: actions,
                secondaryText: secondaryText,
                isBlocked: isBlocked,
                edgeSize: edgeSize,
              ),
            ],
          );
  }
}

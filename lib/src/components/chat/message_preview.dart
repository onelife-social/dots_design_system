import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class MessagePreview extends StatelessWidget {
  final Widget image;
  final String album;
  final String senderName;
  final Widget contentMessage;
  final int newMessages;
  final String time;
  final VoidCallback onTap;

  const MessagePreview({
    super.key,
    required this.image,
    required this.album,
    required this.senderName,
    required this.contentMessage,
    required this.newMessages,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 88,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _ImageAlbum(image: image),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ChatHeaderInfo(album: album, time: time),
                    _ChatContent(
                        senderName: senderName, text: contentMessage, newMessages: newMessages)
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

class _ImageAlbum extends StatelessWidget {
  final Widget image;
  const _ImageAlbum({required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: DotsBorderRadius.r16,
      child: SizedBox(
        width: 52,
        height: 52,
        child: image,
      ),
    );
  }
}

class _ChatHeaderInfo extends StatelessWidget {
  final String album;
  final String time;

  const _ChatHeaderInfo({
    required this.album,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Row(
      children: [
        Expanded(child: Text(album, style: theme.typo.main.bodyDefaultBold)),
        const SizedBox(height: 4),
        Text(time, style: theme.typo.main.labelDefaultRegular),
      ],
    );
  }
}

class _ChatContent extends StatelessWidget {
  final String senderName;
  final Widget text;
  final int newMessages;

  const _ChatContent({
    required this.senderName,
    required this.text,
    required this.newMessages,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Row(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                senderName != '' ? '$senderName: ' : '',
                style: theme.typo.main.labelDefaultBold,
              ),
              Expanded(child: text),
            ],
          ),
        ),
        if (newMessages > 0)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: BadgeTag(
              tag: newMessages.toString(),
              child: const SizedBox.shrink(),
            ),
          ),
      ],
    );
  }
}

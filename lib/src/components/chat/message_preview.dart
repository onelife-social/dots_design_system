import 'package:flutter/material.dart';

import '../../../dots_design_system.dart';
import '../../../utils/text_utils.dart';

class MessagePreview extends StatelessWidget {
  final Widget image;
  final String album;
  final String senderName;
  final String message;
  final String? typingText;
  final int newMessages;
  final String time;
  final VoidCallback onTap;
  final Widget? attachmentMessage;

  const MessagePreview({
    super.key,
    required this.image,
    required this.album,
    required this.senderName,
    required this.message,
    required this.newMessages,
    required this.time,
    required this.onTap,
    this.typingText,
    this.attachmentMessage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        height: 92,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: SizedBox(
              height: 62,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ImageAlbum(image: image),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        _ChatHeaderInfo(album: album, time: time),
                        SizedBox(height: 4),
                        _ChatContent(
                            senderName: senderName,
                            message: message,
                            typingText: typingText,
                            attachmentMessage: attachmentMessage,
                            newMessages: newMessages),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
    return DotsDecoratedBox(
      styleType: context.dotsTheme.styles.squircle16,
      child: SizedBox(
        width: 56,
        height: 56,
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
        Expanded(
          child: Text(
            album,
            style: theme.typo.main.bodyLargeBold.copyWith(
              color: theme.colors.textPrimary,
              height: 1,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: theme.typo.main.bodyDefaultRegular.copyWith(
            color: theme.colors.textSecondary,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class _ChatContent extends StatelessWidget {
  final String senderName;
  final String message;
  final int newMessages;
  final String? typingText;
  final Widget? attachmentMessage;

  const _ChatContent({
    required this.senderName,
    required this.message,
    required this.newMessages,
    this.typingText,
    this.attachmentMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: () {
              final TextStyle textStyle = context.dotsTheme.typo.main.bodyDefaultRegular.copyWith(
                color: context.dotsTheme.colors.textSecondary,
              );

              final theme = context.dotsTheme;

              final List<InlineSpan> spans = [];

              if (typingText != null && typingText!.isNotEmpty) {
                spans.add(
                  TextSpan(
                    text: typingText,
                    style: textStyle,
                  ),
                );
              } else if (typingText == null) {
                if (senderName.isNotEmpty) {
                  spans.add(
                    TextSpan(
                      text: '$senderName: ',
                      style: theme.typo.main.bodyDefaultBold.copyWith(
                        color: theme.colors.textSecondary,
                      ),
                    ),
                  );
                }
                if (attachmentMessage != null) {
                  spans
                    ..add(
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: attachmentMessage!,
                      ),
                    )
                    ..add(
                      const TextSpan(text: ' '),
                    );
                }
                spans.addAll(
                  DotsTextUtils().buildTextWithEmojiSpans(
                    text: message,
                    baseStyle: textStyle,
                  ),
                );
              }

              return TextSpan(children: spans);
            }(),
          ),
        ),
        if (newMessages > 0)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: BadgeTag(
              tag: newMessages > 999 ? '+999' : newMessages.toString(),
            ),
          ),
      ],
    );
  }
}

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsTextUtils {
  /// Builds TextSpan list that separates emojis from regular text
  /// Emojis maintain full opacity while regular text uses the theme color
  List<TextSpan> buildTextWithEmojiSpans({
    required String text,
    required TextStyle baseStyle,
  }) {
    final emojiRegex = RegExp(
      r'[\u{1F600}-\u{1F64F}]|[\u{1F300}-\u{1F5FF}]|[\u{1F680}-\u{1F6FF}]|[\u{1F1E0}-\u{1F1FF}]|[\u{2600}-\u{26FF}]|[\u{2700}-\u{27BF}]|[\u{1F900}-\u{1F9FF}]|[\u{1F018}-\u{1F0FF}]|[\u{1F200}-\u{1F2FF}]|[\u{1FA70}-\u{1FAFF}]',
      unicode: true,
    );

    final spans = <TextSpan>[];
    int lastEnd = 0;

    for (final match in emojiRegex.allMatches(text)) {
      // Add text before emoji
      if (match.start > lastEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastEnd, match.start),
            style: baseStyle,
          ),
        );
      }

      // Add emoji with full opacity
      spans.add(
        TextSpan(
          text: match.group(0),
          style: baseStyle.copyWith(
            color: baseStyle.color?.dotsWithOpacity(1.0),
          ),
        ),
      );

      lastEnd = match.end;
    }

    // Add remaining text after last emoji
    if (lastEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastEnd),
          style: baseStyle,
        ),
      );
    }

    return spans;
  }

  /// Utility function to scale font size based on image width
  static double scaledFontSize({
    required double referenceFontSize,
    required double imageWidth,
    required double referenceWidth,
  }) {
    return referenceFontSize * (imageWidth / referenceWidth);
  }

  /// Adds soft-hyphen break opportunities to long words.
  ///
  /// Soft hyphens (`\u00AD`) only render when a line break happens,
  /// allowing wrapped words to show a hyphen instead of ellipsis.
  static String withSoftHyphenBreaks(
    String text, {
    int minWordLength = 8,
    int interval = 3,
  }) {
    if (text.isEmpty) {
      return text;
    }

    return text.replaceAllMapped(RegExp(r'\S+'), (match) {
      final String word = match.group(0)!;

      if (word.contains('\u00AD') || word.length < minWordLength) {
        return word;
      }

      final StringBuffer buffer = StringBuffer();
      for (int i = 0; i < word.length; i++) {
        buffer.write(word[i]);

        final bool isLastChar = i == word.length - 1;
        if (!isLastChar && (i + 1) % interval == 0) {
          buffer.write('\u00AD');
        }
      }

      return buffer.toString();
    });
  }
}

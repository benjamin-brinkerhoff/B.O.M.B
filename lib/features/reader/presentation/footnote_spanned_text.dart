import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/data/scripture_footnotes.dart';
import '../../../core/models/scripture_models.dart';
import 'footnote_popup_sheet.dart';

/// Widget rendering scripture text where words with official footnotes are highlighted
/// in Church-standard blue and tap-enabled for cross-references & definitions.
class FootnoteSpannedText extends StatelessWidget {
  final ScriptureVerse verse;
  final TextStyle baseStyle;

  const FootnoteSpannedText({
    super.key,
    required this.verse,
    required this.baseStyle,
  });

  @override
  Widget build(BuildContext context) {
    final footnotes = ScriptureFootnotes.getFootnotesForVerse(
      verse.volumeId,
      verse.bookId,
      verse.chapter,
      verse.verseNumber,
    );

    if (footnotes.isEmpty) {
      return Text(verse.text, style: baseStyle);
    }

    final spans = <InlineSpan>[];
    final words = verse.text.split(' ');

    for (int i = 0; i < words.length; i++) {
      final rawWord = words[i];
      final cleanWord = rawWord.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

      // Check if this word matches any footnote in the verse
      ScriptureFootnote? matchedFootnote;
      for (final fn in footnotes) {
        if (fn.word.toLowerCase() == cleanWord) {
          matchedFootnote = fn;
          break;
        }
      }

      if (matchedFootnote != null) {
        // Render in Church-standard blue with clickable recognizer
        spans.add(
          TextSpan(
            text: rawWord,
            style: baseStyle.copyWith(
              color: const Color(0xFF1976D2), // Royal Blue
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dotted,
              decorationColor: const Color(0xFF1976D2),
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                FootnotePopupSheet.show(context, matchedFootnote!);
              },
          ),
        );
        // Add subtle footnote key superscript
        spans.add(
          TextSpan(
            text: '\${matchedFootnote.footnoteKey} ',
            style: baseStyle.copyWith(
              fontSize: (baseStyle.fontSize ?? 16) * 0.72,
              color: const Color(0xFF1565C0),
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        spans.add(TextSpan(text: '\$rawWord ', style: baseStyle));
      }
    }

    return RichText(text: TextSpan(children: spans));
  }
}

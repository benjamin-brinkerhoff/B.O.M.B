import 'package:flutter/material.dart';

/// Supported Bible translations.
class BibleVersion {
  final String id;
  final String name;
  final String abbreviation;
  final String description;

  const BibleVersion({
    required this.id,
    required this.name,
    required this.abbreviation,
    required this.description,
  });
}

/// Represents a volume of scripture.
class ScriptureVolume {
  final String id; // 'bom', 'ot', 'nt'
  final String title;
  final String shortTitle;
  final List<ScriptureBook> books;

  const ScriptureVolume({
    required this.id,
    required this.title,
    required this.shortTitle,
    required this.books,
  });
}

/// Represents a book within a volume.
class ScriptureBook {
  final String id;
  final String title;
  final String abbreviation;
  final String volumeId;
  final int chapterCount;

  const ScriptureBook({
    required this.id,
    required this.title,
    required this.abbreviation,
    required this.volumeId,
    required this.chapterCount,
  });
}

/// Represents an individual scripture verse.
class ScriptureVerse {
  final String volumeId;
  final String bookId;
  final int chapter;
  final int verseNumber;
  final String text;

  const ScriptureVerse({
    required this.volumeId,
    required this.bookId,
    required this.chapter,
    required this.verseNumber,
    required this.text,
  });

  String get referenceKey => '$volumeId:$bookId:$chapter:$verseNumber';
}

/// Palette of available highlight colors for markup.
enum HighlightColor {
  yellow(0xFFFFF59D, 'Yellow', Color(0xFFFFF59D)),
  green(0xFFC8E6C9, 'Green', Color(0xFFC8E6C9)),
  blue(0xFFBBDEFB, 'Blue', Color(0xFFBBDEFB)),
  coral(0xFFFFCCBC, 'Coral', Color(0xFFFFCCBC)),
  purple(0xFFE1BEE7, 'Purple', Color(0xFFE1BEE7));

  final int hexValue;
  final String label;
  final Color color;
  const HighlightColor(this.hexValue, this.label, this.color);
}

/// Represents user markup (highlight, personal note, tags, personal cross-reference links) on a verse.
class VerseAnnotation {
  final String id;
  final String volumeId;
  final String bookId;
  final int chapter;
  final int verseNumber;
  final HighlightColor? highlightColor;
  final String? note;
  final List<String> tags;
  final List<String> linkedVerseKeys; // Format: "volumeId:bookId:chapter:verseNumber"
  final DateTime updatedAt;

  const VerseAnnotation({
    required this.id,
    required this.volumeId,
    required this.bookId,
    required this.chapter,
    required this.verseNumber,
    this.highlightColor,
    this.note,
    this.tags = const [],
    this.linkedVerseKeys = const [],
    required this.updatedAt,
  });

  String get referenceKey => '$volumeId:$bookId:$chapter:$verseNumber';

  VerseAnnotation copyWith({
    HighlightColor? highlightColor,
    bool clearHighlight = false,
    String? note,
    bool clearNote = false,
    List<String>? tags,
    List<String>? linkedVerseKeys,
    DateTime? updatedAt,
  }) {
    return VerseAnnotation(
      id: id,
      volumeId: volumeId,
      bookId: bookId,
      chapter: chapter,
      verseNumber: verseNumber,
      highlightColor: clearHighlight ? null : (highlightColor ?? this.highlightColor),
      note: clearNote ? null : (note ?? this.note),
      tags: tags ?? this.tags,
      linkedVerseKeys: linkedVerseKeys ?? this.linkedVerseKeys,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}

/// Individual cross-reference target inside a footnote.
class FootnoteReference {
  final String volumeId;
  final String bookId;
  final int chapter;
  final int verseNumber;
  final String displayReference; // e.g. "1 Sam. 3:19" or "Philip. 4:13"
  final String? previewText;

  const FootnoteReference({
    required this.volumeId,
    required this.bookId,
    required this.chapter,
    required this.verseNumber,
    required this.displayReference,
    this.previewText,
  });
}

/// Official Church-style footnote cross-reference attached to a word in a verse.
class ScriptureFootnote {
  final String id;
  final String volumeId;
  final String bookId;
  final int chapter;
  final int verseNumber;
  final String word; // Word or phrase in the verse that triggers the footnote
  final String footnoteKey; // e.g. "1a", "7b"
  final String? definition; // e.g. "HEB: upright, honorable"
  final String? topicalGuideTopic; // e.g. "TG Family" or "TG Faith"
  final List<FootnoteReference> references;

  const ScriptureFootnote({
    required this.id,
    required this.volumeId,
    required this.bookId,
    required this.chapter,
    required this.verseNumber,
    required this.word,
    required this.footnoteKey,
    this.definition,
    this.topicalGuideTopic,
    required this.references,
  });
}

/// Dictionary entry for on-device definition lookup.
class DictionaryEntry {
  final String word;
  final String partOfSpeech;
  final String definition;
  final String? etymology;
  final List<String> sampleOccurrences;

  const DictionaryEntry({
    required this.word,
    required this.partOfSpeech,
    required this.definition,
    this.etymology,
    this.sampleOccurrences = const [],
  });
}

/// Result of a global search query.
class SearchResult {
  final String volumeTitle;
  final String bookTitle;
  final int chapter;
  final int verseNumber;
  final String verseText;
  final String? matchedNote;
  final String? matchedTag;
  final bool isNoteMatch;
  final bool isTagMatch;

  const SearchResult({
    required this.volumeTitle,
    required this.bookTitle,
    required this.chapter,
    required this.verseNumber,
    required this.verseText,
    this.matchedNote,
    this.matchedTag,
    this.isNoteMatch = false,
    this.isTagMatch = false,
  });

  String get reference => '$bookTitle $chapter:$verseNumber';
}

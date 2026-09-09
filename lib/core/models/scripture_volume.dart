/// Represents a volume of scripture (e.g. Book of Mormon, Old Testament, New Testament).
class ScriptureVolume {
  final String id;
  final String title;
  final String description;
  final List<ScriptureBook> books;

  const ScriptureVolume({
    required this.id,
    required this.title,
    required this.description,
    required this.books,
  });
}

/// Represents an individual book within a scripture volume.
class ScriptureBook {
  final String id;
  final String title;
  final String abbreviation;
  final int chapterCount;

  const ScriptureBook({
    required this.id,
    required this.title,
    required this.abbreviation,
    required this.chapterCount,
  });
}

/// Represents a specific chapter or verse reference.
class ChapterReference {
  final String volumeId;
  final String bookId;
  final int chapter;
  final int? verse;

  const ChapterReference({
    required this.volumeId,
    required this.bookId,
    required this.chapter,
    this.verse,
  });

  String get displayReference => '\$bookId \$chapter\${verse != null ? ':\$verse' : ''}';
}

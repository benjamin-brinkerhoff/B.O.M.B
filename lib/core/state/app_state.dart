import 'package:flutter/material.dart';
import '../models/scripture_models.dart';
import '../data/scripture_canon.dart';
import '../data/scripture_repository.dart';

/// Global application state managing navigation, reading styles, annotations, and search.
class AppState extends ChangeNotifier {
  // Navigation State
  String _currentVolumeId = 'bom';
  String _currentBookId = '1-ne';
  int _currentChapter = 1;
  int? _targetVerse;

  // Bible Translation
  String _currentBibleVersionId = 'kjv';

  // Reading Styles & Display Preferences
  ThemeMode _themeMode = ThemeMode.system;
  String _fontFamilyOption = 'serif'; // 'sansSerif' (Arial), 'serif' (Times New Roman), 'georgia'
  double _fontSize = 17.0;

  // Annotations (Key format: "volumeId:bookId:chapter:verseNumber")
  final Map<String, VerseAnnotation> _annotations = {};

  // Getters
  String get currentVolumeId => _currentVolumeId;
  String get currentBookId => _currentBookId;
  int get currentChapter => _currentChapter;
  int? get targetVerse => _targetVerse;
  String get currentBibleVersionId => _currentBibleVersionId;
  ThemeMode get themeMode => _themeMode;
  String get fontFamilyOption => _fontFamilyOption;
  double get fontSize => _fontSize;

  ScriptureVolume get currentVolume => ScriptureCanon.getVolume(_currentVolumeId);
  ScriptureBook get currentBook => ScriptureCanon.getBook(_currentVolumeId, _currentBookId) ?? currentVolume.books.first;
  BibleVersion get currentBibleVersion => ScriptureCanon.bibleVersions.firstWhere(
    (v) => v.id == _currentBibleVersionId,
    orElse: () => ScriptureCanon.bibleVersions.first,
  );

  List<ScriptureVerse> get currentVerses => ScriptureRepository.getChapterVerses(
    _currentVolumeId,
    _currentBookId,
    _currentChapter,
  );

  List<VerseAnnotation> get allNotes => _annotations.values
      .where((a) => a.note != null && a.note!.trim().isNotEmpty)
      .toList()
    ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

  List<VerseAnnotation> get allHighlights => _annotations.values
      .where((a) => a.highlightColor != null)
      .toList()
    ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

  // Navigation Methods
  void jumpTo({
    required String volumeId,
    required String bookId,
    required int chapter,
    int? verse,
  }) {
    _currentVolumeId = volumeId;
    _currentBookId = bookId;
    _currentChapter = chapter;
    _targetVerse = verse;
    notifyListeners();
  }

  void nextChapter() {
    final book = currentBook;
    if (_currentChapter < book.chapterCount) {
      _currentChapter++;
      _targetVerse = null;
      notifyListeners();
    } else {
      // Move to next book in volume if available
      final books = currentVolume.books;
      final bookIndex = books.indexWhere((b) => b.id == _currentBookId);
      if (bookIndex >= 0 && bookIndex < books.length - 1) {
        _currentBookId = books[bookIndex + 1].id;
        _currentChapter = 1;
        _targetVerse = null;
        notifyListeners();
      }
    }
  }

  void previousChapter() {
    if (_currentChapter > 1) {
      _currentChapter--;
      _targetVerse = null;
      notifyListeners();
    } else {
      // Move to previous book in volume if available
      final books = currentVolume.books;
      final bookIndex = books.indexWhere((b) => b.id == _currentBookId);
      if (bookIndex > 0) {
        final prevBook = books[bookIndex - 1];
        _currentBookId = prevBook.id;
        _currentChapter = prevBook.chapterCount;
        _targetVerse = null;
        notifyListeners();
      }
    }
  }

  // Bible Version Selector
  void setBibleVersion(String versionId) {
    _currentBibleVersionId = versionId;
    notifyListeners();
  }

  // Appearance & Typography Styles
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setFontFamilyOption(String option) {
    _fontFamilyOption = option;
    notifyListeners();
  }

  void setFontSize(double size) {
    _fontSize = size.clamp(12.0, 32.0);
    notifyListeners();
  }

  TextStyle getReaderTextStyle(BuildContext context, {FontWeight? weight, Color? color}) {
    List<String> familyFallback;
    switch (_fontFamilyOption) {
      case 'sansSerif':
        familyFallback = const ['Arial', 'Helvetica', 'sans-serif'];
        break;
      case 'georgia':
        familyFallback = const ['Georgia', 'serif'];
        break;
      case 'serif':
      default:
        familyFallback = const ['Times New Roman', 'Times', 'serif'];
        break;
    }

    final theme = Theme.of(context);
    return TextStyle(
      fontSize: _fontSize,
      height: 1.65,
      fontWeight: weight ?? FontWeight.normal,
      fontFamilyFallback: familyFallback,
      color: color ?? theme.textTheme.bodyLarge?.color,
    );
  }

  // Annotation & Markup Methods
  VerseAnnotation? getAnnotation(String volumeId, String bookId, int chapter, int verseNumber) {
    final key = '$volumeId:$bookId:$chapter:$verseNumber';
    return _annotations[key];
  }

  void setHighlight(String volumeId, String bookId, int chapter, int verseNumber, HighlightColor? color) {
    final key = '$volumeId:$bookId:$chapter:$verseNumber';
    final existing = _annotations[key];

    if (existing == null) {
      if (color != null) {
        _annotations[key] = VerseAnnotation(
          id: key,
          volumeId: volumeId,
          bookId: bookId,
          chapter: chapter,
          verseNumber: verseNumber,
          highlightColor: color,
          updatedAt: DateTime.now(),
        );
      }
    } else {
      if (color == null && (existing.note == null || existing.note!.isEmpty)) {
        _annotations.remove(key);
      } else {
        _annotations[key] = existing.copyWith(
          highlightColor: color,
          clearHighlight: color == null,
        );
      }
    }
    notifyListeners();
  }

  void setNote(String volumeId, String bookId, int chapter, int verseNumber, String? noteText) {
    final key = '$volumeId:$bookId:$chapter:$verseNumber';
    final existing = _annotations[key];
    final trimmed = noteText?.trim();

    if (existing == null) {
      if (trimmed != null && trimmed.isNotEmpty) {
        _annotations[key] = VerseAnnotation(
          id: key,
          volumeId: volumeId,
          bookId: bookId,
          chapter: chapter,
          verseNumber: verseNumber,
          note: trimmed,
          updatedAt: DateTime.now(),
        );
      }
    } else {
      if ((trimmed == null || trimmed.isEmpty) && existing.highlightColor == null) {
        _annotations.remove(key);
      } else {
        _annotations[key] = existing.copyWith(
          note: trimmed,
          clearNote: trimmed == null || trimmed.isEmpty,
        );
      }
    }
    notifyListeners();
  }

  void deleteAnnotation(String volumeId, String bookId, int chapter, int verseNumber) {
    final key = '$volumeId:$bookId:$chapter:$verseNumber';
    _annotations.remove(key);
    notifyListeners();
  }

  // Global Search
  List<SearchResult> search({
    required String query,
    String? volumeFilter,
    bool searchNotesOnly = false,
  }) {
    final cleanQuery = query.trim().toLowerCase();
    if (cleanQuery.isEmpty) return [];

    final results = <SearchResult>[];

    // 1. Search Scripture Verses (unless notes-only requested)
    if (!searchNotesOnly) {
      final allVerses = ScriptureRepository.getAllSearchableVerses();
      for (final v in allVerses) {
        if (volumeFilter != null && v.volumeId != volumeFilter) {
          continue;
        }

        if (v.text.toLowerCase().contains(cleanQuery)) {
          final volume = ScriptureCanon.getVolume(v.volumeId);
          final book = ScriptureCanon.getBook(v.volumeId, v.bookId);

          results.add(SearchResult(
            volumeTitle: volume.shortTitle,
            bookTitle: book?.title ?? v.bookId,
            chapter: v.chapter,
            verseNumber: v.verseNumber,
            verseText: v.text,
          ));
        }
      }
    }

    // 2. Search User Notes & Annotations
    for (final ann in _annotations.values) {
      if (volumeFilter != null && ann.volumeId != volumeFilter) {
        continue;
      }

      if (ann.note != null && ann.note!.toLowerCase().contains(cleanQuery)) {
        final volume = ScriptureCanon.getVolume(ann.volumeId);
        final book = ScriptureCanon.getBook(ann.volumeId, ann.bookId);
        final verses = ScriptureRepository.getChapterVerses(ann.volumeId, ann.bookId, ann.chapter);
        final verseText = verses.firstWhere(
          (v) => v.verseNumber == ann.verseNumber,
          orElse: () => ScriptureVerse(
            volumeId: ann.volumeId,
            bookId: ann.bookId,
            chapter: ann.chapter,
            verseNumber: ann.verseNumber,
            text: 'Verse ${ann.verseNumber}',
          ),
        ).text;

        results.add(SearchResult(
          volumeTitle: volume.shortTitle,
          bookTitle: book?.title ?? ann.bookId,
          chapter: ann.chapter,
          verseNumber: ann.verseNumber,
          verseText: verseText,
          matchedNote: ann.note,
          isNoteMatch: true,
        ));
      }
    }

    return results;
  }
}

import 'package:flutter/material.dart';
import '../models/scripture_models.dart';
import '../data/scripture_canon.dart';
import '../data/scripture_repository.dart';
import '../data/scripture_footnotes.dart';
import '../data/scripture_dictionary.dart';

/// Global application state managing navigation, reading styles, annotations,
/// tags, cross-reference links, footnotes, and search.
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
  String _fontFamilyOption = 'serif'; // 'sansSerif', 'serif', 'georgia'
  double _fontSize = 17.0;

  // Annotations (Key format: "volumeId:bookId:chapter:verseNumber")
  final Map<String, VerseAnnotation> _annotations = {};

  // Default demo tags and links for immediate testing
  AppState() {
    _initSeedAnnotations();
  }

  void _initSeedAnnotations() {
    // Tag 1 Nephi 3:7 with "Commandments" and "Faith"
    const key1 = 'bom:1-ne:3:7';
    _annotations[key1] = VerseAnnotation(
      id: key1,
      volumeId: 'bom', bookId: '1-ne', chapter: 3, verseNumber: 7,
      highlightColor: HighlightColor.yellow,
      note: 'I will go and do — Nephi demonstrates unquestioning faith and trust in the Lord.',
      tags: ['Commandments', 'Faith', 'Obedience'],
      linkedVerseKeys: ['nt:phil:4:13', 'ot:prov:3:6'],
      updatedAt: DateTime.now(),
    );

    // Tag Alma 32:21 with "Faith" and link to 1 Nephi 3:7
    const key2 = 'bom:alma:32:21';
    _annotations[key2] = VerseAnnotation(
      id: key2,
      volumeId: 'bom', bookId: 'alma', chapter: 32, verseNumber: 21,
      highlightColor: HighlightColor.blue,
      note: 'Faith is not a perfect knowledge, but a hope in unseen truth.',
      tags: ['Faith', 'Hope'],
      linkedVerseKeys: ['bom:1-ne:3:7'],
      updatedAt: DateTime.now(),
    );

    // Tag James 1:5 with "Prayer" and "Wisdom"
    const key3 = 'nt:james:1:5';
    _annotations[key3] = VerseAnnotation(
      id: key3,
      volumeId: 'nt', bookId: 'james', chapter: 1, verseNumber: 5,
      highlightColor: HighlightColor.green,
      note: 'Ask of God in faith without wavering. The catalyst for the First Vision.',
      tags: ['Prayer', 'Wisdom', 'Revelation'],
      linkedVerseKeys: ['bom:1-ne:3:7'],
      updatedAt: DateTime.now(),
    );
  }

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

  List<String> get allDistinctTags {
    final tagsSet = <String>{};
    for (final ann in _annotations.values) {
      tagsSet.addAll(ann.tags);
    }
    final list = tagsSet.toList()..sort();
    return list;
  }

  List<VerseAnnotation> getVersesForTag(String tag) {
    return _annotations.values
        .where((a) => a.tags.contains(tag))
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

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
      height: 1.68,
      fontWeight: weight ?? FontWeight.normal,
      fontFamilyFallback: familyFallback,
      color: color ?? theme.textTheme.bodyLarge?.color,
    );
  }

  // Annotation Methods
  VerseAnnotation? getAnnotation(String volumeId, String bookId, int chapter, int verseNumber) {
    final key = '$volumeId:$bookId:$chapter:$verseNumber';
    return _annotations[key];
  }

  VerseAnnotation _getOrCreateAnnotation(String volumeId, String bookId, int chapter, int verseNumber) {
    final key = '$volumeId:$bookId:$chapter:$verseNumber';
    if (!_annotations.containsKey(key)) {
      _annotations[key] = VerseAnnotation(
        id: key,
        volumeId: volumeId,
        bookId: bookId,
        chapter: chapter,
        verseNumber: verseNumber,
        updatedAt: DateTime.now(),
      );
    }
    return _annotations[key]!;
  }

  void setHighlight(String volumeId, String bookId, int chapter, int verseNumber, HighlightColor? color) {
    final key = '$volumeId:$bookId:$chapter:$verseNumber';
    final existing = _getOrCreateAnnotation(volumeId, bookId, chapter, verseNumber);
    _annotations[key] = existing.copyWith(
      highlightColor: color,
      clearHighlight: color == null,
    );
    notifyListeners();
  }

  void setNote(String volumeId, String bookId, int chapter, int verseNumber, String? noteText) {
    final key = '$volumeId:$bookId:$chapter:$verseNumber';
    final existing = _getOrCreateAnnotation(volumeId, bookId, chapter, verseNumber);
    final trimmed = noteText?.trim();
    _annotations[key] = existing.copyWith(
      note: trimmed,
      clearNote: trimmed == null || trimmed.isEmpty,
    );
    notifyListeners();
  }

  void addTag(String volumeId, String bookId, int chapter, int verseNumber, String tag) {
    final cleanTag = tag.trim();
    if (cleanTag.isEmpty) return;
    final key = '$volumeId:$bookId:$chapter:$verseNumber';
    final existing = _getOrCreateAnnotation(volumeId, bookId, chapter, verseNumber);
    if (!existing.tags.contains(cleanTag)) {
      final updatedTags = List<String>.from(existing.tags)..add(cleanTag);
      _annotations[key] = existing.copyWith(tags: updatedTags);
      notifyListeners();
    }
  }

  void removeTag(String volumeId, String bookId, int chapter, int verseNumber, String tag) {
    final key = '$volumeId:$bookId:$chapter:$verseNumber';
    final existing = _annotations[key];
    if (existing != null && existing.tags.contains(tag)) {
      final updatedTags = List<String>.from(existing.tags)..remove(tag);
      _annotations[key] = existing.copyWith(tags: updatedTags);
      notifyListeners();
    }
  }

  void linkVerses(String sourceKey, String targetKey) {
    if (sourceKey == targetKey) return;
    final parts = sourceKey.split(':');
    if (parts.length != 4) return;
    final existing = _getOrCreateAnnotation(parts[0], parts[1], int.parse(parts[2]), int.parse(parts[3]));

    if (!existing.linkedVerseKeys.contains(targetKey)) {
      final updated = List<String>.from(existing.linkedVerseKeys)..add(targetKey);
      _annotations[sourceKey] = existing.copyWith(linkedVerseKeys: updated);
      notifyListeners();
    }
  }

  void unlinkVerse(String sourceKey, String targetKey) {
    final existing = _annotations[sourceKey];
    if (existing != null && existing.linkedVerseKeys.contains(targetKey)) {
      final updated = List<String>.from(existing.linkedVerseKeys)..remove(targetKey);
      _annotations[sourceKey] = existing.copyWith(linkedVerseKeys: updated);
      notifyListeners();
    }
  }

  // Official Church-Style Footnotes
  List<ScriptureFootnote> getFootnotes(String volumeId, String bookId, int chapter, int verseNumber) {
    return ScriptureFootnotes.getFootnotesForVerse(volumeId, bookId, chapter, verseNumber);
  }

  ScriptureFootnote? findFootnoteByWord(String volumeId, String bookId, int chapter, int verseNumber, String word) {
    return ScriptureFootnotes.findFootnoteByWord(volumeId, bookId, chapter, verseNumber, word);
  }

  // On-Device Dictionary
  DictionaryEntry lookupDictionary(String word) {
    return ScriptureDictionary.lookup(word);
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

    // 1. Search Scripture Verses
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

    // 2. Search Notes & Tags
    for (final ann in _annotations.values) {
      if (volumeFilter != null && ann.volumeId != volumeFilter) {
        continue;
      }

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

      // Note match
      if (ann.note != null && ann.note!.toLowerCase().contains(cleanQuery)) {
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

      // Tag match
      for (final tag in ann.tags) {
        if (tag.toLowerCase().contains(cleanQuery)) {
          results.add(SearchResult(
            volumeTitle: volume.shortTitle,
            bookTitle: book?.title ?? ann.bookId,
            chapter: ann.chapter,
            verseNumber: ann.verseNumber,
            verseText: verseText,
            matchedTag: tag,
            isTagMatch: true,
          ));
          break;
        }
      }
    }

    return results;
  }
}

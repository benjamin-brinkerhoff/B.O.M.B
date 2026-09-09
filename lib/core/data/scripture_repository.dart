import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/scripture_models.dart';
import 'scripture_canon.dart';

/// Repository managing full offline scripture text loading, caching, and searching.
class ScriptureRepository {
  // In-memory cache: volumeId -> bookTitle -> chapterNumber -> List<ScriptureVerse>
  static final Map<String, Map<String, Map<int, List<ScriptureVerse>>>> _volumeCache = {};
  static final Set<String> _loadingVolumes = {};
  static final Set<String> _loadedVolumes = {};
  static final List<ScriptureVerse> _allLoadedVerses = [];

  // Book title aliases between canon and JSON datasets
  static const Map<String, String> _titleAliases = {
    'Song of Solomon': "Solomon's Song",
    "Solomon's Song": 'Song of Solomon',
  };

  static bool isVolumeLoaded(String volumeId) => _loadedVolumes.contains(volumeId);
  static int get totalLoadedVerses => _allLoadedVerses.length;

  /// Preload primary scripture volumes on startup
  static Future<void> initialize() async {
    // Load Book of Mormon and New Testament on launch
    await Future.wait([
      initializeVolume('bom'),
      initializeVolume('nt'),
    ]);
    // Lazy-load Old Testament in background
    initializeVolume('ot');
  }

  /// Asynchronously load a volume from bundled asset JSON
  static Future<void> initializeVolume(String volumeId) async {
    if (_loadedVolumes.contains(volumeId) || _loadingVolumes.contains(volumeId)) {
      return;
    }
    _loadingVolumes.add(volumeId);

    String assetPath;
    switch (volumeId) {
      case 'bom':
        assetPath = 'assets/scriptures/book_of_mormon.json';
        break;
      case 'nt':
        assetPath = 'assets/scriptures/new_testament.json';
        break;
      case 'ot':
        assetPath = 'assets/scriptures/old_testament.json';
        break;
      default:
        _loadingVolumes.remove(volumeId);
        return;
    }

    try {
      final jsonString = await rootBundle.loadString(assetPath);
      final dynamic decoded = jsonDecode(jsonString);

      if (decoded is Map<String, dynamic>) {
        final bookMap = <String, Map<int, List<ScriptureVerse>>>{};

        decoded.forEach((bookName, bookData) {
          if (bookData is! Map<String, dynamic>) return;

          final chapterMap = <int, List<ScriptureVerse>>{};

          bookData.forEach((chapterKey, chapterData) {
            final chapterNum = int.tryParse(chapterKey);
            if (chapterNum == null || chapterData is! Map<String, dynamic>) return;

            final verseList = <ScriptureVerse>[];
            final sortedKeys = chapterData.keys
                .where((k) => int.tryParse(k) != null)
                .map((k) => int.parse(k))
                .toList()
              ..sort();

            final bookId = _resolveBookId(volumeId, bookName);

            for (final vNum in sortedKeys) {
              final text = chapterData[vNum.toString()];
              if (text is String && text.trim().isNotEmpty) {
                final verse = ScriptureVerse(
                  volumeId: volumeId,
                  bookId: bookId,
                  chapter: chapterNum,
                  verseNumber: vNum,
                  text: text,
                );
                verseList.add(verse);
                _allLoadedVerses.add(verse);
              }
            }

            if (verseList.isNotEmpty) {
              chapterMap[chapterNum] = verseList;
            }
          });

          bookMap[bookName] = chapterMap;
          if (_titleAliases.containsKey(bookName)) {
            bookMap[_titleAliases[bookName]!] = chapterMap;
          }
        });

        _volumeCache[volumeId] = bookMap;
        _loadedVolumes.add(volumeId);
      }
    } catch (_) {
      // Graceful fallback if running in unit test or asset bundle unavailable
    } finally {
      _loadingVolumes.remove(volumeId);
    }
  }

  static String _resolveBookId(String volumeId, String bookName) {
    final vol = ScriptureCanon.getVolume(volumeId);
    final alias = _titleAliases[bookName];
    final book = vol.books.firstWhere(
      (b) => b.title.toLowerCase() == bookName.toLowerCase() ||
             (alias != null && b.title.toLowerCase() == alias.toLowerCase()),
      orElse: () => vol.books.isNotEmpty
          ? vol.books.first
          : ScriptureBook(id: bookName, title: bookName, abbreviation: bookName, volumeId: volumeId, chapterCount: 1),
    );
    return book.id;
  }

  /// Synchronous reader access with immediate cache retrieval
  static List<ScriptureVerse> getChapterVerses(String volumeId, String bookId, int chapter) {
    final book = ScriptureCanon.getBook(volumeId, bookId);
    final bookTitle = book?.title ?? bookId;

    // 1. Check in-memory parsed volume cache
    final volData = _volumeCache[volumeId];
    if (volData != null) {
      final bookData = volData[bookTitle] ?? volData[_titleAliases[bookTitle]];
      if (bookData != null && bookData.containsKey(chapter)) {
        return bookData[chapter]!;
      }
    }

    // 2. Trigger asynchronous load if not already in progress
    if (!_loadedVolumes.contains(volumeId) && !_loadingVolumes.contains(volumeId)) {
      initializeVolume(volumeId);
    }

    // 3. Fallback to seed verses if available
    final seedMatches = _seedVerses.where(
      (v) => v.volumeId == volumeId && v.bookId == bookId && v.chapter == chapter,
    ).toList();
    if (seedMatches.isNotEmpty) {
      return seedMatches;
    }

    // 4. Fallback placeholder while asset is loading into memory
    return List.generate(8, (index) {
      final vNum = index + 1;
      return ScriptureVerse(
        volumeId: volumeId,
        bookId: bookId,
        chapter: chapter,
        verseNumber: vNum,
        text: 'Verse $vNum of $bookTitle Chapter $chapter. (Loading text...)',
      );
    });
  }

  /// Explicit async loader
  static Future<List<ScriptureVerse>> loadChapterVerses(String volumeId, String bookId, int chapter) async {
    await initializeVolume(volumeId);
    return getChapterVerses(volumeId, bookId, chapter);
  }

  /// Returns all searchable verses (entire canon when loaded)
  static List<ScriptureVerse> getAllSearchableVerses() {
    if (_allLoadedVerses.isNotEmpty) {
      return _allLoadedVerses;
    }
    return _seedVerses;
  }

  // Pre-seeded fallback verses for immediate rendering before assets load
  static final List<ScriptureVerse> _seedVerses = [
    const ScriptureVerse(
      volumeId: 'bom', bookId: '1-ne', chapter: 1, verseNumber: 1,
      text: 'I, Nephi, having been born of goodly parents, therefore I was taught somewhat in all the learning of my father; and having seen many afflictions in the course of my days, nevertheless, having been highly favored of the Lord in all my days; yea, having had a great knowledge of the goodness and the mysteries of God, therefore I make a record of my proceedings in my days.',
    ),
    const ScriptureVerse(
      volumeId: 'bom', bookId: '1-ne', chapter: 3, verseNumber: 7,
      text: 'And it came to pass that I, Nephi, said unto my father: I will go and do the things which the Lord hath commanded, for I know that the Lord giveth no commandments unto the children of men, save he shall prepare a way for them that they may accomplish the thing which he commandeth them.',
    ),
    const ScriptureVerse(
      volumeId: 'bom', bookId: '2-ne', chapter: 2, verseNumber: 25,
      text: 'Adam fell that men might be; and men are, that they might have joy.',
    ),
    const ScriptureVerse(
      volumeId: 'bom', bookId: '2-ne', chapter: 31, verseNumber: 20,
      text: 'Wherefore, ye must press forward with a steadfastness in Christ, having a perfect brightness of hope, and a love of God and of all men. Wherefore, if ye shall press forward, feasting upon the word of Christ, and endure to the end, behold, thus saith the Father: Ye shall have eternal life.',
    ),
    const ScriptureVerse(
      volumeId: 'bom', bookId: 'alma', chapter: 32, verseNumber: 21,
      text: 'And now as I said concerning faith—faith is not to have a perfect knowledge of things; therefore if ye have faith ye hope for things which are not seen, which are true.',
    ),
    const ScriptureVerse(
      volumeId: 'bom', bookId: '3-ne', chapter: 11, verseNumber: 11,
      text: 'And behold, I am the light and the life of the world; and I have drunk out of that bitter cup which the Father hath given me, and have glorified the Father in taking upon me the sins of the world, in the which I have suffered the will of the Father in all things from the beginning.',
    ),
    const ScriptureVerse(
      volumeId: 'ot', bookId: 'gen', chapter: 1, verseNumber: 1,
      text: 'In the beginning God created the heaven and the earth.',
    ),
    const ScriptureVerse(
      volumeId: 'ot', bookId: 'ps', chapter: 23, verseNumber: 1,
      text: 'The LORD is my shepherd; I shall not want.',
    ),
    const ScriptureVerse(
      volumeId: 'ot', bookId: 'isa', chapter: 2, verseNumber: 2,
      text: 'And it shall come to pass in the last days, that the mountain of the LORD’s house shall be established in the top of the mountains, and shall be exalted above the hills; and all nations shall flow unto it.',
    ),
    const ScriptureVerse(
      volumeId: 'nt', bookId: 'matt', chapter: 5, verseNumber: 14,
      text: 'Ye are the light of the world. A city that is set on an hill cannot be hid.',
    ),
    const ScriptureVerse(
      volumeId: 'nt', bookId: 'john', chapter: 3, verseNumber: 16,
      text: 'For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life.',
    ),
    const ScriptureVerse(
      volumeId: 'nt', bookId: '1-cor', chapter: 13, verseNumber: 13,
      text: 'And now abideth faith, hope, charity, these three; but the greatest of these is charity.',
    ),
    const ScriptureVerse(
      volumeId: 'nt', bookId: 'james', chapter: 1, verseNumber: 5,
      text: 'If any of you lack wisdom, let him ask of God, that giveth to all men liberally, and upbraideth not; and it shall be given him.',
    ),
  ];
}

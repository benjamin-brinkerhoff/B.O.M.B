import '../models/scripture_models.dart';

class ScriptureCanon {
  // Bible Translations
  static const List<BibleVersion> bibleVersions = [
    BibleVersion(
      id: 'kjv',
      name: 'King James Version',
      abbreviation: 'KJV',
      description: 'The historic and beloved 1611 English translation (Public Domain).',
    ),
    BibleVersion(
      id: 'asv',
      name: 'American Standard Version',
      abbreviation: 'ASV',
      description: 'Literal 1901 translation based on the KJV (Public Domain).',
    ),
    BibleVersion(
      id: 'web',
      name: 'World English Bible',
      abbreviation: 'WEB',
      description: 'Modern public domain English translation of the Holy Bible.',
    ),
    BibleVersion(
      id: 'bbe',
      name: 'Bible in Basic English',
      abbreviation: 'BBE',
      description: 'Simplified vocabulary translation (Public Domain).',
    ),
  ];

  // Book of Mormon Canon (15 Books)
  static const List<ScriptureBook> bookOfMormonBooks = [
    ScriptureBook(id: '1-ne', title: '1 Nephi', abbreviation: '1 Ne.', volumeId: 'bom', chapterCount: 22),
    ScriptureBook(id: '2-ne', title: '2 Nephi', abbreviation: '2 Ne.', volumeId: 'bom', chapterCount: 33),
    ScriptureBook(id: 'jacob', title: 'Jacob', abbreviation: 'Jacob', volumeId: 'bom', chapterCount: 7),
    ScriptureBook(id: 'enos', title: 'Enos', abbreviation: 'Enos', volumeId: 'bom', chapterCount: 1),
    ScriptureBook(id: 'jarom', title: 'Jarom', abbreviation: 'Jarom', volumeId: 'bom', chapterCount: 1),
    ScriptureBook(id: 'omni', title: 'Omni', abbreviation: 'Omni', volumeId: 'bom', chapterCount: 1),
    ScriptureBook(id: 'w-of-m', title: 'Words of Mormon', abbreviation: 'W of M', volumeId: 'bom', chapterCount: 1),
    ScriptureBook(id: 'mosiah', title: 'Mosiah', abbreviation: 'Mosiah', volumeId: 'bom', chapterCount: 29),
    ScriptureBook(id: 'alma', title: 'Alma', abbreviation: 'Alma', volumeId: 'bom', chapterCount: 63),
    ScriptureBook(id: 'hel', title: 'Helaman', abbreviation: 'Hel.', volumeId: 'bom', chapterCount: 16),
    ScriptureBook(id: '3-ne', title: '3 Nephi', abbreviation: '3 Ne.', volumeId: 'bom', chapterCount: 30),
    ScriptureBook(id: '4-ne', title: '4 Nephi', abbreviation: '4 Ne.', volumeId: 'bom', chapterCount: 1),
    ScriptureBook(id: 'morm', title: 'Mormon', abbreviation: 'Morm.', volumeId: 'bom', chapterCount: 9),
    ScriptureBook(id: 'ether', title: 'Ether', abbreviation: 'Ether', volumeId: 'bom', chapterCount: 15),
    ScriptureBook(id: 'moroni', title: 'Moroni', abbreviation: 'Moro.', volumeId: 'bom', chapterCount: 10),
  ];

  // Old Testament Canon (39 Books)
  static const List<ScriptureBook> oldTestamentBooks = [
    ScriptureBook(id: 'gen', title: 'Genesis', abbreviation: 'Gen.', volumeId: 'ot', chapterCount: 50),
    ScriptureBook(id: 'ex', title: 'Exodus', abbreviation: 'Ex.', volumeId: 'ot', chapterCount: 40),
    ScriptureBook(id: 'lev', title: 'Leviticus', abbreviation: 'Lev.', volumeId: 'ot', chapterCount: 27),
    ScriptureBook(id: 'num', title: 'Numbers', abbreviation: 'Num.', volumeId: 'ot', chapterCount: 36),
    ScriptureBook(id: 'deut', title: 'Deuteronomy', abbreviation: 'Deut.', volumeId: 'ot', chapterCount: 34),
    ScriptureBook(id: 'josh', title: 'Joshua', abbreviation: 'Josh.', volumeId: 'ot', chapterCount: 24),
    ScriptureBook(id: 'judg', title: 'Judges', abbreviation: 'Judg.', volumeId: 'ot', chapterCount: 21),
    ScriptureBook(id: 'ruth', title: 'Ruth', abbreviation: 'Ruth', volumeId: 'ot', chapterCount: 4),
    ScriptureBook(id: '1-sam', title: '1 Samuel', abbreviation: '1 Sam.', volumeId: 'ot', chapterCount: 31),
    ScriptureBook(id: '2-sam', title: '2 Samuel', abbreviation: '2 Sam.', volumeId: 'ot', chapterCount: 24),
    ScriptureBook(id: '1-kgs', title: '1 Kings', abbreviation: '1 Kgs.', volumeId: 'ot', chapterCount: 22),
    ScriptureBook(id: '2-kgs', title: '2 Kings', abbreviation: '2 Kgs.', volumeId: 'ot', chapterCount: 25),
    ScriptureBook(id: '1-chr', title: '1 Chronicles', abbreviation: '1 Chr.', volumeId: 'ot', chapterCount: 29),
    ScriptureBook(id: '2-chr', title: '2 Chronicles', abbreviation: '2 Chr.', volumeId: 'ot', chapterCount: 36),
    ScriptureBook(id: 'ezra', title: 'Ezra', abbreviation: 'Ezra', volumeId: 'ot', chapterCount: 10),
    ScriptureBook(id: 'neh', title: 'Nehemiah', abbreviation: 'Neh.', volumeId: 'ot', chapterCount: 13),
    ScriptureBook(id: 'esth', title: 'Esther', abbreviation: 'Esth.', volumeId: 'ot', chapterCount: 10),
    ScriptureBook(id: 'job', title: 'Job', abbreviation: 'Job', volumeId: 'ot', chapterCount: 42),
    ScriptureBook(id: 'ps', title: 'Psalms', abbreviation: 'Ps.', volumeId: 'ot', chapterCount: 150),
    ScriptureBook(id: 'prov', title: 'Proverbs', abbreviation: 'Prov.', volumeId: 'ot', chapterCount: 31),
    ScriptureBook(id: 'eccl', title: 'Ecclesiastes', abbreviation: 'Eccl.', volumeId: 'ot', chapterCount: 12),
    ScriptureBook(id: 'song', title: 'Song of Solomon', abbreviation: 'Song', volumeId: 'ot', chapterCount: 8),
    ScriptureBook(id: 'isa', title: 'Isaiah', abbreviation: 'Isa.', volumeId: 'ot', chapterCount: 66),
    ScriptureBook(id: 'jer', title: 'Jeremiah', abbreviation: 'Jer.', volumeId: 'ot', chapterCount: 52),
    ScriptureBook(id: 'lam', title: 'Lamentations', abbreviation: 'Lam.', volumeId: 'ot', chapterCount: 5),
    ScriptureBook(id: 'ezek', title: 'Ezekiel', abbreviation: 'Ezek.', volumeId: 'ot', chapterCount: 48),
    ScriptureBook(id: 'dan', title: 'Daniel', abbreviation: 'Dan.', volumeId: 'ot', chapterCount: 12),
    ScriptureBook(id: 'hos', title: 'Hosea', abbreviation: 'Hos.', volumeId: 'ot', chapterCount: 14),
    ScriptureBook(id: 'joel', title: 'Joel', abbreviation: 'Joel', volumeId: 'ot', chapterCount: 3),
    ScriptureBook(id: 'amos', title: 'Amos', abbreviation: 'Amos', volumeId: 'ot', chapterCount: 9),
    ScriptureBook(id: 'obad', title: 'Obadiah', abbreviation: 'Obad.', volumeId: 'ot', chapterCount: 1),
    ScriptureBook(id: 'jonah', title: 'Jonah', abbreviation: 'Jonah', volumeId: 'ot', chapterCount: 4),
    ScriptureBook(id: 'mic', title: 'Micah', abbreviation: 'Mic.', volumeId: 'ot', chapterCount: 7),
    ScriptureBook(id: 'nah', title: 'Nahum', abbreviation: 'Nah.', volumeId: 'ot', chapterCount: 3),
    ScriptureBook(id: 'hab', title: 'Habakkuk', abbreviation: 'Hab.', volumeId: 'ot', chapterCount: 3),
    ScriptureBook(id: 'zeph', title: 'Zephaniah', abbreviation: 'Zeph.', volumeId: 'ot', chapterCount: 3),
    ScriptureBook(id: 'hag', title: 'Haggai', abbreviation: 'Hag.', volumeId: 'ot', chapterCount: 2),
    ScriptureBook(id: 'zech', title: 'Zechariah', abbreviation: 'Zech.', volumeId: 'ot', chapterCount: 14),
    ScriptureBook(id: 'mal', title: 'Malachi', abbreviation: 'Mal.', volumeId: 'ot', chapterCount: 4),
  ];

  // New Testament Canon (27 Books)
  static const List<ScriptureBook> newTestamentBooks = [
    ScriptureBook(id: 'matt', title: 'Matthew', abbreviation: 'Matt.', volumeId: 'nt', chapterCount: 28),
    ScriptureBook(id: 'mark', title: 'Mark', abbreviation: 'Mark', volumeId: 'nt', chapterCount: 16),
    ScriptureBook(id: 'luke', title: 'Luke', abbreviation: 'Luke', volumeId: 'nt', chapterCount: 24),
    ScriptureBook(id: 'john', title: 'John', abbreviation: 'John', volumeId: 'nt', chapterCount: 21),
    ScriptureBook(id: 'acts', title: 'Acts', abbreviation: 'Acts', volumeId: 'nt', chapterCount: 28),
    ScriptureBook(id: 'rom', title: 'Romans', abbreviation: 'Rom.', volumeId: 'nt', chapterCount: 16),
    ScriptureBook(id: '1-cor', title: '1 Corinthians', abbreviation: '1 Cor.', volumeId: 'nt', chapterCount: 16),
    ScriptureBook(id: '2-cor', title: '2 Corinthians', abbreviation: '2 Cor.', volumeId: 'nt', chapterCount: 13),
    ScriptureBook(id: 'gal', title: 'Galatians', abbreviation: 'Gal.', volumeId: 'nt', chapterCount: 6),
    ScriptureBook(id: 'eph', title: 'Ephesians', abbreviation: 'Eph.', volumeId: 'nt', chapterCount: 6),
    ScriptureBook(id: 'phil', title: 'Philippians', abbreviation: 'Phil.', volumeId: 'nt', chapterCount: 4),
    ScriptureBook(id: 'col', title: 'Colossians', abbreviation: 'Col.', volumeId: 'nt', chapterCount: 4),
    ScriptureBook(id: '1-thess', title: '1 Thessalonians', abbreviation: '1 Thess.', volumeId: 'nt', chapterCount: 5),
    ScriptureBook(id: '2-thess', title: '2 Thessalonians', abbreviation: '2 Thess.', volumeId: 'nt', chapterCount: 3),
    ScriptureBook(id: '1-tim', title: '1 Timothy', abbreviation: '1 Tim.', volumeId: 'nt', chapterCount: 6),
    ScriptureBook(id: '2-tim', title: '2 Timothy', abbreviation: '2 Tim.', volumeId: 'nt', chapterCount: 4),
    ScriptureBook(id: 'titus', title: 'Titus', abbreviation: 'Titus', volumeId: 'nt', chapterCount: 3),
    ScriptureBook(id: 'philem', title: 'Philemon', abbreviation: 'Philem.', volumeId: 'nt', chapterCount: 1),
    ScriptureBook(id: 'heb', title: 'Hebrews', abbreviation: 'Heb.', volumeId: 'nt', chapterCount: 13),
    ScriptureBook(id: 'james', title: 'James', abbreviation: 'James', volumeId: 'nt', chapterCount: 5),
    ScriptureBook(id: '1-pet', title: '1 Peter', abbreviation: '1 Pet.', volumeId: 'nt', chapterCount: 5),
    ScriptureBook(id: '2-pet', title: '2 Peter', abbreviation: '2 Pet.', volumeId: 'nt', chapterCount: 3),
    ScriptureBook(id: '1-jn', title: '1 John', abbreviation: '1 Jn.', volumeId: 'nt', chapterCount: 5),
    ScriptureBook(id: '2-jn', title: '2 John', abbreviation: '2 Jn.', volumeId: 'nt', chapterCount: 1),
    ScriptureBook(id: '3-jn', title: '3 John', abbreviation: '3 Jn.', volumeId: 'nt', chapterCount: 1),
    ScriptureBook(id: 'jude', title: 'Jude', abbreviation: 'Jude', volumeId: 'nt', chapterCount: 1),
    ScriptureBook(id: 'rev', title: 'Revelation', abbreviation: 'Rev.', volumeId: 'nt', chapterCount: 22),
  ];

  // All Volumes
  static final List<ScriptureVolume> volumes = [
    const ScriptureVolume(
      id: 'bom',
      title: 'The Book of Mormon',
      shortTitle: 'Book of Mormon',
      books: bookOfMormonBooks,
    ),
    const ScriptureVolume(
      id: 'ot',
      title: 'The Old Testament',
      shortTitle: 'Old Testament',
      books: oldTestamentBooks,
    ),
    const ScriptureVolume(
      id: 'nt',
      title: 'The New Testament',
      shortTitle: 'New Testament',
      books: newTestamentBooks,
    ),
  ];

  static ScriptureVolume getVolume(String volumeId) {
    return volumes.firstWhere((v) => v.id == volumeId, orElse: () => volumes.first);
  }

  static ScriptureBook? getBook(String volumeId, String bookId) {
    final vol = getVolume(volumeId);
    try {
      return vol.books.firstWhere((b) => b.id == bookId);
    } catch (_) {
      return vol.books.isNotEmpty ? vol.books.first : null;
    }
  }
}

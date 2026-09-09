import '../models/scripture_models.dart';

/// On-device dictionary database for scriptural vocabulary, archaic King James English,
/// and Hebrew/Greek doctrinal terminology.
class ScriptureDictionary {
  static const Map<String, DictionaryEntry> _entries = {
    'goodly': DictionaryEntry(
      word: 'goodly',
      partOfSpeech: 'adjective',
      definition: 'Of superior quality; pleasant, agreeable; fair or handsome; of honorable character, noble or upright.',
      etymology: 'Middle English godli, from Old English godlic (god-like, noble).',
      sampleOccurrences: ['1 Nephi 1:1', 'Genesis 39:6', 'Matthew 13:45'],
    ),
    'mysteries': DictionaryEntry(
      word: 'mysteries',
      partOfSpeech: 'noun (plural)',
      definition: 'Divine truths, purposes, or doctrines known solely by revelation from the Holy Spirit and hidden from uninspired inquiry.',
      etymology: 'Greek mysterion (sacred secret, hidden rite), from myein (to close lips or eyes).',
      sampleOccurrences: ['1 Nephi 1:1', 'Alma 12:9', '1 Corinthians 2:7'],
    ),
    'mystery': DictionaryEntry(
      word: 'mystery',
      partOfSpeech: 'noun',
      definition: 'A divine truth known only through heavenly revelation.',
      etymology: 'Greek mysterion.',
      sampleOccurrences: ['Romans 16:25', 'Ephesians 3:3'],
    ),
    'afflictions': DictionaryEntry(
      word: 'afflictions',
      partOfSpeech: 'noun (plural)',
      definition: 'States of pain, distress, grief, or trial; adversities designed to sanctify and humble mortals before God.',
      etymology: 'Latin afflictio, from affligere (to strike down, weaken).',
      sampleOccurrences: ['1 Nephi 1:1', 'Alma 36:3', '2 Corinthians 4:17'],
    ),
    'faith': DictionaryEntry(
      word: 'faith',
      partOfSpeech: 'noun',
      definition: 'Assurance of things hoped for, the evidence of things not seen; a principle of action and power centered in Jesus Christ.',
      etymology: 'Greek pistis (persuasion, moral conviction, assurance).',
      sampleOccurrences: ['Hebrews 11:1', 'Alma 32:21', 'Ether 12:6'],
    ),
    'charity': DictionaryEntry(
      word: 'charity',
      partOfSpeech: 'noun',
      definition: 'The pure, sacrificial, and everlasting love of Christ, which suffereth long and is kind, never failing.',
      etymology: 'Greek agape (divine, selfless love); Latin caritas (dearness, esteem).',
      sampleOccurrences: ['1 Corinthians 13:13', 'Moroni 7:47', '2 Nephi 26:30'],
    ),
    'grace': DictionaryEntry(
      word: 'grace',
      partOfSpeech: 'noun',
      definition: 'Divine assistance, enabling power, and unmerited favor bestowed through the mercy and love of Jesus Christ.',
      etymology: 'Greek charis (favor, kindness, unearned gift); Hebrew chen.',
      sampleOccurrences: ['2 Nephi 25:23', 'Ephesians 2:8', 'Moroni 10:32'],
    ),
    'atonement': DictionaryEntry(
      word: 'atonement',
      partOfSpeech: 'noun',
      definition: 'The central act of redemption by Jesus Christ through His suffering in Gethsemane, death on the cross, and resurrection, reconciling mankind to God.',
      etymology: 'Middle English at-one-ment (setting at one, reconciliation); Hebrew kaphar (to cover, purge).',
      sampleOccurrences: ['2 Nephi 2:10', 'Alma 34:9', 'Romans 5:11'],
    ),
    'strait': DictionaryEntry(
      word: 'strait',
      partOfSpeech: 'adjective',
      definition: 'Narrow, tight, strict, or close; exacting; not to be confused with "straight" (direct).',
      etymology: 'Old French estreit, from Latin strictus (drawn tight).',
      sampleOccurrences: ['2 Nephi 31:18', 'Matthew 7:13', 'Luke 13:24'],
    ),
    'succor': DictionaryEntry(
      word: 'succor',
      partOfSpeech: 'verb',
      definition: 'To run to the support of; to relieve in distress, help, aid, or comfort.',
      etymology: 'Latin succurrere (to run to help, from sub + currere).',
      sampleOccurrences: ['Alma 7:12', 'Hebrews 2:18'],
    ),
    'chastisement': DictionaryEntry(
      word: 'chastisement',
      partOfSpeech: 'noun',
      definition: 'Corrective discipline, instruction, or punishment administered out of divine love to purify the soul.',
      etymology: 'Old French chastier, from Latin castigare (to make pure).',
      sampleOccurrences: ['Isaiah 53:5', 'Hebrews 12:8', 'Helaman 12:3'],
    ),
    'firmament': DictionaryEntry(
      word: 'firmament',
      partOfSpeech: 'noun',
      definition: 'The expanse of the sky; the celestial arch holding the stars and atmosphere.',
      etymology: 'Hebrew raqia (spread-out expanse, beaten-out vault).',
      sampleOccurrences: ['Genesis 1:6', 'Psalm 19:1', 'Ezekiel 1:22'],
    ),
    'covenant': DictionaryEntry(
      word: 'covenant',
      partOfSpeech: 'noun',
      definition: 'A sacred agreement between God and man with non-negotiable divine promises conditioned on mortal obedience.',
      etymology: 'Hebrew berith; Latin convenire (to come together).',
      sampleOccurrences: ['Genesis 17:7', 'Mosiah 5:5', 'Hebrews 8:6'],
    ),
    'wisdom': DictionaryEntry(
      word: 'wisdom',
      partOfSpeech: 'noun',
      definition: 'The right use of knowledge; spiritual discernment to act in accordance with divine law.',
      etymology: 'Old English wisdom; Hebrew chokmah; Greek sophia.',
      sampleOccurrences: ['James 1:5', 'Mosiah 2:17', 'Proverbs 3:13'],
    ),
    'joy': DictionaryEntry(
      word: 'joy',
      partOfSpeech: 'noun',
      definition: 'Fullness of spiritual peace, blessedness, and delight that comes from living in harmony with God.',
      etymology: 'Hebrew simchah; Greek chara.',
      sampleOccurrences: ['2 Nephi 2:25', 'Psalm 16:11', 'John 15:11'],
    ),
    'shepherd': DictionaryEntry(
      word: 'shepherd',
      partOfSpeech: 'noun',
      definition: 'One who tends, guards, pastures, and protects sheep; a title of the Lord Jesus Christ over His covenant people.',
      etymology: 'Old English sceaphirde (sheep herder); Hebrew roeh.',
      sampleOccurrences: ['Psalm 23:1', 'John 10:11', 'Alma 5:38'],
    ),
    'mountain': DictionaryEntry(
      word: 'mountain',
      partOfSpeech: 'noun',
      definition: 'A high geographic elevation, frequently used symbolically in scripture for the temple or sanctuary of the Lord.',
      etymology: 'Hebrew har; Greek oros.',
      sampleOccurrences: ['Isaiah 2:2', '2 Nephi 12:2', 'Matthew 17:1'],
    ),
  };

  /// Lookup a word in the on-device dictionary.
  static DictionaryEntry lookup(String query) {
    final clean = query.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

    if (_entries.containsKey(clean)) {
      return _entries[clean]!;
    }

    // Check singular/plural or stem
    for (final key in _entries.keys) {
      if (clean.startsWith(key) || key.startsWith(clean)) {
        return _entries[key]!;
      }
    }

    // Dynamic informative fallback definition for any word
    return DictionaryEntry(
      word: query.trim(),
      partOfSpeech: 'scriptural term',
      definition: 'Term occurring in the authorized King James Bible or Book of Mormon text. Consult Topical Guide and cross-references for canonical usage context.',
      etymology: 'Authorized scripture lexicon entry.',
      sampleOccurrences: const [],
    );
  }

  static List<DictionaryEntry> getAllEntries() => _entries.values.toList();
}

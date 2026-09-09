import '../models/scripture_models.dart';

/// Database of default Latter-day Saint style footnote cross-references, definitions,
/// and Topical Guide links associated with specific words in scripture verses.
class ScriptureFootnotes {
  static final List<ScriptureFootnote> _footnotes = [
    // 1 Nephi 1:1
    const ScriptureFootnote(
      id: '1-ne-1-1-goodly',
      volumeId: 'bom', bookId: '1-ne', chapter: 1, verseNumber: 1,
      word: 'goodly', footnoteKey: '1a',
      definition: 'Archaic English: Noble, righteous, honorable in character and parentage.',
      topicalGuideTopic: 'TG Family',
      references: [
        FootnoteReference(volumeId: 'ot', bookId: 'prov', chapter: 22, verseNumber: 1, displayReference: 'Prov. 22:1', previewText: 'A good name is rather to be chosen than great riches...'),
        FootnoteReference(volumeId: 'bom', bookId: 'alma', chapter: 56, verseNumber: 47, displayReference: 'Alma 56:47', previewText: 'They had been taught by their mothers, that if they did not doubt, God would deliver them.'),
      ],
    ),
    const ScriptureFootnote(
      id: '1-ne-1-1-mysteries',
      volumeId: 'bom', bookId: '1-ne', chapter: 1, verseNumber: 1,
      word: 'mysteries', footnoteKey: '1b',
      definition: 'GR: Mysterion. Divine spiritual truths known only through revelation by the Holy Ghost.',
      topicalGuideTopic: 'TG Mysteries of Godliness',
      references: [
        FootnoteReference(volumeId: 'bom', bookId: 'alma', chapter: 12, verseNumber: 9, displayReference: 'Alma 12:9', previewText: 'It is given unto many to know the mysteries of God; nevertheless they are laid under a strict command...'),
        FootnoteReference(volumeId: 'nt', bookId: '1-cor', chapter: 2, verseNumber: 7, displayReference: '1 Cor. 2:7', previewText: 'We speak the wisdom of God in a mystery, even the hidden wisdom...'),
      ],
    ),

    // 1 Nephi 3:7
    const ScriptureFootnote(
      id: '1-ne-3-7-commanded',
      volumeId: 'bom', bookId: '1-ne', chapter: 3, verseNumber: 7,
      word: 'commanded', footnoteKey: '7a',
      definition: 'Obedience to divine decrees opens heavenly assistance and guidance.',
      topicalGuideTopic: 'TG Commandments of God',
      references: [
        FootnoteReference(volumeId: 'ot', bookId: '1-sam', chapter: 15, verseNumber: 22, displayReference: '1 Sam. 15:22', previewText: 'Behold, to obey is better than sacrifice, and to hearken than the fat of rams.'),
        FootnoteReference(volumeId: 'bom', bookId: 'mosiah', chapter: 2, verseNumber: 22, displayReference: 'Mosiah 2:22', previewText: 'All that he requires of you is to keep his commandments...'),
      ],
    ),
    const ScriptureFootnote(
      id: '1-ne-3-7-prepare',
      volumeId: 'bom', bookId: '1-ne', chapter: 3, verseNumber: 7,
      word: 'prepare', footnoteKey: '7b',
      definition: 'God enables and strengthens those He commissions to fulfill His work.',
      topicalGuideTopic: 'TG Guidance, Divine',
      references: [
        FootnoteReference(volumeId: 'nt', bookId: 'phil', chapter: 4, verseNumber: 13, displayReference: 'Philip. 4:13', previewText: 'I can do all things through Christ which strengtheneth me.'),
        FootnoteReference(volumeId: 'ot', bookId: 'prov', chapter: 3, verseNumber: 6, displayReference: 'Prov. 3:6', previewText: 'In all thy ways acknowledge him, and he shall direct thy paths.'),
      ],
    ),

    // 2 Nephi 2:25
    const ScriptureFootnote(
      id: '2-ne-2-25-joy',
      volumeId: 'bom', bookId: '2-ne', chapter: 2, verseNumber: 25,
      word: 'joy', footnoteKey: '25a',
      definition: 'The fundamental eternal purpose of mortality and redemption through the Fall.',
      topicalGuideTopic: 'TG Joy',
      references: [
        FootnoteReference(volumeId: 'ot', bookId: 'ps', chapter: 16, verseNumber: 11, displayReference: 'Ps. 16:11', previewText: 'In thy presence is fulness of joy; at thy right hand there are pleasures for evermore.'),
        FootnoteReference(volumeId: 'nt', bookId: 'john', chapter: 16, verseNumber: 22, displayReference: 'John 16:22', previewText: 'Your heart shall rejoice, and your joy no man taketh from you.'),
      ],
    ),

    // 2 Nephi 31:20
    const ScriptureFootnote(
      id: '2-ne-31-20-feasting',
      volumeId: 'bom', bookId: '2-ne', chapter: 31, verseNumber: 20,
      word: 'feasting', footnoteKey: '20a',
      definition: 'Partaking abundantly, savoring, and internalizing the gospel doctrine.',
      topicalGuideTopic: 'TG Scriptures, Value of',
      references: [
        FootnoteReference(volumeId: 'ot', bookId: 'jer', chapter: 15, verseNumber: 16, displayReference: 'Jer. 15:16', previewText: 'Thy words were found, and I did eat them; and thy word was unto me the joy and rejoicing of mine heart...'),
        FootnoteReference(volumeId: 'bom', bookId: '2-ne', chapter: 32, verseNumber: 3, displayReference: '2 Ne. 32:3', previewText: 'Feast upon the words of Christ; for behold, the words of Christ will tell you all things what ye should do.'),
      ],
    ),

    // Mosiah 2:17
    const ScriptureFootnote(
      id: 'mosiah-2-17-service',
      volumeId: 'bom', bookId: 'mosiah', chapter: 2, verseNumber: 17,
      word: 'service', footnoteKey: '17a',
      definition: 'Selfless charity towards mankind is accepted directly as adoration of God.',
      topicalGuideTopic: 'TG Service',
      references: [
        FootnoteReference(volumeId: 'nt', bookId: 'matt', chapter: 25, verseNumber: 40, displayReference: 'Matt. 25:40', previewText: 'Inasmuch as ye have done it unto one of the least of these my brethren, ye have done it unto me.'),
        FootnoteReference(volumeId: 'nt', bookId: 'gal', chapter: 5, verseNumber: 13, displayReference: 'Gal. 5:13', previewText: 'By love serve one another.'),
      ],
    ),

    // Alma 32:21
    const ScriptureFootnote(
      id: 'alma-32-21-faith',
      volumeId: 'bom', bookId: 'alma', chapter: 32, verseNumber: 21,
      word: 'faith', footnoteKey: '21a',
      definition: 'GR: Pistis. Assured confidence in unseen spiritual realities substantiated by spiritual witness.',
      topicalGuideTopic: 'TG Faith',
      references: [
        FootnoteReference(volumeId: 'nt', bookId: 'heb', chapter: 11, verseNumber: 1, displayReference: 'Heb. 11:1', previewText: 'Now faith is the substance of things hoped for, the evidence of things not seen.'),
        FootnoteReference(volumeId: 'bom', bookId: 'ether', chapter: 12, verseNumber: 6, displayReference: 'Ether 12:6', previewText: 'Faith is things which are hoped for and not seen; wherefore, dispute not because ye see not...'),
      ],
    ),

    // 3 Nephi 11:11
    const ScriptureFootnote(
      id: '3-ne-11-11-light',
      volumeId: 'bom', bookId: '3-ne', chapter: 11, verseNumber: 11,
      word: 'light', footnoteKey: '11a',
      definition: 'Christ is the ultimate source of spiritual illumination, truth, and resurrection.',
      topicalGuideTopic: 'TG Light',
      references: [
        FootnoteReference(volumeId: 'nt', bookId: 'john', chapter: 8, verseNumber: 12, displayReference: 'John 8:12', previewText: 'I am the light of the world: he that followeth me shall not walk in darkness...'),
        FootnoteReference(volumeId: 'nt', bookId: 'matt', chapter: 5, verseNumber: 14, displayReference: 'Matt. 5:14', previewText: 'Ye are the light of the world. A city that is set on an hill cannot be hid.'),
      ],
    ),

    // Genesis 1:1
    const ScriptureFootnote(
      id: 'gen-1-1-beginning',
      volumeId: 'ot', bookId: 'gen', chapter: 1, verseNumber: 1,
      word: 'beginning', footnoteKey: '1a',
      definition: 'HEB: Bereshit. The inaugural commencement of mortal creation under Christ.',
      topicalGuideTopic: 'TG Creation',
      references: [
        FootnoteReference(volumeId: 'nt', bookId: 'john', chapter: 1, verseNumber: 1, displayReference: 'John 1:1', previewText: 'In the beginning was the Word, and the Word was with God, and the Word was God.'),
        FootnoteReference(volumeId: 'nt', bookId: 'col', chapter: 1, verseNumber: 16, displayReference: 'Col. 1:16', previewText: 'For by him were all things created, that are in heaven, and that are in earth...'),
      ],
    ),

    // Psalm 23:1
    const ScriptureFootnote(
      id: 'ps-23-1-shepherd',
      volumeId: 'ot', bookId: 'ps', chapter: 23, verseNumber: 1,
      word: 'shepherd', footnoteKey: '1a',
      definition: 'HEB: Ro’eh. Guardian, nourisher, and protector of the flock.',
      topicalGuideTopic: 'TG Shepherd',
      references: [
        FootnoteReference(volumeId: 'nt', bookId: 'john', chapter: 10, verseNumber: 11, displayReference: 'John 10:11', previewText: 'I am the good shepherd: the good shepherd giveth his life for the sheep.'),
        FootnoteReference(volumeId: 'bom', bookId: 'alma', chapter: 5, verseNumber: 38, displayReference: 'Alma 5:38', previewText: 'The good shepherd doth call after you; and in his own name he doth call you...'),
      ],
    ),

    // Isaiah 2:2
    const ScriptureFootnote(
      id: 'isa-2-2-mountain',
      volumeId: 'ot', bookId: 'isa', chapter: 2, verseNumber: 2,
      word: 'mountain', footnoteKey: '2a',
      definition: 'Prophetic symbol representing the temple and gathering of Zion in the tops of the mountains.',
      topicalGuideTopic: 'TG Temple',
      references: [
        FootnoteReference(volumeId: 'bom', bookId: '2-ne', chapter: 12, verseNumber: 2, displayReference: '2 Ne. 12:2', previewText: 'And it shall come to pass in the last days, when the mountain of the Lord’s house shall be established...'),
        FootnoteReference(volumeId: 'ot', bookId: 'mic', chapter: 4, verseNumber: 1, displayReference: 'Micah 4:1', previewText: 'In the last days it shall come to pass, that the mountain of the house of the Lord shall be established...'),
      ],
    ),

    // Matthew 5:14
    const ScriptureFootnote(
      id: 'matt-5-14-light',
      volumeId: 'nt', bookId: 'matt', chapter: 5, verseNumber: 14,
      word: 'light', footnoteKey: '14a',
      definition: 'GR: Phos. Disciples reflecting the Savior’s divine example and gospel truth.',
      topicalGuideTopic: 'TG Example',
      references: [
        FootnoteReference(volumeId: 'bom', bookId: '3-ne', chapter: 18, verseNumber: 24, displayReference: '3 Ne. 18:24', previewText: 'Hold up your light that it may shine unto the world. Behold I am the light which ye shall hold up...'),
        FootnoteReference(volumeId: 'nt', bookId: 'phil', chapter: 2, verseNumber: 15, displayReference: 'Philip. 2:15', previewText: 'Among whom ye shine as lights in the world.'),
      ],
    ),

    // 1 Corinthians 13:13
    const ScriptureFootnote(
      id: '1-cor-13-13-charity',
      volumeId: 'nt', bookId: '1-cor', chapter: 13, verseNumber: 13,
      word: 'charity', footnoteKey: '13a',
      definition: 'GR: Agape. Pure love of Christ; unconditional, sacrificial, and enduring forever.',
      topicalGuideTopic: 'TG Charity',
      references: [
        FootnoteReference(volumeId: 'bom', bookId: 'moroni', chapter: 7, verseNumber: 47, displayReference: 'Moro. 7:47', previewText: 'Charity is the pure love of Christ, and it endureth forever; and whoso is found possessed of it at the last day, it shall be well with him.'),
        FootnoteReference(volumeId: 'nt', bookId: '1-pet', chapter: 4, verseNumber: 8, displayReference: '1 Pet. 4:8', previewText: 'Above all things have fervent charity among yourselves: for charity shall cover the multitude of sins.'),
      ],
    ),

    // James 1:5
    const ScriptureFootnote(
      id: 'james-1-5-wisdom',
      volumeId: 'nt', bookId: 'james', chapter: 1, verseNumber: 5,
      word: 'wisdom', footnoteKey: '5a',
      definition: 'Divine insight and truth bestowed by God directly upon humble, sincere inquirers.',
      topicalGuideTopic: 'TG Wisdom',
      references: [
        FootnoteReference(volumeId: 'ot', bookId: 'prov', chapter: 3, verseNumber: 13, displayReference: 'Prov. 3:13', previewText: 'Happy is the man that findeth wisdom, and the man that getteth understanding.'),
        FootnoteReference(volumeId: 'bom', bookId: 'mosiah', chapter: 2, verseNumber: 17, displayReference: 'Mosiah 2:17', previewText: 'I tell you these things that ye may learn wisdom...'),
      ],
    ),
  ];

  static List<ScriptureFootnote> getFootnotesForVerse(String volumeId, String bookId, int chapter, int verseNumber) {
    return _footnotes.where((f) =>
      f.volumeId == volumeId &&
      f.bookId == bookId &&
      f.chapter == chapter &&
      f.verseNumber == verseNumber,
    ).toList();
  }

  static ScriptureFootnote? findFootnoteByWord(String volumeId, String bookId, int chapter, int verseNumber, String word) {
    final clean = word.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    try {
      return _footnotes.firstWhere((f) =>
        f.volumeId == volumeId &&
        f.bookId == bookId &&
        f.chapter == chapter &&
        f.verseNumber == verseNumber &&
        f.word.toLowerCase() == clean,
      );
    } catch (_) {
      return null;
    }
  }

  static List<ScriptureFootnote> getAllFootnotes() => _footnotes;
}

import '../models/scripture_models.dart';
import 'scripture_canon.dart';

class ScriptureRepository {
  // Built-in seed verses for demonstration and immediate offline study
  static final List<ScriptureVerse> _seedVerses = [
    // 1 Nephi 1
    const ScriptureVerse(
      volumeId: 'bom', bookId: '1-ne', chapter: 1, verseNumber: 1,
      text: 'I, Nephi, having been born of goodly parents, therefore I was taught somewhat in all the learning of my father; and having seen many afflictions in the course of my days, nevertheless, having been highly favored of the Lord in all my days; yea, having had a great knowledge of the goodness and the mysteries of God, therefore I make a record of my proceedings in my days.',
    ),
    const ScriptureVerse(
      volumeId: 'bom', bookId: '1-ne', chapter: 1, verseNumber: 2,
      text: 'Yea, I make a record in the language of my father, which consists of the learning of the Jews and the language of the Egyptians.',
    ),
    const ScriptureVerse(
      volumeId: 'bom', bookId: '1-ne', chapter: 1, verseNumber: 3,
      text: 'And I know that the record which I make is true; and I make it with mine own hand; and I make it according to my knowledge.',
    ),
    const ScriptureVerse(
      volumeId: 'bom', bookId: '1-ne', chapter: 1, verseNumber: 4,
      text: 'For it came to pass in the commencement of the first year of the reign of Zedekiah, king of Judah, my father, Lehi, having dwelt at Jerusalem in all his days; and there came many prophets in that same year, prophesying unto the people that they must repent, or the great city Jerusalem must be destroyed.',
    ),
    // 1 Nephi 3:7
    const ScriptureVerse(
      volumeId: 'bom', bookId: '1-ne', chapter: 3, verseNumber: 7,
      text: 'And it came to pass that I, Nephi, said unto my father: I will go and do the things which the Lord hath commanded, for I know that the Lord giveth no commandments unto the children of men, save he shall prepare a way for them that they may accomplish the thing which he commandeth them.',
    ),
    // 2 Nephi 2:25
    const ScriptureVerse(
      volumeId: 'bom', bookId: '1-ne', chapter: 3, verseNumber: 15,
      text: 'And it came to pass that we went down to the land of our inheritance, and we did gather together our gold, and our silver, and our precious things.',
    ),
    const ScriptureVerse(
      volumeId: 'bom', bookId: '2-ne', chapter: 2, verseNumber: 25,
      text: 'Adam fell that men might be; and men are, that they might have joy.',
    ),
    const ScriptureVerse(
      volumeId: 'bom', bookId: '2-ne', chapter: 31, verseNumber: 20,
      text: 'Wherefore, ye must press forward with a steadfastness in Christ, having a perfect brightness of hope, and a love of God and of all men. Wherefore, if ye shall press forward, feasting upon the word of Christ, and endure to the end, behold, thus saith the Father: Ye shall have eternal life.',
    ),
    // Mosiah 2:17
    const ScriptureVerse(
      volumeId: 'bom', bookId: 'mosiah', chapter: 2, verseNumber: 17,
      text: 'And behold, I tell you these things that ye may learn wisdom; that ye may learn that when ye are in the service of your fellow beings ye are only in the service of your God.',
    ),
    // Alma 32:21
    const ScriptureVerse(
      volumeId: 'bom', bookId: 'alma', chapter: 32, verseNumber: 21,
      text: 'And now as I said concerning faith—faith is not to have a perfect knowledge of things; therefore if ye have faith ye hope for things which are not seen, which are true.',
    ),
    // 3 Nephi 11:10-11
    const ScriptureVerse(
      volumeId: 'bom', bookId: '3-ne', chapter: 11, verseNumber: 10,
      text: 'Behold, I am Jesus Christ, whom the prophets testified shall come into the world.',
    ),
    const ScriptureVerse(
      volumeId: 'bom', bookId: '3-ne', chapter: 11, verseNumber: 11,
      text: 'And behold, I am the light and the life of the world; and I have drunk out of that bitter cup which the Father hath given me, and have glorified the Father in taking upon me the sins of the world, in the which I have suffered the will of the Father in all things from the beginning.',
    ),
    // Moroni 10:4-5
    const ScriptureVerse(
      volumeId: 'bom', bookId: 'moroni', chapter: 10, verseNumber: 4,
      text: 'And when ye shall receive these things, I would exhort you that ye would ask God, the Eternal Father, in the name of Christ, if these things are not true; and if ye shall ask with a sincere heart, with real intent, having faith in Christ, he will manifest the truth of it unto you, by the power of the Holy Ghost.',
    ),
    const ScriptureVerse(
      volumeId: 'bom', bookId: 'moroni', chapter: 10, verseNumber: 5,
      text: 'And by the power of the Holy Ghost ye may know the truth of all things.',
    ),

    // Old Testament: Genesis 1:1-3 (KJV)
    const ScriptureVerse(
      volumeId: 'ot', bookId: 'gen', chapter: 1, verseNumber: 1,
      text: 'In the beginning God created the heaven and the earth.',
    ),
    const ScriptureVerse(
      volumeId: 'ot', bookId: 'gen', chapter: 1, verseNumber: 2,
      text: 'And the earth was without form, and void; and darkness was upon the face of the deep. And the Spirit of God moved upon the face of the waters.',
    ),
    const ScriptureVerse(
      volumeId: 'ot', bookId: 'gen', chapter: 1, verseNumber: 3,
      text: 'And God said, Let there be light: and there was light.',
    ),
    // Psalm 23:1-4
    const ScriptureVerse(
      volumeId: 'ot', bookId: 'ps', chapter: 23, verseNumber: 1,
      text: 'The LORD is my shepherd; I shall not want.',
    ),
    const ScriptureVerse(
      volumeId: 'ot', bookId: 'ps', chapter: 23, verseNumber: 2,
      text: 'He maketh me to lie down in green pastures: he leadeth me beside the still waters.',
    ),
    const ScriptureVerse(
      volumeId: 'ot', bookId: 'ps', chapter: 23, verseNumber: 3,
      text: 'He restoreth my soul: he leadeth me in the paths of righteousness for his name’s sake.',
    ),
    const ScriptureVerse(
      volumeId: 'ot', bookId: 'ps', chapter: 23, verseNumber: 4,
      text: 'Yea, though I walk through the valley of the shadow of death, I will fear no evil: for thou art with me; thy rod and thy staff they comfort me.',
    ),
    // Isaiah 2:2
    const ScriptureVerse(
      volumeId: 'ot', bookId: 'isa', chapter: 2, verseNumber: 2,
      text: 'And it shall come to pass in the last days, that the mountain of the LORD’s house shall be established in the top of the mountains, and shall be exalted above the hills; and all nations shall flow unto it.',
    ),
    // Isaiah 53:5
    const ScriptureVerse(
      volumeId: 'ot', bookId: 'isa', chapter: 53, verseNumber: 5,
      text: 'But he was wounded for our transgressions, he was bruised for our iniquities: the chastisement of our peace was upon him; and with his stripes we are healed.',
    ),

    // New Testament: Matthew 5:1-3, 14-16 (KJV)
    const ScriptureVerse(
      volumeId: 'nt', bookId: 'matt', chapter: 5, verseNumber: 1,
      text: 'And seeing the multitudes, he went up into a mountain: and when he was set, his disciples came unto him:',
    ),
    const ScriptureVerse(
      volumeId: 'nt', bookId: 'matt', chapter: 5, verseNumber: 2,
      text: 'And he opened his mouth, and taught them, saying,',
    ),
    const ScriptureVerse(
      volumeId: 'nt', bookId: 'matt', chapter: 5, verseNumber: 3,
      text: 'Blessed are the poor in spirit: for theirs is the kingdom of heaven.',
    ),
    const ScriptureVerse(
      volumeId: 'nt', bookId: 'matt', chapter: 5, verseNumber: 14,
      text: 'Ye are the light of the world. A city that is set on an hill cannot be hid.',
    ),
    const ScriptureVerse(
      volumeId: 'nt', bookId: 'matt', chapter: 5, verseNumber: 16,
      text: 'Let your light so shine before men, that they may see your good works, and glorify your Father which is in heaven.',
    ),
    // John 1:1
    const ScriptureVerse(
      volumeId: 'nt', bookId: 'john', chapter: 1, verseNumber: 1,
      text: 'In the beginning was the Word, and the Word was with God, and the Word was God.',
    ),
    // John 3:16
    const ScriptureVerse(
      volumeId: 'nt', bookId: 'john', chapter: 3, verseNumber: 16,
      text: 'For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life.',
    ),
    // 1 Corinthians 13:4, 13
    const ScriptureVerse(
      volumeId: 'nt', bookId: '1-cor', chapter: 13, verseNumber: 4,
      text: 'Charity suffereth long, and is kind; charity envieth not; charity vaunteth not itself, is not puffed up,',
    ),
    const ScriptureVerse(
      volumeId: 'nt', bookId: '1-cor', chapter: 13, verseNumber: 13,
      text: 'And now abideth faith, hope, charity, these three; but the greatest of these is charity.',
    ),
    // James 1:5
    const ScriptureVerse(
      volumeId: 'nt', bookId: 'james', chapter: 1, verseNumber: 5,
      text: 'If any of you lack wisdom, let him ask of God, that giveth to all men liberally, and upbraideth not; and it shall be given him.',
    ),
  ];

  static List<ScriptureVerse> getChapterVerses(String volumeId, String bookId, int chapter) {
    final matched = _seedVerses.where(
      (v) => v.volumeId == volumeId && v.bookId == bookId && v.chapter == chapter,
    ).toList();

    if (matched.isNotEmpty) {
      return matched;
    }

    // Dynamic placeholder verses for any chapter not pre-seeded, ensuring full navigation availability
    final book = ScriptureCanon.getBook(volumeId, bookId);
    final bookTitle = book?.title ?? bookId;
    return List.generate(12, (index) {
      final vNum = index + 1;
      return ScriptureVerse(
        volumeId: volumeId,
        bookId: bookId,
        chapter: chapter,
        verseNumber: vNum,
        text: 'Verse $vNum of $bookTitle Chapter $chapter. Study passage and cross-reference records.',
      );
    });
  }

  static List<ScriptureVerse> getAllSearchableVerses() {
    return _seedVerses;
  }
}

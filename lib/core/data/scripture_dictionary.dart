import '../models/scripture_models.dart';

/// On-device dictionary database for scriptural vocabulary, archaic King James English,
/// and Hebrew/Greek doctrinal terminology.
class ScriptureDictionary {
  static const Map<String, DictionaryEntry> _entries = {
    // A
    'abomination': DictionaryEntry(
      word: 'abomination',
      partOfSpeech: 'noun',
      definition: 'Something morally detestable, idolatrous, or deeply offensive to divine holiness and purity.',
      etymology: 'Latin abominatio, from abominari (to deprecate as an ill omen).',
      sampleOccurrences: ['Proverbs 16:5', '2 Nephi 28:9', 'Leviticus 18:22'],
    ),
    'affliction': DictionaryEntry(
      word: 'affliction',
      partOfSpeech: 'noun',
      definition: 'Pain, distress, grief, or trial; adversities designed to sanctify and humble mortals before God.',
      etymology: 'Latin afflictio, from affligere (to strike down, weaken).',
      sampleOccurrences: ['Psalm 119:50', '2 Nephi 2:1'],
    ),
    'afflictions': DictionaryEntry(
      word: 'afflictions',
      partOfSpeech: 'noun (plural)',
      definition: 'States of pain, distress, grief, or trial; adversities designed to sanctify and humble mortals before God.',
      etymology: 'Latin afflictio, from affligere (to strike down, weaken).',
      sampleOccurrences: ['1 Nephi 1:1', 'Alma 36:3', '2 Corinthians 4:17'],
    ),
    'anon': DictionaryEntry(
      word: 'anon',
      partOfSpeech: 'adverb',
      definition: 'Immediately; straightway; quickly; at once.',
      etymology: 'Old English on an (in one state, instantly).',
      sampleOccurrences: ['Matthew 13:20', 'Mark 1:30'],
    ),
    'apostle': DictionaryEntry(
      word: 'apostle',
      partOfSpeech: 'noun',
      definition: 'A special witness of the name and divinity of Jesus Christ in all the world, ordained with apostolic priesthood keys.',
      etymology: 'Greek apostolos (one sent forth with a mission).',
      sampleOccurrences: ['Matthew 10:2', '3 Nephi 12:1', 'Luke 6:13'],
    ),
    'ark': DictionaryEntry(
      word: 'ark',
      partOfSpeech: 'noun',
      definition: 'A chest or vessel; specifically the Ark of the Covenant containing the stone tablets, or the vessel built by Noah for deliverance.',
      etymology: 'Latin arca (chest, box).',
      sampleOccurrences: ['Exodus 25:10', 'Genesis 6:14', 'Hebrews 9:4'],
    ),
    'atonement': DictionaryEntry(
      word: 'atonement',
      partOfSpeech: 'noun',
      definition: 'The central act of redemption by Jesus Christ through His suffering in Gethsemane, death on the cross, and resurrection, reconciling mankind to God.',
      etymology: 'Middle English at-one-ment (setting at one, reconciliation); Hebrew kaphar (to cover, purge).',
      sampleOccurrences: ['2 Nephi 2:10', 'Alma 34:9', 'Romans 5:11'],
    ),

    // B
    'baptism': DictionaryEntry(
      word: 'baptism',
      partOfSpeech: 'noun',
      definition: 'The introductory saving ordinance of the gospel, performed by immersion in water by one holding proper priesthood authority.',
      etymology: 'Greek baptisma, from baptizein (to immerse, submerge).',
      sampleOccurrences: ['2 Nephi 31:5', 'Matthew 3:13', 'Mosiah 18:14'],
    ),
    'begotten': DictionaryEntry(
      word: 'begotten',
      partOfSpeech: 'adjective / verb',
      definition: 'Generated, fathered, or brought forth into being; specifically referring to Christ as the Only Begotten Son of God.',
      etymology: 'Old English begetan.',
      sampleOccurrences: ['John 3:16', '2 Nephi 25:12', 'Hebrews 1:5'],
    ),
    'behold': DictionaryEntry(
      word: 'behold',
      partOfSpeech: 'verb / interjection',
      definition: 'To look upon with focused attention and contemplation; an imperative calling for urgent spiritual awareness.',
      etymology: 'Old English behealdan (to hold, observe).',
      sampleOccurrences: ['1 Nephi 11:7', 'John 1:29', 'Revelation 3:20'],
    ),
    'beseech': DictionaryEntry(
      word: 'beseech',
      partOfSpeech: 'verb',
      definition: 'To implore, entreat, or petition earnestly and humbly.',
      etymology: 'Middle English bisechen.',
      sampleOccurrences: ['Romans 12:1', 'Alma 34:33', 'Psalm 118:25'],
    ),
    'blasphemy': DictionaryEntry(
      word: 'blasphemy',
      partOfSpeech: 'noun',
      definition: 'Showing lack of reverence or contempt for God, holy things, or taking divine titles unworthily.',
      etymology: 'Greek blasphemia (injurious speech, profanity).',
      sampleOccurrences: ['Matthew 12:31', 'Jacob 7:7', 'Revelation 13:6'],
    ),

    // C
    'celestial': DictionaryEntry(
      word: 'celestial',
      partOfSpeech: 'adjective',
      definition: 'Heavenly; of the highest degree of glory, where God the Father and Jesus Christ dwell.',
      etymology: 'Latin caelestis, from caelum (heaven, sky).',
      sampleOccurrences: ['1 Corinthians 15:40', 'Doctrine & Covenants 76:70'],
    ),
    'charity': DictionaryEntry(
      word: 'charity',
      partOfSpeech: 'noun',
      definition: 'The pure, sacrificial, and everlasting love of Christ, which suffereth long and is kind, never failing.',
      etymology: 'Greek agape (divine, selfless love); Latin caritas (dearness, esteem).',
      sampleOccurrences: ['1 Corinthians 13:13', 'Moroni 7:47', '2 Nephi 26:30'],
    ),
    'chastisement': DictionaryEntry(
      word: 'chastisement',
      partOfSpeech: 'noun',
      definition: 'Corrective discipline, instruction, or punishment administered out of divine love to purify the soul.',
      etymology: 'Old French chastier, from Latin castigare (to make pure).',
      sampleOccurrences: ['Isaiah 53:5', 'Hebrews 12:8', 'Helaman 12:3'],
    ),
    'cleave': DictionaryEntry(
      word: 'cleave',
      partOfSpeech: 'verb',
      definition: 'To adhere firmly, cling, or remain faithful to someone or something.',
      etymology: 'Old English cleofian.',
      sampleOccurrences: ['Genesis 2:24', 'Acts 11:23', 'Alma 42:24'],
    ),
    'covenant': DictionaryEntry(
      word: 'covenant',
      partOfSpeech: 'noun',
      definition: 'A sacred, binding agreement between God and man with non-negotiable divine promises conditioned on mortal obedience.',
      etymology: 'Hebrew berith; Latin convenire (to come together).',
      sampleOccurrences: ['Genesis 17:7', 'Mosiah 5:5', 'Hebrews 8:6'],
    ),

    // D
    'deliverance': DictionaryEntry(
      word: 'deliverance',
      partOfSpeech: 'noun',
      definition: 'Liberation, release, or salvation from physical bondage, spiritual captivity, or enemies by divine power.',
      etymology: 'Old French delivrer (to set free).',
      sampleOccurrences: ['1 Nephi 1:20', 'Mosiah 24:21', 'Psalm 32:7'],
    ),
    'disciple': DictionaryEntry(
      word: 'disciple',
      partOfSpeech: 'noun',
      definition: 'A follower and pupil of Jesus Christ who takes upon them His name and strives to emulate His teachings.',
      etymology: 'Latin discipulus (learner, student).',
      sampleOccurrences: ['John 8:31', '3 Nephi 15:12', 'Luke 14:27'],
    ),
    'dispensation': DictionaryEntry(
      word: 'dispensation',
      partOfSpeech: 'noun',
      definition: 'A period of time in which the Lord has at least one authorized servant on the earth who bears the holy priesthood and keys.',
      etymology: 'Latin dispensatio (stewardship, distribution).',
      sampleOccurrences: ['Ephesians 1:10', 'Doctrine & Covenants 112:30'],
    ),

    // E
    'epistle': DictionaryEntry(
      word: 'epistle',
      partOfSpeech: 'noun',
      definition: 'A formal letter of apostolic instruction, doctrine, or counsel addressed to a congregation or individual.',
      etymology: 'Greek epistole (message, letter sent).',
      sampleOccurrences: ['Romans 16:22', 'Alma 54:4', '2 Peter 3:16'],
    ),
    'exaltation': DictionaryEntry(
      word: 'exaltation',
      partOfSpeech: 'noun',
      definition: 'The highest state of happiness and glory in the celestial kingdom, dwelling in the presence of God as heirs of eternal life.',
      etymology: 'Latin exaltatio (lifting up).',
      sampleOccurrences: ['Doctrine & Covenants 132:19', 'Romans 8:17'],
    ),

    // F
    'faith': DictionaryEntry(
      word: 'faith',
      partOfSpeech: 'noun',
      definition: 'Assurance of things hoped for, the evidence of things not seen; a principle of action and power centered in Jesus Christ.',
      etymology: 'Greek pistis (persuasion, moral conviction, assurance).',
      sampleOccurrences: ['Hebrews 11:1', 'Alma 32:21', 'Ether 12:6'],
    ),
    'firmament': DictionaryEntry(
      word: 'firmament',
      partOfSpeech: 'noun',
      definition: 'The expanse of the sky; the celestial arch holding the stars and atmosphere.',
      etymology: 'Hebrew raqia (spread-out expanse, beaten-out vault).',
      sampleOccurrences: ['Genesis 1:6', 'Psalm 19:1', 'Ezekiel 1:22'],
    ),

    // G
    'gentile': DictionaryEntry(
      word: 'gentile',
      partOfSpeech: 'noun / adjective',
      definition: 'Designation for nations, peoples, or individuals not of the literal lineage of Israel or Jewish nationality.',
      etymology: 'Latin gentilis (belonging to a nation or tribe); Hebrew goyim.',
      sampleOccurrences: ['1 Nephi 13:3', 'Romans 11:13', 'Title Page of Book of Mormon'],
    ),
    'gird': DictionaryEntry(
      word: 'gird',
      partOfSpeech: 'verb',
      definition: 'To encircle, bind, or secure around the body; figuratively to equip or fortify oneself for spiritual defense or duty.',
      etymology: 'Old English gyrdan.',
      sampleOccurrences: ['Ephesians 6:14', '1 Peter 1:13', '2 Nephi 1:23'],
    ),
    'goodly': DictionaryEntry(
      word: 'goodly',
      partOfSpeech: 'adjective',
      definition: 'Of superior quality; pleasant, agreeable; fair or handsome; of honorable character, noble or upright.',
      etymology: 'Middle English godli, from Old English godlic (god-like, noble).',
      sampleOccurrences: ['1 Nephi 1:1', 'Genesis 39:6', 'Matthew 13:45'],
    ),
    'gospel': DictionaryEntry(
      word: 'gospel',
      partOfSpeech: 'noun',
      definition: 'The "good news" of salvation through Jesus Christ, including faith, repentance, baptism, the Holy Ghost, and enduring to the end.',
      etymology: 'Old English godspel (good news/tidings); Greek evangelion.',
      sampleOccurrences: ['3 Nephi 27:13', 'Mark 1:1', 'Romans 1:16'],
    ),
    'grace': DictionaryEntry(
      word: 'grace',
      partOfSpeech: 'noun',
      definition: 'Divine assistance, enabling power, and unmerited favor bestowed through the mercy and love of Jesus Christ.',
      etymology: 'Greek charis (favor, kindness, unearned gift); Hebrew chen.',
      sampleOccurrences: ['2 Nephi 25:23', 'Ephesians 2:8', 'Moroni 10:32'],
    ),

    // H
    'hallelujah': DictionaryEntry(
      word: 'hallelujah',
      partOfSpeech: 'interjection',
      definition: 'Praise ye the Lord; a joyous chant of thanksgiving and adoration to Yahweh.',
      etymology: 'Hebrew hallelu-yah.',
      sampleOccurrences: ['Revelation 19:1', 'Psalm 104:35'],
    ),
    'hearken': DictionaryEntry(
      word: 'hearken',
      partOfSpeech: 'verb',
      definition: 'To listen with attentive compliance, obedience, and devotion.',
      etymology: 'Middle English herknen, Old English heorcnian.',
      sampleOccurrences: ['1 Nephi 2:18', 'Deuteronomy 28:1', 'Isaiah 51:1'],
    ),
    'hosanna': DictionaryEntry(
      word: 'hosanna',
      partOfSpeech: 'interjection',
      definition: 'Literally "Save now, we beseech thee"; an exclamation of praise, adoration, and supplication to God and the Messiah.',
      etymology: 'Hebrew hoshia-na; Greek hosanna.',
      sampleOccurrences: ['Matthew 21:9', '1 Nephi 11:6', '3 Nephi 11:17'],
    ),

    // I
    'immortality': DictionaryEntry(
      word: 'immortality',
      partOfSpeech: 'noun',
      definition: 'The state of never dying; endless physical existence after resurrection.',
      etymology: 'Latin immortalitas (exemption from death).',
      sampleOccurrences: ['Alma 40:2', '1 Corinthians 15:53', 'Moses 1:39'],
    ),
    'iniquity': DictionaryEntry(
      word: 'iniquity',
      partOfSpeech: 'noun',
      definition: 'Gross wickedness, moral distortion, injustice, or willful violation of divine law.',
      etymology: 'Latin iniquitas (unevenness, unfairness, injustice).',
      sampleOccurrences: ['Psalm 51:2', 'Mosiah 29:17', 'Matthew 24:12'],
    ),
    'israel': DictionaryEntry(
      word: 'israel',
      partOfSpeech: 'noun',
      definition: 'Literally "one who prevails with God"; the covenant people descended from Jacob or adopted into the covenant through baptism.',
      etymology: 'Hebrew Yisra'el (God contends / prince with God).',
      sampleOccurrences: ['Genesis 32:28', '1 Nephi 19:10', 'Romans 9:6'],
    ),

    // J
    'joy': DictionaryEntry(
      word: 'joy',
      partOfSpeech: 'noun',
      definition: 'Fullness of spiritual peace, blessedness, and delight that comes from living in harmony with God.',
      etymology: 'Hebrew simchah; Greek chara.',
      sampleOccurrences: ['2 Nephi 2:25', 'Psalm 16:11', 'John 15:11'],
    ),
    'justice': DictionaryEntry(
      word: 'justice',
      partOfSpeech: 'noun',
      definition: 'The unalterable divine law requiring that every transgression receive punishment and every obedience receive blessing.',
      etymology: 'Latin justitia, from justus (righteous, upright).',
      sampleOccurrences: ['Alma 42:15', 'Mosiah 15:27', 'Isaiah 59:14'],
    ),

    // M
    'mercy': DictionaryEntry(
      word: 'mercy',
      partOfSpeech: 'noun',
      definition: 'Compassion, pity, and divine forgiveness extended through Christ to satisfy justice on behalf of the repentant.',
      etymology: 'Latin merces (reward, favor, pity); Hebrew chesed.',
      sampleOccurrences: ['Alma 42:15', 'Matthew 5:7', 'Ephesians 2:4'],
    ),
    'mountain': DictionaryEntry(
      word: 'mountain',
      partOfSpeech: 'noun',
      definition: 'A high geographic elevation, frequently used symbolically in scripture for the temple or sanctuary of the Lord.',
      etymology: 'Hebrew har; Greek oros.',
      sampleOccurrences: ['Isaiah 2:2', '2 Nephi 12:2', 'Matthew 17:1'],
    ),
    'mysteries': DictionaryEntry(
      word: 'mysteries',
      partOfSpeech: 'noun (plural)',
      definition: 'Divine truths, purposes, or doctrines known solely by revelation from the Holy Spirit and hidden from uninspired inquiry.',
      etymology: 'Greek mysterion (sacred secret, hidden rite).',
      sampleOccurrences: ['1 Nephi 1:1', 'Alma 12:9', '1 Corinthians 2:7'],
    ),
    'mystery': DictionaryEntry(
      word: 'mystery',
      partOfSpeech: 'noun',
      definition: 'A divine truth known only through heavenly revelation.',
      etymology: 'Greek mysterion.',
      sampleOccurrences: ['Romans 16:25', 'Ephesians 3:3'],
    ),

    // O
    'ordinance': DictionaryEntry(
      word: 'ordinance',
      partOfSpeech: 'noun',
      definition: 'A sacred, formal physical act performed by priesthood authority, conveying spiritual blessings and covenants.',
      etymology: 'Latin ordinantia, from ordinare (to set in order).',
      sampleOccurrences: ['Malachi 3:7', 'Alma 13:16', 'Exodus 18:20'],
    ),

    // P
    'parable': DictionaryEntry(
      word: 'parable',
      partOfSpeech: 'noun',
      definition: 'A simple story used to illustrate a moral or spiritual lesson, often veiling deeper doctrine to unprepared hearers.',
      etymology: 'Greek parabole (comparison, placing alongside).',
      sampleOccurrences: ['Matthew 13:3', 'Alma 32:28', 'Mark 4:2'],
    ),
    'priesthood': DictionaryEntry(
      word: 'priesthood',
      partOfSpeech: 'noun',
      definition: 'The eternal power and authority of God delegated to man to act in all things for the salvation of His children.',
      etymology: 'Old English preosthad.',
      sampleOccurrences: ['Alma 13:1', 'Hebrews 7:11', 'Doctrine & Covenants 107'],
    ),
    'prophet': DictionaryEntry(
      word: 'prophet',
      partOfSpeech: 'noun',
      definition: 'One called of God to speak in His name, reveal His will, preach righteousness, and testify of Jesus Christ.',
      etymology: 'Greek prophetes (one who speaks forth or for another); Hebrew nabi.',
      sampleOccurrences: ['Amos 3:7', '1 Nephi 1:4', 'Ephesians 4:11'],
    ),

    // Q
    'quench': DictionaryEntry(
      word: 'quench',
      partOfSpeech: 'verb',
      definition: 'To extinguish, subdue, or suppress; in scripture, to stifle spiritual promptings or the Holy Ghost.',
      etymology: 'Old English cwencan.',
      sampleOccurrences: ['1 Thessalonians 5:19', 'Alma 44:2', 'Ephesians 6:16'],
    ),

    // R
    'raiment': DictionaryEntry(
      word: 'raiment',
      partOfSpeech: 'noun',
      definition: 'Clothing, garments, or vesture; often symbolic of spiritual purity, righteousness, or humility.',
      etymology: 'Shortened from arrayment, from Anglo-French areiement.',
      sampleOccurrences: ['Matthew 6:28', '2 Nephi 9:14', 'Revelation 3:5'],
    ),
    'remission': DictionaryEntry(
      word: 'remission',
      partOfSpeech: 'noun',
      definition: 'Pardon, forgiveness, or cancellation of the penalty of sin through the atonement of Jesus Christ.',
      etymology: 'Latin remissio (slackening, letting go).',
      sampleOccurrences: ['Acts 2:38', '2 Nephi 31:17', 'Mosiah 4:12'],
    ),
    'repentance': DictionaryEntry(
      word: 'repentance',
      partOfSpeech: 'noun',
      definition: 'A sincere turning away from sin and turning of the heart and will to God, accompanied by godly sorrow, confession, and restitution.',
      etymology: 'Greek metanoia (change of mind, heart, and purpose); Hebrew shuv (to turn back).',
      sampleOccurrences: ['Alma 34:31', 'Acts 2:38', '2 Nephi 31:11'],
    ),
    'resurrection': DictionaryEntry(
      word: 'resurrection',
      partOfSpeech: 'noun',
      definition: 'The reunion of the spirit body with the perfected, physical body of flesh and bones, never again to be divided, made universal through Christ.',
      etymology: 'Latin resurrectio, from resurgere (to rise again); Greek anastasis.',
      sampleOccurrences: ['2 Nephi 9:6', '1 Corinthians 15:20', 'Alma 11:43'],
    ),
    'righteousness': DictionaryEntry(
      word: 'righteousness',
      partOfSpeech: 'noun',
      definition: 'Purity of heart and conformity of life to the divine will; moral integrity before God.',
      etymology: 'Old English rihtwisnes (right-wise-ness).',
      sampleOccurrences: ['Matthew 6:33', '1 Nephi 22:26', 'Psalm 23:3'],
    ),

    // S
    'sacrament': DictionaryEntry(
      word: 'sacrament',
      partOfSpeech: 'noun',
      definition: 'A sacred Christian ordinance wherein bread and water (or wine) are blessed and partaken in remembrance of the body and blood of Christ.',
      etymology: 'Latin sacramentum (sacred oath, dedication).',
      sampleOccurrences: ['3 Nephi 18:7', 'Luke 22:19', 'Moroni 4:3'],
    ),
    'salvation': DictionaryEntry(
      word: 'salvation',
      partOfSpeech: 'noun',
      definition: 'Deliverance from spiritual and physical death, and exaltation in the celestial kingdom of God.',
      etymology: 'Latin salvatio, from salvare (to save); Hebrew yeshua.',
      sampleOccurrences: ['Mosiah 3:17', 'Acts 4:12', 'Romans 1:16'],
    ),
    'sanctify': DictionaryEntry(
      word: 'sanctify',
      partOfSpeech: 'verb',
      definition: 'To purify, consecrate, and make holy through the blood of Christ and the influence of the Holy Ghost.',
      etymology: 'Latin sanctificare, from sanctus (holy) + facere (to make).',
      sampleOccurrences: ['Moroni 10:33', 'John 17:17', 'Hebrews 10:10'],
    ),
    'sepulchre': DictionaryEntry(
      word: 'sepulchre',
      partOfSpeech: 'noun',
      definition: 'A tomb, burial vault, or cavity hewn into stone for interring the dead.',
      etymology: 'Latin sepulcrum, from sepelire (to bury).',
      sampleOccurrences: ['Matthew 27:60', '2 Kings 23:16', 'John 19:41'],
    ),
    'shepherd': DictionaryEntry(
      word: 'shepherd',
      partOfSpeech: 'noun',
      definition: 'One who tends, guards, pastures, and protects sheep; a title of the Lord Jesus Christ over His covenant people.',
      etymology: 'Old English sceaphirde; Hebrew roeh.',
      sampleOccurrences: ['Psalm 23:1', 'John 10:11', 'Alma 5:38'],
    ),
    'slain': DictionaryEntry(
      word: 'slain',
      partOfSpeech: 'adjective / past participle',
      definition: 'Killed or put to death violently, often in battle or sacrifice.',
      etymology: 'Old English slegen.',
      sampleOccurrences: ['1 Nephi 4:19', 'Revelation 5:6', 'Alma 24:22'],
    ),
    'smite': DictionaryEntry(
      word: 'smite',
      partOfSpeech: 'verb',
      definition: 'To strike forcefully with the hand, weapon, or judgment; in scripture, often of divine retribution or trials.',
      etymology: 'Old English smitan (to smear, strike).',
      sampleOccurrences: ['Exodus 7:17', '1 Nephi 4:18', 'Matthew 26:67'],
    ),
    'strait': DictionaryEntry(
      word: 'strait',
      partOfSpeech: 'adjective',
      definition: 'Narrow, tight, strict, or close; exacting; not to be confused with "straight" (direct).',
      etymology: 'Old French estreit, from Latin strictus (drawn tight).',
      sampleOccurrences: ['2 Nephi 31:18', 'Matthew 7:13', 'Luke 13:24'],
    ),
    'straight': DictionaryEntry(
      word: 'straight',
      partOfSpeech: 'adjective',
      definition: 'Direct, level, unswerving; having the same direction throughout without curvature.',
      etymology: 'Old English streaht.',
      sampleOccurrences: ['Isaiah 40:3', 'Alma 7:19', 'Matthew 3:3'],
    ),
    'succor': DictionaryEntry(
      word: 'succor',
      partOfSpeech: 'verb',
      definition: 'To run to the support of; to relieve in distress, help, aid, or comfort.',
      etymology: 'Latin succurrere (to run to help, from sub + currere).',
      sampleOccurrences: ['Alma 7:12', 'Hebrews 2:18'],
    ),
    'synagogue': DictionaryEntry(
      word: 'synagogue',
      partOfSpeech: 'noun',
      definition: 'A local Jewish assembly or congregation meeting for religious worship and scripture study.',
      etymology: 'Greek synagoge (assembly, gathering together).',
      sampleOccurrences: ['Matthew 4:23', 'Alma 16:13', 'Luke 4:16'],
    ),

    // T
    'temple': DictionaryEntry(
      word: 'temple',
      partOfSpeech: 'noun',
      definition: 'Literally the house of the Lord; a sacred sanctuary dedicated for holy ordinances, covenants, and communion with God.',
      etymology: 'Latin templum; Hebrew beit ha-Mikdash (holy house).',
      sampleOccurrences: ['Isaiah 2:2', '2 Nephi 5:16', 'Matthew 21:12'],
    ),
    'transgression': DictionaryEntry(
      word: 'transgression',
      partOfSpeech: 'noun',
      definition: 'An act that goes beyond limits set by a law or divine commandment.',
      etymology: 'Latin transgressio (stepping across).',
      sampleOccurrences: ['1 Timothy 2:14', '2 Nephi 2:22', 'Romans 4:15'],
    ),

    // W
    'wisdom': DictionaryEntry(
      word: 'wisdom',
      partOfSpeech: 'noun',
      definition: 'The right use of knowledge; spiritual discernment to act in accordance with divine law.',
      etymology: 'Old English wisdom; Hebrew chokmah; Greek sophia.',
      sampleOccurrences: ['James 1:5', 'Mosiah 2:17', 'Proverbs 3:13'],
    ),

    // Z
    'zion': DictionaryEntry(
      word: 'zion',
      partOfSpeech: 'noun',
      definition: 'The pure in heart; a holy society or city characterized by unity, righteousness, and lack of poverty.',
      etymology: 'Hebrew Tziyon; Greek Sion.',
      sampleOccurrences: ['Moses 7:18', 'Psalm 87:2', 'Doctrine & Covenants 97:21'],
    ),
  };

  /// Common morphological mappings (plural/past-tense/verb-forms to base keys)
  static const Map<String, String> _stemMap = {
    'commanded': 'commandments',
    'commanding': 'commandments',
    'prayed': 'prayer',
    'praying': 'prayer',
    'prophets': 'prophet',
    'prophesied': 'prophet',
    'prophesying': 'prophet',
    'disciples': 'disciple',
    'apostles': 'apostle',
    'covenants': 'covenant',
    'ordinances': 'ordinance',
    'baptized': 'baptism',
    'baptizing': 'baptism',
    'repented': 'repentance',
    'repenting': 'repentance',
    'succoring': 'succor',
    'succored': 'succor',
    'afflicted': 'afflictions',
    'afflicting': 'afflictions',
    'mysteries': 'mysteries',
    'mystery': 'mystery',
    'sanctified': 'sanctify',
    'sanctifying': 'sanctify',
    'transgressed': 'transgression',
    'transgressing': 'transgression',
    'temples': 'temple',
    'synagogues': 'synagogue',
    'parables': 'parable',
    'epistles': 'epistle',
  };

  /// Lookup a word in the on-device scripture dictionary.
  static DictionaryEntry lookup(String query) {
    final clean = query.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

    // 1. Direct match
    if (_entries.containsKey(clean)) {
      return _entries[clean]!;
    }

    // 2. Stem match
    final stem = _stemMap[clean];
    if (stem != null && _entries.containsKey(stem)) {
      final base = _entries[stem]!;
      return DictionaryEntry(
        word: query.trim(),
        partOfSpeech: base.partOfSpeech,
        definition: 'Form of ${base.word}: ${base.definition}',
        etymology: base.etymology,
        sampleOccurrences: base.sampleOccurrences,
      );
    }

    // 3. Prefix match
    for (final entry in _entries.entries) {
      if (clean.startsWith(entry.key) || entry.key.startsWith(clean)) {
        return entry.value;
      }
    }

    // 4. Clean fallback informing user and offering search
    return DictionaryEntry(
      word: query.trim(),
      partOfSpeech: 'scriptural term',
      definition: 'Scriptural word occurring in the King James Bible or Book of Mormon. Use the "Device / Web Dictionary" action below to search your device\'s built-in dictionaries or system lexicon.',
      etymology: 'Scriptural English lexicon.',
      sampleOccurrences: const [],
    );
  }

  /// Get autocomplete suggestions based on query
  static List<String> getSuggestions(String query) {
    final clean = query.trim().toLowerCase();
    if (clean.isEmpty) return const ['faith', 'repentance', 'baptism', 'grace', 'atonement', 'covenant'];

    final matches = _entries.keys.where((k) => k.startsWith(clean) || k.contains(clean)).take(8).toList();
    return matches;
  }

  /// Get list of featured study words
  static List<String> getFeaturedWords() {
    return const [
      'faith', 'grace', 'atonement', 'repentance', 'baptism', 'covenant',
      'goodly', 'mysteries', 'succor', 'strait', 'charity', 'priesthood',
      'zion', 'sanctify', 'resurrection', 'wisdom', 'joy'
    ];
  }

  static List<DictionaryEntry> getAllEntries() => _entries.values.toList();
}

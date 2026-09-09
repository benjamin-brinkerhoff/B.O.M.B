import 'package:flutter/material.dart';

/// Primary scripture reader screen displaying volumes, books, and chapters.
class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  String _selectedVolume = 'The Book of Mormon';
  String _selectedBook = '1 Nephi';
  int _selectedChapter = 1;

  final List<String> _volumes = const [
    'The Book of Mormon',
    'The Old Testament',
    'The New Testament',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '\$_selectedBook \$_selectedChapter',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.library_books),
            tooltip: 'Select Volume',
            onSelected: (volume) {
              setState(() {
                _selectedVolume = volume;
                _selectedBook = volume == 'The Book of Mormon' ? '1 Nephi' : 'Genesis';
                _selectedChapter = 1;
              });
            },
            itemBuilder: (context) => _volumes.map((v) {
              return PopupMenuItem<String>(
                value: v,
                child: Text(v),
              );
            }).toList(),
          ),
          IconButton(
            icon: const Icon(Icons.format_size),
            tooltip: 'Reading Size',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Font size adjustments are in Settings.')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        children: [
          // Volume Header Card
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withOpacity(0.35),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedVolume,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Chapter \$_selectedChapter',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Sample Verse Typography Block
          _buildVerseItem(
            verseNumber: 1,
            text: 'I, Nephi, having been born of goodly parents, therefore I was taught somewhat in all the learning of my father; and having seen many afflictions in the course of my days, nevertheless, having been highly favored of the Lord in all my days...',
            theme: theme,
          ),
          _buildVerseItem(
            verseNumber: 2,
            text: 'Yea, I make a record in the language of my father, which consists of the learning of the Jews and the language of the Egyptians.',
            theme: theme,
          ),
          _buildVerseItem(
            verseNumber: 3,
            text: 'And I know that the record which I make is true; and I make it with mine own hand; and I make it according to my knowledge.',
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildVerseItem({required int verseNumber, required String text, required ThemeData theme}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Text(
              '\$verseNumber',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.6,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

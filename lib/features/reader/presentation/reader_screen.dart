import 'package:flutter/material.dart';
import '../../../core/models/scripture_models.dart';
import '../../../core/state/app_scope.dart';
import '../../navigation/presentation/scripture_picker_dialog.dart';
import 'verse_markup_sheet.dart';
import 'footnote_spanned_text.dart';

/// Full interactive scripture reader supporting Church-standard blue footnotes,
/// multi-color highlighting, personal notes, tag badges, and quick 3-tier navigation.
class ReaderScreen extends StatelessWidget {
  const ReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final theme = Theme.of(context);
    final currentBook = state.currentBook;
    final currentChapter = state.currentChapter;
    final currentVolume = state.currentVolume;
    final verses = state.currentVerses;

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => ScripturePickerDialog.show(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\${currentBook.title} \$currentChapter',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      state.currentVolumeId == 'bom'
                          ? 'The Book of Mormon'
                          : '\${currentVolume.shortTitle} (\${state.currentBibleVersion.abbreviation})',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down, size: 20),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            tooltip: 'Previous Chapter',
            onPressed: () => state.previousChapter(),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            tooltip: 'Next Chapter',
            onPressed: () => state.nextChapter(),
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Browse Scriptures',
            onPressed: () => ScripturePickerDialog.show(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        children: [
          // Chapter Header Banner
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0, top: 8.0),
              child: Column(
                children: [
                  Text(
                    currentBook.title.toUpperCase(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'CHAPTER \$currentChapter',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(width: 60, child: Divider(thickness: 2)),
                ],
              ),
            ),
          ),

          // Scripture Verses
          ...verses.map((verse) {
            final annotation = state.getAnnotation(
              verse.volumeId,
              verse.bookId,
              verse.chapter,
              verse.verseNumber,
            );
            return _VerseRow(
              verse: verse,
              bookTitle: currentBook.title,
              annotation: annotation,
              readerStyle: state.getReaderTextStyle(context),
              onTap: () => VerseMarkupSheet.show(context, verse, currentBook.title),
            );
          }),

          const SizedBox(height: 32),

          // Chapter Navigation Bottom Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text('Previous'),
                onPressed: () => state.previousChapter(),
              ),
              Text(
                'Chapter \$currentChapter of \${currentBook.chapterCount}',
                style: theme.textTheme.bodySmall,
              ),
              OutlinedButton.icon(
                label: const Text('Next'),
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => state.nextChapter(),
              ),
            ],
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _VerseRow extends StatelessWidget {
  final ScriptureVerse verse;
  final String bookTitle;
  final VerseAnnotation? annotation;
  final TextStyle readerStyle;
  final VoidCallback onTap;

  const _VerseRow({
    required this.verse,
    required this.bookTitle,
    required this.annotation,
    required this.readerStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasNote = annotation?.note != null && annotation!.note!.isNotEmpty;
    final hasTags = annotation?.tags != null && annotation!.tags.isNotEmpty;
    final hasLinks = annotation?.linkedVerseKeys != null && annotation!.linkedVerseKeys.isNotEmpty;
    final highlightColor = annotation?.highlightColor != null
        ? annotation!.highlightColor!.color.withOpacity(0.55)
        : null;

    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: highlightColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Verse Number Pill
                SizedBox(
                  width: 34,
                  child: Text(
                    '\${verse.verseNumber}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),

                // Verse Text with Church-standard Blue Clickable Footnotes
                Expanded(
                  child: FootnoteSpannedText(
                    verse: verse,
                    baseStyle: readerStyle,
                  ),
                ),

                // Note Indicator Icon
                if (hasNote)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Icon(Icons.note_alt, size: 18, color: theme.colorScheme.secondary),
                  ),

                // Personal Cross-Link Indicator Icon
                if (hasLinks)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Icon(Icons.link, size: 18, color: Colors.blue.shade700),
                  ),
              ],
            ),

            // Inline Tags Bar
            if (hasTags)
              Padding(
                padding: const EdgeInsets.only(left: 34.0, top: 4.0),
                child: Wrap(
                  spacing: 4,
                  children: annotation!.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '#\$tag',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
                      ),
                    );
                  }).toList(),
                ),
              ),

            // Inline Note Preview Snippet
            if (hasNote)
              Padding(
                padding: const EdgeInsets.only(left: 34.0, top: 6.0, bottom: 2.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(left: BorderSide(color: theme.colorScheme.secondary, width: 3)),
                  ),
                  child: Text(
                    annotation!.note!,
                    style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

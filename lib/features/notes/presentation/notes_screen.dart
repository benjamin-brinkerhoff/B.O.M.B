import 'package:flutter/material.dart';
import '../../../core/data/scripture_canon.dart';
import '../../../core/data/scripture_repository.dart';
import '../../../core/models/scripture_models.dart';
import '../../../core/state/app_scope.dart';

/// Screen listing all user highlights and personal study notes.
class NotesScreen extends StatefulWidget {
  final VoidCallback onNavigateToReader;

  const NotesScreen({super.key, required this.onNavigateToReader});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final theme = Theme.of(context);
    final notes = state.allNotes;
    final highlights = state.allHighlights;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes & Highlights', style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Study Notes (\${notes.length})', icon: const Icon(Icons.note_alt_outlined)),
            Tab(text: 'Highlights (\${highlights.length})', icon: const Icon(Icons.format_color_highlight)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Notes
          notes.isEmpty
              ? _buildEmptyState('No notes added yet.', 'Tap any verse while reading to attach personal insights and notes.', theme)
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return _buildNoteCard(note, state, theme);
                  },
                ),

          // Tab 2: Highlights
          highlights.isEmpty
              ? _buildEmptyState('No highlights yet.', 'Tap any verse to mark it with your preferred highlight color.', theme)
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: highlights.length,
                  itemBuilder: (context, index) {
                    final hl = highlights[index];
                    return _buildHighlightCard(hl, state, theme);
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_border, size: 64, color: theme.colorScheme.outline.withOpacity(0.5)),
            const SizedBox(height: 16),
            Text(title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteCard(VerseAnnotation ann, dynamic state, ThemeData theme) {
    final book = ScriptureCanon.getBook(ann.volumeId, ann.bookId);
    final ref = '\${book?.title ?? ann.bookId} \${ann.chapter}:\${ann.verseNumber}';
    final volume = ScriptureCanon.getVolume(ann.volumeId);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          state.jumpTo(
            volumeId: ann.volumeId,
            bookId: ann.bookId,
            chapter: ann.chapter,
            verse: ann.verseNumber,
          );
          widget.onNavigateToReader();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(ref, style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.primary, fontSize: 16)),
                  Text(volume.shortTitle, style: theme.textTheme.bodySmall),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  ann.note ?? '',
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text('Read Verse'),
                  onPressed: () {
                    state.jumpTo(
                      volumeId: ann.volumeId,
                      bookId: ann.bookId,
                      chapter: ann.chapter,
                      verse: ann.verseNumber,
                    );
                    widget.onNavigateToReader();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHighlightCard(VerseAnnotation ann, dynamic state, ThemeData theme) {
    final book = ScriptureCanon.getBook(ann.volumeId, ann.bookId);
    final ref = '\${book?.title ?? ann.bookId} \${ann.chapter}:\${ann.verseNumber}';
    final volume = ScriptureCanon.getVolume(ann.volumeId);
    final verses = ScriptureRepository.getChapterVerses(ann.volumeId, ann.bookId, ann.chapter);
    final verse = verses.firstWhere(
      (v) => v.verseNumber == ann.verseNumber,
      orElse: () => ScriptureVerse(
        volumeId: ann.volumeId,
        bookId: ann.bookId,
        chapter: ann.chapter,
        verseNumber: ann.verseNumber,
        text: 'Verse \${ann.verseNumber}',
      ),
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          state.jumpTo(
            volumeId: ann.volumeId,
            bookId: ann.bookId,
            chapter: ann.chapter,
            verse: ann.verseNumber,
          );
          widget.onNavigateToReader();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (ann.highlightColor != null)
                    Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: ann.highlightColor!.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  Text(ref, style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.primary, fontSize: 16)),
                  const Spacer(),
                  Text(volume.shortTitle, style: theme.textTheme.bodySmall),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                verse.text,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

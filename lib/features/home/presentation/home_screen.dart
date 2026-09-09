import 'package:flutter/material.dart';
import '../../../core/data/scripture_canon.dart';
import '../../../core/models/scripture_models.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/state/app_state.dart';
import '../../study_tools/presentation/dictionary_lookup_sheet.dart';

/// Home dashboard displaying reading streak, time spent reading, study statistics,
/// continue reading shortcut, and interactive book selector.
class HomeScreen extends StatefulWidget {
  final VoidCallback onNavigateToReader;
  final VoidCallback onNavigateToSearch;
  final VoidCallback onNavigateToNotes;
  final VoidCallback onNavigateToParallel;

  const HomeScreen({
    super.key,
    required this.onNavigateToReader,
    required this.onNavigateToSearch,
    required this.onNavigateToNotes,
    required this.onNavigateToParallel,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedVolumeTab = 'bom'; // 'bom', 'nt', 'ot'

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final theme = Theme.of(context);
    final currentBook = state.currentBook;
    final currentVolume = state.currentVolume;
    final selectedVolume = ScriptureCanon.getVolume(_selectedVolumeTab);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.menu_book, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            const Text('B.O.M.B Study', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.spellcheck),
            tooltip: 'On-Device Dictionary',
            onPressed: () => DictionaryLookupSheet.show(context),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Scriptures',
            onPressed: widget.onNavigateToSearch,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        children: [
          // 1. Reading Streak & Stats Card
          _buildStreakAndStatsCard(state, theme),

          const SizedBox(height: 18),

          // 2. Continue Reading Hero Card
          _buildContinueReadingCard(state, theme),

          const SizedBox(height: 24),

          // 3. Select a Book to Read (Volume Tabs & Book Grid)
          _buildBookSelectorSection(state, theme, selectedVolume),

          const SizedBox(height: 24),

          // 4. Daily Verse of the Day
          _buildDailyVerseCard(state, theme),

          const SizedBox(height: 24),

          // 5. Quick Action Study Hub
          _buildQuickActions(context, state, theme),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildStreakAndStatsCard(AppState state, ThemeData theme) {
    final daysOfWeek = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final todayWeekday = DateTime.now().weekday; // 1 = Mon, 7 = Sun

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Text('🔥', style: TextStyle(fontSize: 24)),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${state.readingStreakDays} Day Streak',
                          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text('Active', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                        ),
                      ],
                    ),
                    Text('Best Streak: ${state.longestStreakDays} days', style: theme.textTheme.bodySmall),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Weekly Calendar Activity Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                final dayNum = index + 1;
                final isDone = state.activeWeekDays.contains(dayNum);
                final isToday = dayNum == todayWeekday;

                return Column(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: isDone ? Colors.orange : theme.colorScheme.surfaceVariant.withOpacity(0.4),
                        shape: BoxShape.circle,
                        border: isToday ? Border.all(color: theme.colorScheme.primary, width: 2) : null,
                      ),
                      child: Center(
                        child: isDone
                            ? const Icon(Icons.check, size: 18, color: Colors.white)
                            : Text(
                                daysOfWeek[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      daysOfWeek[index],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                        color: isToday ? theme.colorScheme.primary : Colors.grey,
                      ),
                    ),
                  ],
                );
              }),
            ),

            const Divider(height: 28),

            // Reading Stats Metrics Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatMetric(
                  icon: Icons.timer_outlined,
                  color: Colors.blue,
                  value: state.todayReadingTimeFormatted,
                  label: "Today's Study",
                ),
                _buildStatMetric(
                  icon: Icons.history,
                  color: Colors.purple,
                  value: state.totalReadingTimeFormatted,
                  label: 'Total Time',
                ),
                _buildStatMetric(
                  icon: Icons.check_circle_outline,
                  color: Colors.green,
                  value: '${state.chaptersReadCount}',
                  label: 'Chapters Read',
                ),
                _buildStatMetric(
                  icon: Icons.bookmark_outline,
                  color: Colors.amber.shade800,
                  value: '${state.allNotes.length + state.allHighlights.length}',
                  label: 'Markups',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatMetric({
    required IconData icon,
    required Color color,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  Widget _buildContinueReadingCard(AppState state, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.35),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.play_circle_fill, size: 16, color: theme.colorScheme.primary),
                    const SizedBox(width: 6),
                    Text(
                      'CONTINUE READING',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '${state.currentBook.title} ${state.currentChapter}',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  state.currentVolume.shortTitle,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_forward, size: 18),
            label: const Text('Resume'),
            onPressed: widget.onNavigateToReader,
          ),
        ],
      ),
    );
  }

  Widget _buildBookSelectorSection(AppState state, ThemeData theme, ScriptureVolume volume) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Select a Book to Read',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              '${volume.books.length} Books',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Volume Selector Segmented Button
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'bom', label: Text('Book of Mormon')),
            ButtonSegment(value: 'nt', label: Text('New Test.')),
            ButtonSegment(value: 'ot', label: Text('Old Test.')),
          ],
          selected: {_selectedVolumeTab},
          onSelectionChanged: (set) => setState(() => _selectedVolumeTab = set.first),
        ),

        const SizedBox(height: 14),

        // Interactive Book Grid / Chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: volume.books.map((book) {
            final isCurrent = state.currentVolumeId == _selectedVolumeTab && state.currentBookId == book.id;

            return ActionChip(
              avatar: isCurrent ? const Icon(Icons.bookmark, size: 16) : null,
              backgroundColor: isCurrent ? theme.colorScheme.primaryContainer : null,
              label: Text(book.title, style: TextStyle(fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal)),
              onPressed: () {
                state.jumpTo(
                  volumeId: _selectedVolumeTab,
                  bookId: book.id,
                  chapter: 1,
                );
                widget.onNavigateToReader();
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDailyVerseCard(AppState state, ThemeData theme) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.wb_sunny_outlined, size: 18, color: Colors.amber),
                const SizedBox(width: 8),
                const Text('Verse of the Day', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.amber)),
                const Spacer(),
                const Text('1 Nephi 3:7', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '"I will go and do the things which the Lord hath commanded, for I know that the Lord giveth no commandments unto the children of men, save he shall prepare a way for them that they may accomplish the thing which he commandeth them."',
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                icon: const Icon(Icons.read_more, size: 16),
                label: const Text('Read in Context'),
                onPressed: () {
                  state.jumpTo(volumeId: 'bom', bookId: '1-ne', chapter: 3, verse: 7);
                  widget.onNavigateToReader();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, AppState state, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Study Tools & Utilities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildActionTile(
                icon: Icons.spellcheck,
                color: Colors.blue,
                title: 'Dictionary',
                subtitle: 'On-device lexicon',
                onTap: () => DictionaryLookupSheet.show(context),
                theme: theme,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildActionTile(
                icon: Icons.vertical_split_outlined,
                color: Colors.teal,
                title: 'Parallel Study',
                subtitle: 'Side-by-side BOM & KJV',
                onTap: widget.onNavigateToParallel,
                theme: theme,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildActionTile(
                icon: Icons.search,
                color: Colors.purple,
                title: 'Search Text',
                subtitle: 'Quotes & topics',
                onTap: widget.onNavigateToSearch,
                theme: theme,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildActionTile(
                icon: Icons.bookmark_outline,
                color: Colors.orange,
                title: 'My Notes',
                subtitle: 'Highlights & tags',
                onTap: widget.onNavigateToNotes,
                theme: theme,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant.withOpacity(0.35),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Text(subtitle, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

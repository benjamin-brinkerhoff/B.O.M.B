import 'package:flutter/material.dart';
import '../../../core/models/scripture_models.dart';
import '../../../core/state/app_scope.dart';

/// Global scripture and user note search screen.
class SearchScreen extends StatefulWidget {
  final VoidCallback onNavigateToReader;

  const SearchScreen({super.key, required this.onNavigateToReader});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all'; // 'all', 'bom', 'ot', 'nt', 'notes'

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final theme = Theme.of(context);
    final query = _searchController.text.trim();

    String? volumeFilter;
    bool notesOnly = false;

    if (_selectedFilter == 'bom' || _selectedFilter == 'ot' || _selectedFilter == 'nt') {
      volumeFilter = _selectedFilter;
    } else if (_selectedFilter == 'notes') {
      notesOnly = true;
    }

    final results = state.search(
      query: query,
      volumeFilter: volumeFilter,
      searchNotesOnly: notesOnly,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Scriptures & Notes', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // Search Input Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Search verses, quotes, or notes (e.g. faith, light, nephi)...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Row(
              children: [
                _buildFilterChip('All', 'all'),
                const SizedBox(width: 8),
                _buildFilterChip('Book of Mormon', 'bom'),
                const SizedBox(width: 8),
                _buildFilterChip('Old Testament', 'ot'),
                const SizedBox(width: 8),
                _buildFilterChip('New Testament', 'nt'),
                const SizedBox(width: 8),
                _buildFilterChip('My Notes', 'notes', icon: Icons.note_alt_outlined),
              ],
            ),
          ),

          const Divider(height: 16),

          // Search Results
          Expanded(
            child: query.isEmpty
                ? _buildEmptyState(theme)
                : results.isEmpty
                    ? _buildNoResults(query, theme)
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final res = results[index];
                          return _buildResultCard(res, state, theme);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, {IconData? icon}) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      avatar: icon != null ? Icon(icon, size: 16) : null,
      selected: isSelected,
      onSelected: (_) {
        setState(() {
          _selectedFilter = value;
        });
      },
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: theme.colorScheme.outline.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            'Search across all scripture volumes and your personal study notes.',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: ['faith', 'charity', 'commandments', 'shepherd', 'prayer'].map((s) {
              return ActionChip(
                label: Text(s),
                onPressed: () {
                  setState(() {
                    _searchController.text = s;
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults(String query, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 56, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              'No matching verses or notes found for "$query"',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Try different keywords, checking your spelling, or selecting "All" filters.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(SearchResult res, AppState state, ThemeData theme) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          // Resolve volume & book id
          final volId = res.volumeTitle.contains('Mormon')
              ? 'bom'
              : (res.volumeTitle.contains('Old') ? 'ot' : 'nt');
          final vol = state.currentVolume;
          final book = vol.books.firstWhere(
            (b) => b.title.toLowerCase() == res.bookTitle.toLowerCase(),
            orElse: () => vol.books.first,
          );

          state.jumpTo(
            volumeId: volId,
            bookId: book.id,
            chapter: res.chapter,
            verse: res.verseNumber,
          );

          widget.onNavigateToReader();
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      res.volumeTitle,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    res.reference,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const Spacer(),
                  if (res.isNoteMatch)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.edit_note, size: 14, color: Colors.brown),
                          SizedBox(width: 2),
                          Text('My Note', style: TextStyle(fontSize: 11, color: Colors.brown)),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                res.verseText,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              if (res.isNoteMatch && res.matchedNote != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.format_quote, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Note: \${res.matchedNote}',
                          style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

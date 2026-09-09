import 'package:flutter/material.dart';
import '../../../core/data/scripture_canon.dart';
import '../../../core/models/scripture_models.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/state/app_state.dart';

/// Interactive 3-stage modal navigation:
/// 1. Volume selection (Book of Mormon, Old Testament, New Testament) + Bible Translation
/// 2. Book selection (e.g. Matthew, 1 Nephi, Genesis)
/// 3. Chapter picker grid
class ScripturePickerDialog extends StatefulWidget {
  const ScripturePickerDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const ScripturePickerDialog(),
    );
  }

  @override
  State<ScripturePickerDialog> createState() => _ScripturePickerDialogState();
}

class _ScripturePickerDialogState extends State<ScripturePickerDialog> {
  late String _selectedVolumeId;
  ScriptureBook? _selectedBook;
  int _currentStep = 0; // 0: Select Book, 1: Select Chapter

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = AppScope.of(context);
    _selectedVolumeId = state.currentVolumeId;
    _selectedBook ??= state.currentBook;
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final theme = Theme.of(context);
    final volume = ScriptureCanon.getVolume(_selectedVolumeId);

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Dialog Header & Step Back Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        setState(() {
                          _currentStep = 0;
                        });
                      },
                    ),
                  Expanded(
                    child: Text(
                      _currentStep == 0
                          ? 'Select Book'
                          : '${_selectedBook?.title ?? ''} — Select Chapter',
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Volume Tabs
            if (_currentStep == 0) ...[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'bom', label: Text('Book of Mormon')),
                    ButtonSegment(value: 'ot', label: Text('Old Test.')),
                    ButtonSegment(value: 'nt', label: Text('New Test.')),
                  ],
                  selected: {_selectedVolumeId},
                  onSelectionChanged: (set) {
                    setState(() {
                      _selectedVolumeId = set.first;
                      final vol = ScriptureCanon.getVolume(_selectedVolumeId);
                      _selectedBook = vol.books.isNotEmpty ? vol.books.first : null;
                    });
                  },
                ),
              ),

              // Bible Translation Indicator if OT/NT selected
              if (_selectedVolumeId != 'bom')
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.translate, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'Translation: ${state.currentBibleVersion.name} (${state.currentBibleVersion.abbreviation})',
                        style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => _showTranslationPicker(context, state),
                        child: const Text('Change'),
                      ),
                    ],
                  ),
                ),
            ],

            // Content Area (Books Grid or Chapters Grid)
            Expanded(
              child: _currentStep == 0
                  ? _buildBooksList(volume, scrollController)
                  : _buildChaptersGrid(state, scrollController),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBooksList(ScriptureVolume volume, ScrollController scrollController) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      itemCount: volume.books.length,
      itemBuilder: (context, index) {
        final book = volume.books[index];
        final isSelected = _selectedBook?.id == book.id && _selectedVolumeId == book.volumeId;

        return Card(
          elevation: 0,
          color: isSelected ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5) : null,
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            title: Text(book.title, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text('${book.chapterCount} ${book.chapterCount == 1 ? 'Chapter' : 'Chapters'}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              setState(() {
                _selectedBook = book;
                _currentStep = 1; // Transition to chapter picker
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildChaptersGrid(AppState state, ScrollController scrollController) {
    final book = _selectedBook!;
    final count = book.chapterCount;
    final theme = Theme.of(context);

    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 64,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: count,
      itemBuilder: (context, index) {
        final chapterNum = index + 1;
        final isCurrent = state.currentVolumeId == _selectedVolumeId &&
            state.currentBookId == book.id &&
            state.currentChapter == chapterNum;

        return InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            state.jumpTo(
              volumeId: _selectedVolumeId,
              bookId: book.id,
              chapter: chapterNum,
            );
            Navigator.of(context).pop();
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isCurrent
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surfaceVariant.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isCurrent ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
              ),
            ),
            child: Text(
              '$chapterNum',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isCurrent ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }

  void _showTranslationPicker(BuildContext context, AppState state) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select Bible Translation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ScriptureCanon.bibleVersions.map((ver) {
            final isSelected = ver.id == state.currentBibleVersionId;
            return ListTile(
              leading: Icon(isSelected ? Icons.check_circle : Icons.radio_button_unchecked),
              title: Text('${ver.name} (${ver.abbreviation})'),
              subtitle: Text(ver.description),
              onTap: () {
                state.setBibleVersion(ver.id);
                Navigator.of(ctx).pop();
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

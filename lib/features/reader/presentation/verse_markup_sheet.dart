import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/data/scripture_canon.dart';
import '../../../core/models/scripture_models.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/state/app_state.dart';
import '../../study_tools/presentation/dictionary_lookup_sheet.dart';

/// Bottom sheet for highlighting, personal notes, custom tagging,
/// and personal scripture-to-scripture cross-referencing.
class VerseMarkupSheet extends StatefulWidget {
  final ScriptureVerse verse;
  final String bookTitle;

  const VerseMarkupSheet({
    super.key,
    required this.verse,
    required this.bookTitle,
  });

  static Future<void> show(BuildContext context, ScriptureVerse verse, String bookTitle) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => VerseMarkupSheet(verse: verse, bookTitle: bookTitle),
    );
  }

  @override
  State<VerseMarkupSheet> createState() => _VerseMarkupSheetState();
}

class _VerseMarkupSheetState extends State<VerseMarkupSheet> {
  late TextEditingController _noteController;
  late TextEditingController _tagController;
  HighlightColor? _selectedColor;
  List<String> _tags = [];
  List<String> _linkedKeys = [];

  final List<String> _suggestedTags = const [
    'Faith', 'Commandments', 'Prayer', 'Atonement', 'Service',
    'Covenants', 'Prophecy', 'Priesthood', 'Repentance', 'Joy'
  ];

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
    _tagController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = AppScope.of(context);
    final ann = state.getAnnotation(
      widget.verse.volumeId,
      widget.verse.bookId,
      widget.verse.chapter,
      widget.verse.verseNumber,
    );
    _selectedColor = ann?.highlightColor;
    _tags = List<String>.from(ann?.tags ?? []);
    _linkedKeys = List<String>.from(ann?.linkedVerseKeys ?? []);
    if (_noteController.text.isEmpty && ann?.note != null) {
      _noteController.text = ann!.note!;
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  void _addTag(String tag) {
    final clean = tag.trim();
    if (clean.isEmpty || _tags.contains(clean)) return;
    setState(() {
      _tags.add(clean);
    });
    final state = AppScope.of(context);
    state.addTag(
      widget.verse.volumeId,
      widget.verse.bookId,
      widget.verse.chapter,
      widget.verse.verseNumber,
      clean,
    );
    _tagController.clear();
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
    final state = AppScope.of(context);
    state.removeTag(
      widget.verse.volumeId,
      widget.verse.bookId,
      widget.verse.chapter,
      widget.verse.verseNumber,
      tag,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final theme = Theme.of(context);
    final reference = '${widget.bookTitle} ${widget.verse.chapter}:${widget.verse.verseNumber}';

    return Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Center drag pill
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header & Fast Action Buttons
            Row(
              children: [
                Expanded(
                  child: Text(
                    reference,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.spellcheck, size: 20),
                  tooltip: 'Define Terms',
                  onPressed: () {
                    DictionaryLookupSheet.show(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.copy, size: 20),
                  tooltip: 'Copy Verse',
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: '$reference - "${widget.verse.text}"'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Verse copied to clipboard')),
                    );
                  },
                ),
              ],
            ),

            // Verse Text Quote
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant.withOpacity(0.35),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.verse.text,
                style: theme.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic, height: 1.5),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 12),

            // 1. Highlighting Section
            const Text('Highlight Color', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 8),
            Row(
              children: [
                ...HighlightColor.values.map((color) {
                  final isSelected = _selectedColor == color;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedColor = color);
                      state.setHighlight(
                        widget.verse.volumeId,
                        widget.verse.bookId,
                        widget.verse.chapter,
                        widget.verse.verseNumber,
                        color,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: color.color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? theme.colorScheme.primary : Colors.grey.shade400,
                          width: isSelected ? 3 : 1,
                        ),
                      ),
                      child: isSelected ? Icon(Icons.check, size: 16, color: Colors.grey.shade900) : null,
                    ),
                  );
                }),
                if (_selectedColor != null)
                  IconButton(
                    icon: const Icon(Icons.format_color_reset, size: 20),
                    tooltip: 'Remove Highlight',
                    onPressed: () {
                      setState(() => _selectedColor = null);
                      state.setHighlight(
                        widget.verse.volumeId,
                        widget.verse.bookId,
                        widget.verse.chapter,
                        widget.verse.verseNumber,
                        null,
                      );
                    },
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // 2. Personal Cross-Reference Linking Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Personal Cross-References', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                TextButton.icon(
                  icon: const Icon(Icons.add_link, size: 16),
                  label: const Text('Link Scripture'),
                  onPressed: () => _showLinkScriptureDialog(context, state),
                ),
              ],
            ),
            if (_linkedKeys.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'No personal cross-references linked yet.',
                  style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                ),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: _linkedKeys.map((key) {
                  return Chip(
                    avatar: const Icon(Icons.link, size: 14),
                    label: Text(_formatKey(key)),
                    deleteIcon: const Icon(Icons.close, size: 14),
                    onDeleted: () {
                      setState(() => _linkedKeys.remove(key));
                      state.unlinkVerse(widget.verse.referenceKey, key);
                    },
                  );
                }).toList(),
              ),

            const SizedBox(height: 16),

            // 3. Tagging & Topics Section
            const Text('Tags & Study Topics', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 8),

            // Current Tags
            if (_tags.isNotEmpty)
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: _tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    backgroundColor: theme.colorScheme.primaryContainer.withOpacity(0.5),
                    deleteIcon: const Icon(Icons.close, size: 14),
                    onDeleted: () => _removeTag(tag),
                  );
                }).toList(),
              ),

            // Add Custom Tag Input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tagController,
                    decoration: const InputDecoration(
                      hintText: 'Add custom tag...',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                    onSubmitted: _addTag,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.blue),
                  onPressed: () => _addTag(_tagController.text),
                ),
              ],
            ),

            const SizedBox(height: 8),
            // Suggested Tag Chips
            Wrap(
              spacing: 6,
              children: _suggestedTags
                  .where((t) => !_tags.contains(t))
                  .take(5)
                  .map((t) {
                return ActionChip(
                  label: Text('+$t', style: const TextStyle(fontSize: 11)),
                  onPressed: () => _addTag(t),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // 4. Note Section
            const Text('Personal Study Note', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Record personal insights, impressions, or cross-references...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
            ),

            const SizedBox(height: 12),

            // Save Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_noteController.text.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      _noteController.clear();
                      state.setNote(
                        widget.verse.volumeId,
                        widget.verse.bookId,
                        widget.verse.chapter,
                        widget.verse.verseNumber,
                        null,
                      );
                    },
                    child: const Text('Clear Note', style: TextStyle(color: Colors.red)),
                  ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.check, size: 18),
                  label: const Text('Save & Close'),
                  onPressed: () {
                    state.setNote(
                      widget.verse.volumeId,
                      widget.verse.bookId,
                      widget.verse.chapter,
                      widget.verse.verseNumber,
                      _noteController.text,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatKey(String key) {
    final parts = key.split(':');
    if (parts.length != 4) return key;
    final book = ScriptureCanon.getBook(parts[0], parts[1]);
    return '${book?.title ?? parts[1]} ${parts[2]}:${parts[3]}';
  }

  void _showLinkScriptureDialog(BuildContext context, AppState state) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Quick Cross-Reference Links'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose a passage to link with this verse:'),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('1 Nephi 3:7'),
              subtitle: const Text('I will go and do'),
              onTap: () {
                final targetKey = 'bom:1-ne:3:7';
                state.linkVerses(widget.verse.referenceKey, targetKey);
                setState(() {
                  if (!_linkedKeys.contains(targetKey)) _linkedKeys.add(targetKey);
                });
                Navigator.of(ctx).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('James 1:5'),
              subtitle: const Text('If any of you lack wisdom'),
              onTap: () {
                final targetKey = 'nt:james:1:5';
                state.linkVerses(widget.verse.referenceKey, targetKey);
                setState(() {
                  if (!_linkedKeys.contains(targetKey)) _linkedKeys.add(targetKey);
                });
                Navigator.of(ctx).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Alma 32:21'),
              subtitle: const Text('Faith is hope in unseen truth'),
              onTap: () {
                final targetKey = 'bom:alma:32:21';
                state.linkVerses(widget.verse.referenceKey, targetKey);
                setState(() {
                  if (!_linkedKeys.contains(targetKey)) _linkedKeys.add(targetKey);
                });
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

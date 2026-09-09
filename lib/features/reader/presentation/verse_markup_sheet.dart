import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/models/scripture_models.dart';
import '../../../core/state/app_scope.dart';

/// Bottom sheet for highlighting and taking personal notes on an individual verse.
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
  HighlightColor? _selectedColor;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
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
    if (_noteController.text.isEmpty && ann?.note != null) {
      _noteController.text = ann!.note!;
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final theme = Theme.of(context);
    final reference = '\${widget.bookTitle} \${widget.verse.chapter}:\${widget.verse.verseNumber}';

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
            // Center pill handle
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

            // Verse Reference & Quick Copy
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  reference,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy, size: 20),
                  tooltip: 'Copy Verse',
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: '\$reference - "\${widget.verse.text}"'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Verse copied to clipboard')),
                    );
                  },
                ),
              ],
            ),

            // Verse Text Quote Card
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

            // Highlight Section
            const Text(
              'Highlight Color',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ...HighlightColor.values.map((color) {
                  final isSelected = _selectedColor == color;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = color;
                      });
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
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color.color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? theme.colorScheme.primary : Colors.grey.shade400,
                          width: isSelected ? 3 : 1,
                        ),
                      ),
                      child: isSelected
                          ? Icon(Icons.check, size: 18, color: Colors.grey.shade900)
                          : null,
                    ),
                  );
                }),
                // Clear Highlight Button
                if (_selectedColor != null)
                  IconButton(
                    icon: const Icon(Icons.format_color_reset, size: 20),
                    tooltip: 'Remove Highlight',
                    onPressed: () {
                      setState(() {
                        _selectedColor = null;
                      });
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

            const SizedBox(height: 18),

            // Note Section
            const Text(
              'Personal Study Note',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Record personal insights, impressions, or cross-references...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
            ),
            const SizedBox(height: 12),

            // Save / Clear Note Actions
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
                  icon: const Icon(Icons.save, size: 18),
                  label: const Text('Save Note'),
                  onPressed: () {
                    state.setNote(
                      widget.verse.volumeId,
                      widget.verse.bookId,
                      widget.verse.chapter,
                      widget.verse.verseNumber,
                      _noteController.text,
                    );
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Note saved and indexed for search')),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

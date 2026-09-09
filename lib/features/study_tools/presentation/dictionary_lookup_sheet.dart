import 'package:flutter/material.dart';
import '../../../core/models/scripture_models.dart';
import '../../../core/state/app_scope.dart';

/// On-device dictionary lookup sheet for words and theological terms.
class DictionaryLookupSheet extends StatefulWidget {
  final String? initialWord;

  const DictionaryLookupSheet({super.key, this.initialWord});

  static Future<void> show(BuildContext context, {String? initialWord}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DictionaryLookupSheet(initialWord: initialWord),
    );
  }

  @override
  State<DictionaryLookupSheet> createState() => _DictionaryLookupSheetState();
}

class _DictionaryLookupSheetState extends State<DictionaryLookupSheet> {
  late TextEditingController _controller;
  DictionaryEntry? _entry;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialWord ?? '');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller.text.isNotEmpty && _entry == null) {
      final state = AppScope.of(context);
      _entry = state.lookupDictionary(_controller.text);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search(String query) {
    if (query.trim().isEmpty) return;
    final state = AppScope.of(context);
    setState(() {
      _entry = state.lookupDictionary(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Center drag handle
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

            Row(
              children: [
                Icon(Icons.spellcheck, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'On-Device Scripture Dictionary',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Search Bar
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter word to define (e.g. charity, goodly, faith)...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => _search(_controller.text),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onSubmitted: _search,
            ),

            const SizedBox(height: 16),

            // Definition Result Box
            if (_entry != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          _entry!.word,
                          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _entry!.partOfSpeech,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _entry!.definition,
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.5, fontSize: 15),
                    ),
                    if (_entry!.etymology != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Origin & Etymology:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: theme.colorScheme.outline),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _entry!.etymology!,
                        style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                      ),
                    ],
                    if (_entry!.sampleOccurrences.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Scriptural Occurrences:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: theme.colorScheme.outline),
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 6,
                        children: _entry!.sampleOccurrences.map((occ) {
                          return Chip(
                            label: Text(occ, style: const TextStyle(fontSize: 11)),
                            visualDensity: VisualDensity.compact,
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/data/scripture_dictionary.dart';
import '../../../core/models/scripture_models.dart';
import '../../../core/services/device_dictionary_service.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/state/app_state.dart';

/// Interactive on-device dictionary lookup sheet with autocomplete,
/// rich theological/archaic definitions, and system dictionary search.
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
  List<String> _suggestions = [];

  @override
  void initState() {
    super.initState();
    final initial = widget.initialWord ?? '';
    _controller = TextEditingController(text: initial);
    _suggestions = ScriptureDictionary.getSuggestions(initial);
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
    final clean = query.trim();
    if (clean.isEmpty) return;
    final state = AppScope.of(context);
    setState(() {
      _controller.text = clean;
      _entry = state.lookupDictionary(clean);
      _suggestions = ScriptureDictionary.getSuggestions(clean);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final featuredWords = ScriptureDictionary.getFeaturedWords();

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

            // Header
            Row(
              children: [
                const Icon(Icons.spellcheck, color: Color(0xFF1976D2)),
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
              autofocus: widget.initialWord == null,
              decoration: InputDecoration(
                hintText: 'Search word to define (e.g. goodly, charity, grace)...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _controller.clear();
                            _suggestions = ScriptureDictionary.getSuggestions('');
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (text) {
                setState(() {
                  _suggestions = ScriptureDictionary.getSuggestions(text);
                });
              },
              onSubmitted: _search,
            ),

            // Suggestions / Autocomplete Bar
            if (_suggestions.isNotEmpty) ...[
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _suggestions.map((s) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: ActionChip(
                        label: Text(s, style: const TextStyle(fontSize: 12)),
                        onPressed: () => _search(s),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],

            const SizedBox(height: 16),

            // Definition Result Card
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
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.copy, size: 18),
                          tooltip: 'Copy Definition',
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: '${_entry!.word} (${_entry!.partOfSpeech}): ${_entry!.definition}'));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Definition copied to clipboard')),
                            );
                          },
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
                        'Canonical Scripture Occurrences:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: theme.colorScheme.outline),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: _entry!.sampleOccurrences.map((occ) {
                          return Chip(
                            label: Text(occ, style: const TextStyle(fontSize: 11)),
                            visualDensity: VisualDensity.compact,
                          );
                        }).toList(),
                      ),
                    ],

                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),

                    // Device / System Dictionary Action
                    Center(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.phone_iphone, size: 18),
                        label: Text('Open Downloaded Device Dictionary for "${_entry!.word}"'),
                        onPressed: () async {
                          final opened = await DeviceDictionaryService.openDeviceDictionary(_entry!.word);
                          if (!opened && context.mounted) {
                            Clipboard.setData(ClipboardData(text: _entry!.word));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Looking up "${_entry!.word}" in on-device lexicon.')),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            // Featured Study Terms
            const Text(
              'Explore Doctrinal & Archaic Terminology',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: featuredWords.map((w) {
                return ActionChip(
                  label: Text(w, style: const TextStyle(fontSize: 12)),
                  onPressed: () => _search(w),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

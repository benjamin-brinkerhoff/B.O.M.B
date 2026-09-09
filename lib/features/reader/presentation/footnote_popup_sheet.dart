import 'package:flutter/material.dart';
import '../../../core/models/scripture_models.dart';
import '../../../core/state/app_scope.dart';
import '../../study_tools/presentation/dictionary_lookup_sheet.dart';

/// Interactive modal sheet displaying Church-standard footnote cross-references,
/// linguistic definitions, and Topical Guide links.
class FootnotePopupSheet extends StatelessWidget {
  final ScriptureFootnote footnote;

  const FootnotePopupSheet({super.key, required this.footnote});

  static Future<void> show(BuildContext context, ScriptureFootnote footnote) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => FootnotePopupSheet(footnote: footnote),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.35,
      maxChildSize: 0.85,
      expand: false,
      builder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Footnote Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1976D2).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    footnote.footnoteKey,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1565C0),
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '"\${footnote.word}"',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                OutlinedButton.icon(
                  icon: const Icon(Icons.menu_book, size: 16),
                  label: const Text('Define'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    DictionaryLookupSheet.show(context, initialWord: footnote.word);
                  },
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Definition Block
            if (footnote.definition != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, size: 18, color: theme.colorScheme.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        footnote.definition!,
                        style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
                      ),
                    ),
                  ],
                ),
              ),

            // Topical Guide Reference
            if (footnote.topicalGuideTopic != null) ...[
              const SizedBox(height: 14),
              Row(
                children: [
                  const Icon(Icons.topic_outlined, size: 18, color: Colors.teal),
                  const SizedBox(width: 8),
                  Text(
                    footnote.topicalGuideTopic!,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 18),

            // Cross-Referenced Passages
            const Text(
              'Cross-References',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),

            if (footnote.references.isEmpty)
              const Text('No direct cross-references recorded.')
            else
              ...footnote.references.map((ref) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6.0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: theme.colorScheme.outlineVariant),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    title: Text(
                      ref.displayReference,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    subtitle: ref.previewText != null
                        ? Text(
                            ref.previewText!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          )
                        : null,
                    trailing: const Icon(Icons.arrow_forward, size: 18),
                    onTap: () {
                      state.jumpTo(
                        volumeId: ref.volumeId,
                        bookId: ref.bookId,
                        chapter: ref.chapter,
                        verse: ref.verseNumber,
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                );
              }),

            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/data/scripture_canon.dart';
import '../../../core/state/app_scope.dart';

/// Screen for controlling reading styles: theme (light/dark), font family, font size, and translations.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading Styles & Settings', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Reading Live Preview Box
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant.withOpacity(0.35),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.preview, size: 18, color: theme.colorScheme.primary),
                    const SizedBox(width: 8),
                    Text('Live Typography Preview', style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'And it came to pass that I, Nephi, said unto my father: I will go and do the things which the Lord hath commanded.',
                  style: state.getReaderTextStyle(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Section: Theme Mode
          const Text('Display Theme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(value: ThemeMode.system, label: Text('System'), icon: Icon(Icons.brightness_auto)),
              ButtonSegment(value: ThemeMode.light, label: Text('Light'), icon: Icon(Icons.light_mode)),
              ButtonSegment(value: ThemeMode.dark, label: Text('Dark'), icon: Icon(Icons.dark_mode)),
            ],
            selected: {state.themeMode},
            onSelectionChanged: (set) => state.setThemeMode(set.first),
          ),

          const SizedBox(height: 24),

          // Section: Reading Font Family
          const Text('Reading Typeface', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          RadioListTile<String>(
            title: const Text('Times New Roman / Editorial Serif', style: TextStyle(fontFamilyFallback: ['Times New Roman', 'Times', 'serif'])),
            subtitle: const Text('Classic literary font suited for extended scripture reading'),
            value: 'serif',
            groupValue: state.fontFamilyOption,
            onChanged: (val) => state.setFontFamilyOption(val!),
          ),
          RadioListTile<String>(
            title: const Text('Arial / Clean Sans-Serif', style: TextStyle(fontFamilyFallback: ['Arial', 'Helvetica', 'sans-serif'])),
            subtitle: const Text('Modern, high-legibility sans-serif typeface'),
            value: 'sansSerif',
            groupValue: state.fontFamilyOption,
            onChanged: (val) => state.setFontFamilyOption(val!),
          ),
          RadioListTile<String>(
            title: const Text('Georgia / Soft Serif', style: TextStyle(fontFamilyFallback: ['Georgia', 'serif'])),
            subtitle: const Text('Warm, elegant digital reading font'),
            value: 'georgia',
            groupValue: state.fontFamilyOption,
            onChanged: (val) => state.setFontFamilyOption(val!),
          ),

          const SizedBox(height: 24),

          // Section: Font Size Slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Font Size', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text('\${state.fontSize.round()} pt', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Slider(
            value: state.fontSize,
            min: 13.0,
            max: 28.0,
            divisions: 15,
            label: '\${state.fontSize.round()} pt',
            onChanged: (size) => state.setFontSize(size),
          ),

          const Divider(height: 36),

          // Section: Bible Translation
          const Text('Primary Bible Translation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          ...ScriptureCanon.bibleVersions.map((v) {
            final isSelected = v.id == state.currentBibleVersionId;
            return RadioListTile<String>(
              title: Text('\${v.name} (\${v.abbreviation})'),
              subtitle: Text(v.description),
              value: v.id,
              groupValue: state.currentBibleVersionId,
              onChanged: (val) => state.setBibleVersion(val!),
            );
          }),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

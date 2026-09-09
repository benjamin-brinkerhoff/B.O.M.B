import 'package:flutter/material.dart';

/// Comparative parallel study screen allowing side-by-side examination
/// of the Book of Mormon and Bible passages.
class ParallelStudyScreen extends StatelessWidget {
  const ParallelStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parallel Study'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 650;

          if (isCompact) {
            // Stacked layout for compact phone view
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildPaneHeader('Book of Mormon (2 Nephi 12:2)', theme),
                _buildPaneContent('And it shall come to pass in the last days, when the mountain of the Lord’s house shall be established in the top of the mountains, and shall be exalted above the hills, and all nations shall flow unto it.', theme),
                const Divider(height: 36),
                _buildPaneHeader('Old Testament (Isaiah 2:2)', theme),
                _buildPaneContent('And it shall come to pass in the last days, that the mountain of the Lord’s house shall be established in the top of the mountains, and shall be exalted above the hills; and all nations shall flow unto it.', theme),
              ],
            );
          } else {
            // Side-by-side columns for wide screen/desktop
            return Row(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(20.0),
                    children: [
                      _buildPaneHeader('Book of Mormon (2 Nephi 12:2)', theme),
                      const SizedBox(height: 8),
                      _buildPaneContent('And it shall come to pass in the last days, when the mountain of the Lord’s house shall be established in the top of the mountains, and shall be exalted above the hills, and all nations shall flow unto it.', theme),
                    ],
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(20.0),
                    children: [
                      _buildPaneHeader('Old Testament (Isaiah 2:2)', theme),
                      const SizedBox(height: 8),
                      _buildPaneContent('And it shall come to pass in the last days, that the mountain of the Lord’s house shall be established in the top of the mountains, and shall be exalted above the hills; and all nations shall flow unto it.', theme),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildPaneHeader(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildPaneContent(String text, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        text,
        style: theme.textTheme.bodyLarge?.copyWith(height: 1.6, fontSize: 16),
      ),
    );
  }
}

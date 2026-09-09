import 'package:flutter/material.dart';

/// Study aids including search, topical guide, and personal annotations.
class StudyToolsScreen extends StatelessWidget {
  const StudyToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Tools'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search verses, topics, or keywords...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 20),
          _buildToolTile(
            icon: Icons.alt_route,
            title: 'Cross-Reference Index',
            subtitle: 'Direct links connecting Book of Mormon prophecies with Biblical texts',
            onTap: () {},
          ),
          _buildToolTile(
            icon: Icons.subject,
            title: 'Topical Guide',
            subtitle: 'Study themes across all scripture volumes',
            onTap: () {},
          ),
          _buildToolTile(
            icon: Icons.bookmark_outline,
            title: 'Saved Bookmarks & Highlights',
            subtitle: 'Access marked verses and personal insights',
            onTap: () {},
          ),
          _buildToolTile(
            icon: Icons.note_alt_outlined,
            title: 'Study Journal & Notes',
            subtitle: 'Personal reflections stored securely offline',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildToolTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Application preferences for reading typography, themes, and cross-platform options.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _fontSize = 16.0;
  bool _serifFont = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Typography & Display', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          ListTile(
            title: const Text('Font Size'),
            subtitle: Slider(
              value: _fontSize,
              min: 12,
              max: 28,
              divisions: 8,
              label: '\${_fontSize.round()} pt',
              onChanged: (val) => setState(() => _fontSize = val),
            ),
          ),
          SwitchListTile(
            title: const Text('Serif Reading Typeface'),
            subtitle: const Text('Uses traditional scripture typography for long reading sessions'),
            value: _serifFont,
            onChanged: (val) => setState(() => _serifFont = val),
          ),
          const Divider(height: 32),
          const Text('About B.O.M.B', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Version'),
            subtitle: Text('0.1.0+1 (Cross-Platform Framework)'),
          ),
          const ListTile(
            leading: Icon(Icons.devices),
            title: Text('Platform Targets'),
            subtitle: Text('iOS, Android, Windows, macOS, Linux'),
          ),
        ],
      ),
    );
  }
}

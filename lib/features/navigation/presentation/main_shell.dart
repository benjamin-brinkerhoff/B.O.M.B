import 'package:flutter/material.dart';
import '../../reader/presentation/reader_screen.dart';
import '../../study/presentation/parallel_study_screen.dart';
import '../../study_tools/presentation/study_tools_screen.dart';
import '../../settings/presentation/settings_screen.dart';

/// Adaptive navigation shell providing a BottomNavigationBar on compact mobile screens
/// and a NavigationRail sidebar on wide desktop/tablet displays.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final List<Widget> _destinations = const [
    ReaderScreen(),
    ParallelStudyScreen(),
    StudyToolsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWideScreen = constraints.maxWidth >= 720;

        if (isWideScreen) {
          // Desktop & Tablet Navigation Rail Layout
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() => _selectedIndex = index);
                  },
                  labelType: NavigationRailLabelType.all,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        Icon(Icons.menu_book, color: Theme.of(context).colorScheme.primary, size: 32),
                        const SizedBox(height: 4),
                        Text(
                          'B.O.M.B',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.book_outlined),
                      selectedIcon: Icon(Icons.book),
                      label: Text('Scriptures'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.vertical_split_outlined),
                      selectedIcon: Icon(Icons.vertical_split),
                      label: Text('Parallel Study'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.auto_stories_outlined),
                      selectedIcon: Icon(Icons.auto_stories),
                      label: Text('Tools'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: Text('Settings'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: _destinations[_selectedIndex]),
              ],
            ),
          );
        } else {
          // Mobile Bottom Navigation Bar Layout (iOS & Android)
          return Scaffold(
            body: _destinations[_selectedIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.book_outlined),
                  selectedIcon: Icon(Icons.book),
                  label: 'Scriptures',
                ),
                NavigationDestination(
                  icon: Icon(Icons.vertical_split_outlined),
                  selectedIcon: Icon(Icons.vertical_split),
                  label: 'Parallel',
                ),
                NavigationDestination(
                  icon: Icon(Icons.auto_stories_outlined),
                  selectedIcon: Icon(Icons.auto_stories),
                  label: 'Tools',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

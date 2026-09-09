import 'package:flutter/material.dart';
import '../../reader/presentation/reader_screen.dart';
import '../../search/presentation/search_screen.dart';
import '../../notes/presentation/notes_screen.dart';
import '../../study/presentation/parallel_study_screen.dart';
import '../../settings/presentation/settings_screen.dart';

/// Main application shell providing responsive navigation:
/// - BottomNavigationBar for mobile screens (iOS & Android)
/// - NavigationRail sidebar for wider desktop and tablet displays (Windows, macOS, Linux)
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  void _navigateToReader() {
    setState(() => _selectedIndex = 0);
  }

  @override
  Widget build(BuildContext context) {
    final destinations = [
      const ReaderScreen(),
      SearchScreen(onNavigateToReader: _navigateToReader),
      NotesScreen(onNavigateToReader: _navigateToReader),
      const ParallelStudyScreen(),
      const SettingsScreen(),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWideScreen = constraints.maxWidth >= 760;

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
                        Icon(Icons.menu_book, color: Theme.of(context).colorScheme.primary, size: 30),
                        const SizedBox(height: 4),
                        Text(
                          'B.O.M.B',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.auto_stories_outlined),
                      selectedIcon: Icon(Icons.auto_stories),
                      label: Text('Read'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.search_outlined),
                      selectedIcon: Icon(Icons.search),
                      label: Text('Search'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.bookmark_outline),
                      selectedIcon: Icon(Icons.bookmark),
                      label: Text('Notes'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.vertical_split_outlined),
                      selectedIcon: Icon(Icons.vertical_split),
                      label: Text('Parallel'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: Text('Settings'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: destinations[_selectedIndex]),
              ],
            ),
          );
        } else {
          // Mobile Bottom Navigation Bar Layout (iOS & Android)
          return Scaffold(
            body: destinations[_selectedIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.auto_stories_outlined),
                  selectedIcon: Icon(Icons.auto_stories),
                  label: 'Read',
                ),
                NavigationDestination(
                  icon: Icon(Icons.search_outlined),
                  selectedIcon: Icon(Icons.search),
                  label: 'Search',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bookmark_outline),
                  selectedIcon: Icon(Icons.bookmark),
                  label: 'Notes',
                ),
                NavigationDestination(
                  icon: Icon(Icons.vertical_split_outlined),
                  selectedIcon: Icon(Icons.vertical_split),
                  label: 'Parallel',
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

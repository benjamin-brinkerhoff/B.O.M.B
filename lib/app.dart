import 'package:flutter/material.dart';
import 'core/state/app_state.dart';
import 'core/state/app_scope.dart';
import 'core/theme/app_theme.dart';
import 'features/navigation/presentation/main_shell.dart';

/// The root widget of the B.O.M.B study application.
class BombApp extends StatefulWidget {
  const BombApp({super.key});

  @override
  State<BombApp> createState() => _BombAppState();
}

class _BombAppState extends State<BombApp> {
  late final AppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = AppState();
  }

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      notifier: _appState,
      child: ListenableBuilder(
        listenable: _appState,
        builder: (context, _) {
          return MaterialApp(
            title: 'B.O.M.B - Book of Mormon & Bible Study',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: _appState.themeMode,
            home: const MainShell(),
          );
        },
      ),
    );
  }
}

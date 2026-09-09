import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/navigation/presentation/main_shell.dart';

/// The root widget of the B.O.M.B study application.
class BombApp extends StatelessWidget {
  const BombApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'B.O.M.B',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const MainShell(),
    );
  }
}

import 'package:flutter/material.dart';
import 'app_state.dart';
export 'app_state.dart';

/// InheritedWidget providing AppState down the widget hierarchy.
class AppScope extends InheritedNotifier<AppState> {
  const AppScope({
    super.key,
    required AppState super.notifier,
    required super.child,
  });

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null && scope.notifier != null, 'No AppScope found in context');
    return scope!.notifier!;
  }
}

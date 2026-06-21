import 'package:condorcode_admin/di/provider_manager.dart';
import 'package:data/data_sources/shared_pref/shared_preferences_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier({required SharedPreferencesManager sharedPreferencesManager})
    : _sharedPreferencesManager = sharedPreferencesManager,
      super(ThemeMode.light) {
    _loadThemeMode();
  }

  final SharedPreferencesManager _sharedPreferencesManager;

  Future<void> _loadThemeMode() async {
    final saved = await _sharedPreferencesManager.getThemeMode();
    if (saved == 'light') {
      state = ThemeMode.light;
    } else if (saved == 'dark') {
      state = ThemeMode.dark;
    }
  }

  Future<void> toggleTheme() async {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    state = next;
    await _sharedPreferencesManager.saveThemeMode(
      next == ThemeMode.light ? 'light' : 'dark',
    );
  }
}

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
      return ThemeNotifier(sharedPreferencesManager: di());
    });

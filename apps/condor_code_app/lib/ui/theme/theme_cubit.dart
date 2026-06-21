import 'package:data/data_sources/shared_pref/shared_preferences_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit({required SharedPreferencesManager sharedPreferencesManager})
    : _sharedPreferencesManager = sharedPreferencesManager,
      super(ThemeMode.dark) {
    _loadThemeMode();
  }

  final SharedPreferencesManager _sharedPreferencesManager;

  Future<void> _loadThemeMode() async {
    final saved = await _sharedPreferencesManager.getThemeMode();
    if (saved == 'light') {
      emit(ThemeMode.light);
    } else if (saved == 'dark') {
      emit(ThemeMode.dark);
    }
  }

  Future<void> toggleTheme() async {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(next);
    await _sharedPreferencesManager.saveThemeMode(
      next == ThemeMode.light ? 'light' : 'dark',
    );
  }
}

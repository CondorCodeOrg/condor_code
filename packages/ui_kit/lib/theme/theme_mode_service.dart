import 'package:domain/models/enums/theme_mode.dart';
import 'package:domain/repository/theme_mode_repository.dart';
import 'package:flutter/foundation.dart';

class ThemeModeService extends ChangeNotifier {
  ThemeModeService(this._repository);

  final ThemeModeRepository _repository;

  ThemeMode _mode = ThemeMode.dark;

  ThemeMode get mode => _mode;

  Future<void> load() async {
    final result = await _repository.getThemeMode();
    result.fold(
      onSuccess: (mode) {
        if (_mode != mode) {
          _mode = mode;
          notifyListeners();
        }
      },
    );
  }

  Future<void> toggle() async {
    final next = _mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _mode = next;
    notifyListeners();
    await _repository.saveThemeMode(next);
  }
}

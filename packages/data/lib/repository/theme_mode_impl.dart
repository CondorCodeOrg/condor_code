import 'package:data/data_sources/shared_pref/shared_preferences_manager.dart';
import 'package:domain/data_result/data_result.dart';
import 'package:domain/data_result/safe_data_call.dart';
import 'package:domain/models/enums/theme_mode.dart';
import 'package:domain/repository/theme_mode_repository.dart';

class ThemeModeRepositoryImpl implements ThemeModeRepository {
  ThemeModeRepositoryImpl(this._sharedPreferencesManager);

  final SharedPreferencesManager _sharedPreferencesManager;

  @override
  Future<DataResult<ThemeMode>> getThemeMode() async {
    return await safeDataCall(
      dataCall: () async => await _sharedPreferencesManager.getThemeMode(),
      processResult: (themeMode) => SuccessResult<ThemeMode>(themeMode),
    );
  }

  @override
  Future<DataResult<void>> saveThemeMode(ThemeMode themeMode) async {
    return await safeDataCall(
      dataCall: () => _sharedPreferencesManager.saveThemeMode(themeMode),
      processResult: (_) => SuccessResult(null),
    );
  }
}

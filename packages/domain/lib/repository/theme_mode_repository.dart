import 'package:domain/data_result/data_result.dart';
import 'package:domain/models/enums/theme_mode.dart';

abstract class ThemeModeRepository {
  Future<DataResult<ThemeMode>> getThemeMode();
  Future<DataResult<void>> saveThemeMode(ThemeMode themeMode);
}

import 'package:domain/models/enums/theme_mode.dart';

abstract class SharedPreferencesManager {
  Future<void> saveUserAvatarFilePath(String path);

  Future<String?> getUserAvatarFilePath();

  /// Staging-only: remember credentials so the user does not have to sign in
  /// repeatedly during development.
  Future<void> saveStagingCredentials({
    required String email,
    required String password,
  });

  /// Staging-only: returns null if no credentials were saved.
  Future<Map<String, String>?> getStagingCredentials();

  /// Staging-only: clear saved credentials on explicit sign-out.
  Future<void> clearStagingCredentials();

  Future<void> saveThemeMode(ThemeMode mode);

  Future<ThemeMode> getThemeMode();

  /// Persists the UI language code (`en` or `uk`).
  Future<void> saveLocaleLanguageCode(String languageCode);

  /// Returns the saved UI language code, or null if the user has not chosen one.
  Future<String?> getLocaleLanguageCode();
}

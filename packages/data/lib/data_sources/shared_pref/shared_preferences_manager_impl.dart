import 'package:data/data_sources/shared_pref/shared_preferences_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManagerImpl implements SharedPreferencesManager {
  static const _avatarKey = 'userAvatarFilePath';
  static const _stagingEmailKey = 'stagingEmail';
  static const _stagingPasswordKey = 'stagingPassword';
  static const _themeModeKey = 'themeMode';

  @override
  Future<void> saveUserAvatarFilePath(String path) async {
    final prefs = SharedPreferencesAsync();
    await prefs.setString(_avatarKey, path);
  }

  @override
  Future<String?> getUserAvatarFilePath() async {
    final prefs = SharedPreferencesAsync();
    return prefs.getString(_avatarKey);
  }

  @override
  Future<void> saveStagingCredentials({
    required String email,
    required String password,
  }) async {
    final prefs = SharedPreferencesAsync();
    await prefs.setString(_stagingEmailKey, email);
    await prefs.setString(_stagingPasswordKey, password);
  }

  @override
  Future<Map<String, String>?> getStagingCredentials() async {
    final prefs = SharedPreferencesAsync();
    final email = await prefs.getString(_stagingEmailKey);
    final password = await prefs.getString(_stagingPasswordKey);
    if (email == null || password == null) return null;
    // TODO: Make it more secure by encrypting the password before saving and decrypting it when retrieving.
    return {'email': email, 'password': password};
  }

  @override
  Future<void> clearStagingCredentials() async {
    final prefs = SharedPreferencesAsync();
    await prefs.remove(_stagingEmailKey);
    await prefs.remove(_stagingPasswordKey);
  }

  @override
  Future<void> saveThemeMode(String mode) async {
    final prefs = SharedPreferencesAsync();
    await prefs.setString(_themeModeKey, mode);
  }

  @override
  Future<String?> getThemeMode() async {
    final prefs = SharedPreferencesAsync();
    return prefs.getString(_themeModeKey);
  }
}

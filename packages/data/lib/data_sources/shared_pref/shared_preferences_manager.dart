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

  Future<void> saveThemeMode(String mode);

  Future<String?> getThemeMode();
}

enum UserRole {
  admin('admin'),
  tester('tester'),
  user('user'),
  developer('developer'),
  patron('patron'),
  patronDeveloper('patronDeveloper');

  final String value;

  const UserRole(this.value);

  static UserRole fromString(String? role) {
    return UserRole.values.firstWhere(
      (e) => e.value == role,
      orElse: () => UserRole.user,
    );
  }
}

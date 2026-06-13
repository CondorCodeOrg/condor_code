import 'package:domain/models/enums/user_role.dart';

class User {
  final String id;
  final String email;
  final String? fullName;
  final UserRole role;

  User({
    required this.id,
    required this.email,
    this.fullName,
    required this.role,
  });
}

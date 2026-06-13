import 'package:domain/data_result/data_result.dart';
import 'package:domain/models/user.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;

  Future<DataResult<User>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String username,
    required String confirmPassword,
  });

  Future<DataResult<User>> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<DataResult<User?>> signInWithGoogle();

  Future<String?> getUserRole();

  Future<void> logout();
}

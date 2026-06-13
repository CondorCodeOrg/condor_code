import 'package:data/data_sources/remote/manager/remote_data_manager.dart';
import 'package:data/data_sources/remote/models/user_remote.dart';
import 'package:data/mappers/user_mapper.dart';
import 'package:domain/data_result/data_result.dart';
import 'package:domain/data_result/safe_data_call.dart';
import 'package:domain/models/user.dart';
import 'package:domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(this._remoteDataManager);

  final RemoteDataManager _remoteDataManager;

  @override
  Stream<User?> get authStateChanges =>
      _remoteDataManager.authStateChanges.map((firebaseUser) {
        if (firebaseUser == null) return null;
        return firebaseUser.toDomain();
      });

  bool get isAuthenticated => _remoteDataManager.isUserExist;

  @override
  Future<DataResult<User>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return await safeDataCall<User, UserRemote>(
      dataCall: () => _remoteDataManager.signInWithEmailPassword(
        email: email,
        password: password,
      ),
      processResult: (userRemote) {
        return SuccessResult(userRemote.toDomain());
      },
    );
  }

  @override
  Future<DataResult<User?>> signInWithGoogle() async {
    return await safeDataCall<User?, UserRemote?>(
      dataCall: () => _remoteDataManager.signInWithGoogle(),
      processResult: (userRemote) {
        if (userRemote == null) {
          return SuccessResult(null);
        }
        return SuccessResult(userRemote.toDomain());
      },
    );
  }

  @override
  Future<String?> getUserRole() async {
    final user = _remoteDataManager.currentUser;
    if (user == null) return null;
    return await _remoteDataManager.getUserRole(user.id);
  }

  @override
  Future<void> logout() async {
    await _remoteDataManager.logout();
  }

  @override
  Future<DataResult<User>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String username,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      return ErrorResult(message: 'Passwords do not match');
    }

    return await safeDataCall<User, UserRemote>(
      dataCall: () => _remoteDataManager.signUpWithEmailPassword(
        email: email,
        password: password,
      ),
      processResult: (userRemote) {
        return SuccessResult(userRemote.toDomain());
      },
    );
  }
}

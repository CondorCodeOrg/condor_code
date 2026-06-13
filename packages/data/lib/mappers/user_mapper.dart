import 'package:data/data_sources/remote/models/user_remote.dart';
import 'package:domain/domain.dart';

extension UserRemoteMapper on UserRemote {
  User toDomain() {
    return User(
      id: id,
      email: email,
      fullName: fullName ?? '',
      role: UserRole.fromString(role),
    );
  }
}

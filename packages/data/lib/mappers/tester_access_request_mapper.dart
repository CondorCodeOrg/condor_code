import 'package:data/data_sources/remote/models/tester_access_request_remote.dart';
import 'package:domain/domain.dart';

extension TesterAccessRequestRemoteMapper on TesterAccessRequestRemote {
  TesterAccessRequest toDomain() {
    return TesterAccessRequest(
      id: id,
      userId: userId,
      email: email,
      fullName: fullName,
      status: TesterAccessRequestStatus.fromString(status),
      createdAt: createdAt,
      reviewedAt: reviewedAt,
      reviewedBy: reviewedBy,
    );
  }
}

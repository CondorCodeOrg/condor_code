import 'package:domain/models/enums/tester_access_request_status.dart';

class TesterAccessRequest {
  final String id;
  final String userId;
  final String email;
  final String? fullName;
  final TesterAccessRequestStatus status;
  final DateTime? createdAt;
  final DateTime? reviewedAt;
  final String? reviewedBy;

  const TesterAccessRequest({
    required this.id,
    required this.userId,
    required this.email,
    this.fullName,
    required this.status,
    this.createdAt,
    this.reviewedAt,
    this.reviewedBy,
  });
}

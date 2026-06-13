import 'package:cloud_firestore/cloud_firestore.dart';

class TesterAccessRequestRemote {
  final String id;
  final String userId;
  final String email;
  final String? fullName;
  final String status;
  final DateTime? createdAt;
  final DateTime? reviewedAt;
  final String? reviewedBy;

  const TesterAccessRequestRemote({
    required this.id,
    required this.userId,
    required this.email,
    this.fullName,
    required this.status,
    this.createdAt,
    this.reviewedAt,
    this.reviewedBy,
  });

  factory TesterAccessRequestRemote.fromFirestore(
    Map<String, dynamic> data,
    String docId,
  ) {
    return TesterAccessRequestRemote(
      id: docId,
      userId: _string(data['userId']),
      email: _string(data['email']),
      fullName: data['fullName'] as String?,
      status: _string(data['status'], fallback: 'pending'),
      createdAt: _dateTime(data['createdAt']),
      reviewedAt: _dateTime(data['reviewedAt']),
      reviewedBy: data['reviewedBy'] as String?,
    );
  }

  static String _string(dynamic value, {String fallback = ''}) {
    if (value is String) return value;
    return fallback;
  }

  static DateTime? _dateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }
}

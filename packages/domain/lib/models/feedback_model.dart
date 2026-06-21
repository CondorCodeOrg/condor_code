class FeedbackModel {
  final String id;
  final String message;
  final String? userId;
  final String? email;
  final DateTime timestamp;
  final String platform;
  final String? deviceInfo;

  FeedbackModel({
    required this.id,
    required this.message,
    this.userId,
    this.email,
    required this.timestamp,
    required this.platform,
    this.deviceInfo,
  });

  Map<String, dynamic> toJson() => {
    'message': message,
    'userId': userId,
    'email': email,
    'timestamp': timestamp.toIso8601String(),
    'platform': platform,
    'deviceInfo': deviceInfo,
  };

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
    id: json['id'] ?? '',
    message: json['message'] ?? '',
    userId: json['userId'],
    email: json['email'],
    timestamp: DateTime.parse(json['timestamp']),
    platform: json['platform'] ?? 'unknown',
    deviceInfo: json['deviceInfo'],
  );
}

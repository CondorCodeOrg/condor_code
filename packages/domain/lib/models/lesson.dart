class Lesson {
  final String id;
  final String title;
  final String topic;
  final String description;
  final String youtubeUrl;
  final String courseId;
  final bool isYouTubeLesson;

  /// Display order within the course (0-based, persisted in Firestore).
  final int sortOrder;

  const Lesson({
    required this.id,
    required this.youtubeUrl,
    required this.isYouTubeLesson,
    required this.courseId,
    required this.title,
    required this.topic,
    required this.description,
    this.sortOrder = 0,
  });

  Lesson copyWith({
    String? id,
    String? title,
    String? topic,
    String? description,
    String? youtubeUrl,
    bool? isYouTubeLesson,
    String? courseId,
    int? sortOrder,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      topic: topic ?? this.topic,
      description: description ?? this.description,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      isYouTubeLesson: isYouTubeLesson ?? this.isYouTubeLesson,
      courseId: courseId ?? this.courseId,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}

class LessonItem {
  final String name;
  final String topic;
  final String imageUrl;
  final String id;
  final int sortOrder;

  const LessonItem({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.topic,
    this.sortOrder = 0,
  });
}

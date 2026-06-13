class Course {
  final String id;
  final String name;
  final String imageUrl;
  final int lessonsAmount;

  Course({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.lessonsAmount,
  });

  Course copyWith({
    String? id,
    String? name,
    String? imageUrl,
    int? lessonsAmount,
  }) {
    return Course(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      lessonsAmount: lessonsAmount ?? this.lessonsAmount,
    );
  }
}

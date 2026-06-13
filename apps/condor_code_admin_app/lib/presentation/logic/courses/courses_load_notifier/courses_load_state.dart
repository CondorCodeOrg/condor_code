import 'package:domain/models/course.dart';

class CoursesLoadState {
  final bool isLoading;
  final List<Course> courses;
  final String? errorMessage;

  const CoursesLoadState({
    this.isLoading = false,
    this.courses = const [],
    this.errorMessage,
  });

  CoursesLoadState copyWith({
    bool? isLoading,
    List<Course>? courses,
    String? errorMessage,
  }) {
    return CoursesLoadState(
      isLoading: isLoading ?? this.isLoading,
      courses: courses ?? this.courses,
      errorMessage: errorMessage,
    );
  }

  bool get hasError => errorMessage?.isNotEmpty == true;
}

import 'package:condorcode_admin/generated/l10n/l10n.dart';
import 'package:condorcode_admin/presentation/logic/courses/course_create_notifier/course_create_state.dart';
import 'package:condorcode_admin/presentation/logic/providers.dart';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final courseCreateProvider =
    StateNotifierProvider.autoDispose<CourseCreateNotifier, CourseCreateState>(
      (ref) => CourseCreateNotifier(
        ref: ref,
        coursesRepository: ref.watch(coursesRepositoryProvider),
      ),
    );

class CourseCreateNotifier extends StateNotifier<CourseCreateState> {
  CourseCreateNotifier({required this.ref, required this.coursesRepository})
    : super(const CourseCreateState());

  final Ref ref;
  final CoursesRepository coursesRepository;

  void reset() {
    state = const CourseCreateState();
  }

  void updateName(String value) {
    state = state.copyWith(
      name: value,
      nameError: false,
      nameErrorMessage: null,
      commonErrorMessage: null,
      successMessage: value.trim().isEmpty ? state.successMessage : null,
    );
  }

  void updateImageUrl(String value) {
    state = state.copyWith(imageUrl: value, commonErrorMessage: null);
  }

  /// Returns the saved course (with Firestore id) on success.
  Future<Course?> saveCourse() async {
    if (!_validate()) return null;

    state = state.copyWith(
      isProcessing: true,
      commonErrorMessage: null,
      successMessage: null,
    );

    final trimmedName = state.name.trim();
    final trimmedImage = state.imageUrl.trim();

    final course = Course(
      id: '',
      name: trimmedName,
      imageUrl: trimmedImage,
      lessonsAmount: 0,
    );

    final result = await coursesRepository.uploadFullCourseBundle(
      course: course,
      lessons: const [],
      tasks: const [],
      questions: const [],
    );

    Course? saved;
    result.fold(
      onSuccess: (created) {
        saved = created;
        state = state.copyWith(successMessage: S.current.courseCreated);
      },
      onError: (error) {
        state = state.copyWith(commonErrorMessage: error.message);
      },
    );

    if (mounted) {
      state = state.copyWith(isProcessing: false);
    }
    return saved;
  }

  bool _validate() {
    final nameError = _validateRequired(
      state.name,
      S.current.courseNameRequired,
    );

    state = state.copyWith(
      nameErrorMessage: nameError,
      nameError: nameError != null,
      commonErrorMessage: null,
    );

    return nameError == null;
  }

  String? _validateRequired(String value, String message) {
    if (value.trim().isEmpty) return message;
    return null;
  }
}

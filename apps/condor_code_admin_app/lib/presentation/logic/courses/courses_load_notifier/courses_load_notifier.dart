import 'package:condorcode_admin/presentation/logic/courses/courses_load_notifier/courses_load_state.dart';
import 'package:condorcode_admin/presentation/logic/providers.dart';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final coursesLoadProvider =
    StateNotifierProvider.autoDispose<CoursesLoadNotifier, CoursesLoadState>(
      (ref) => CoursesLoadNotifier(
        ref: ref,
        coursesRepository: ref.watch(coursesRepositoryProvider),
      ),
    );

class CoursesLoadNotifier extends StateNotifier<CoursesLoadState> {
  CoursesLoadNotifier({required this.ref, required this.coursesRepository})
    : super(const CoursesLoadState());

  final Ref ref;
  final CoursesRepository coursesRepository;

  /// Loads every course from remote storage (single Firestore query / list).
  Future<void> loadCourses() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await coursesRepository.fetchAllCourses();

    result.fold(
      onSuccess: (courses) {
        final sorted = [
          ...courses,
        ]..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        state = state.copyWith(isLoading: false, courses: sorted);
      },
      onError: (error) {
        state = state.copyWith(isLoading: false, errorMessage: error.message);
      },
    );
  }
}

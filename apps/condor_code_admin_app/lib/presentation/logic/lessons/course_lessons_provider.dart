import 'package:condorcode_admin/presentation/logic/providers.dart';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final courseLessonsProvider = FutureProvider.family<List<Lesson>, String>((
  ref,
  courseId,
) async {
  if (courseId.isEmpty) return [];

  final repo = ref.watch(lessonsRepositoryProvider);
  final result = await repo.fetchLessonsForCourse(courseId);

  if (result is ErrorResult<List<Lesson>>) {
    throw Exception(result.message);
  }

  final lessons = (result as SuccessResult<List<Lesson>>).data ?? [];
  return lessons;
});

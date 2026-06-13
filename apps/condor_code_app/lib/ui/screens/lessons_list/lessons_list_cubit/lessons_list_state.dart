import 'package:domain/domain.dart';

sealed class LessonsListState {
  const LessonsListState();
}

final class LessonsListLoading extends LessonsListState {
  const LessonsListLoading();
}

final class LessonsListLoaded extends LessonsListState {
  final List<LessonItem> lessons;

  const LessonsListLoaded(this.lessons);
}

import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_editor_state.freezed.dart';

@freezed
sealed class LessonEditorState with _$LessonEditorState {
  const factory LessonEditorState({
    Lesson? lesson,
    @Default(<Task>[]) List<Task> tasks,
    @Default(<Question>[]) List<Question> questions,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    String? errorMessage,
  }) = _LessonEditorState;

  const LessonEditorState._();

  bool get isEditMode => lesson != null && lesson!.id.isNotEmpty;

  bool get isCreateMode => lesson != null && lesson!.id.isEmpty;
}

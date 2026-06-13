import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_upload_state.freezed.dart';

@freezed
sealed class LessonUploadState with _$LessonUploadState {
  const factory LessonUploadState({
    @Default(false) bool isProcessing,
    @Default('') String title,
    @Default('') String topic,
    @Default('') String youtubeUrl,
    @Default('') String description,
    @Default('') String courseId,
    String? id,
    @Default(true) bool isYouTubeLesson,
    @Default(false) bool titleError,
    @Default(false) bool topicError,
    @Default(false) bool youtubeUrlError,
    @Default(false) bool descriptionError,
    String? titleErrorMessage,
    String? topicErrorMessage,
    String? youtubeUrlErrorMessage,
    String? descriptionErrorMessage,
    String? commonErrorMessage,
    String? successMessage,
  }) = _LessonUploadState;

  const LessonUploadState._();

  bool get hasErrorMessage => commonErrorMessage?.isNotEmpty == true;

  bool get canSave =>
      !isProcessing &&
      title.isNotEmpty &&
      topic.isNotEmpty &&
      description.isNotEmpty &&
      (!isYouTubeLesson ? true : youtubeUrl.isNotEmpty);
}

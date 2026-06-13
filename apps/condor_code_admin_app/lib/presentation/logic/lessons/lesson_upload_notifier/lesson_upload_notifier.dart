import 'package:condorcode_admin/generated/l10n/l10n.dart';
import 'package:condorcode_admin/presentation/logic/lessons/lesson_upload_notifier/lesson_upload_state.dart';
import 'package:condorcode_admin/presentation/logic/providers.dart';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final lessonUploadProvider =
    StateNotifierProvider.autoDispose<LessonUploadNotifier, LessonUploadState>(
      (ref) => LessonUploadNotifier(
        ref: ref,
        lessonsRepository: ref.watch(lessonsRepositoryProvider),
      ),
    );

class LessonUploadNotifier extends StateNotifier<LessonUploadState> {
  LessonUploadNotifier({required this.ref, required this.lessonsRepository})
    : super(const LessonUploadState());

  final Ref ref;
  final LessonsRepository lessonsRepository;

  void updateTitle(String title) {
    state = state.copyWith(
      title: title,
      titleError: false,
      titleErrorMessage: null,
      commonErrorMessage: null,
      successMessage: title.trim().isEmpty ? state.successMessage : null,
    );
  }

  void updateTopic(String topic) {
    state = state.copyWith(
      topic: topic,
      topicError: false,
      topicErrorMessage: null,
      commonErrorMessage: null,
      successMessage: topic.trim().isEmpty ? state.successMessage : null,
    );
  }

  void updateYoutubeUrl(String url) {
    state = state.copyWith(
      youtubeUrl: url,
      youtubeUrlError: false,
      youtubeUrlErrorMessage: null,
      commonErrorMessage: null,
      successMessage: url.trim().isEmpty ? state.successMessage : null,
    );
  }

  void updateDescription(String description) {
    state = state.copyWith(
      description: description,
      descriptionError: false,
      descriptionErrorMessage: null,
      commonErrorMessage: null,
      successMessage: description.trim().isEmpty ? state.successMessage : null,
    );
  }

  void updateCourseId(String courseId) {
    state = state.copyWith(courseId: courseId);
  }

  void updateIsYouTubeLesson(bool isYouTubeLesson) {
    state = state.copyWith(
      isYouTubeLesson: isYouTubeLesson,
      youtubeUrlError: false,
      youtubeUrlErrorMessage: null,
      descriptionError: false,
      descriptionErrorMessage: null,
      commonErrorMessage: null,
      successMessage: null,
    );
  }

  Future<Lesson?> saveLesson({required String courseId}) async {
    final normalizedCourseId = courseId.trim();
    state = state.copyWith(courseId: normalizedCourseId);

    if (!_validate(courseId: normalizedCourseId)) {
      return null;
    }

    state = state.copyWith(
      isProcessing: true,
      commonErrorMessage: null,
      successMessage: null,
    );

    final t = state.title.trim();
    final tp = state.topic.trim();
    final d = state.description.trim();
    final lesson = Lesson(
      id: state.id ?? '',
      title: t,
      topic: tp,
      youtubeUrl: state.isYouTubeLesson ? state.youtubeUrl.trim() : '',
      description: d,
      isYouTubeLesson: state.isYouTubeLesson,
      courseId: normalizedCourseId,
    );

    final result = await lessonsRepository.saveLesson(lesson);

    Lesson? uploadedLesson;

    result.fold(
      onSuccess: (savedLesson) {
        uploadedLesson = savedLesson;
        state = state.copyWith(
          id: savedLesson.id,
          successMessage: S.current.lessonUploaded,
        );
      },
      onError: (error) {
        state = state.copyWith(commonErrorMessage: error.message);
      },
    );

    if (mounted) {
      state = state.copyWith(isProcessing: false);
    }

    return uploadedLesson;
  }

  bool _validate({required String courseId}) {
    final courseError = _validateRequired(
      courseId,
      S.current.lessonCourseRequired,
    );
    final titleError = _validateRequired(
      state.title,
      S.current.lessonTitleRequired,
    );
    final topicError = _validateRequired(
      state.topic,
      S.current.lessonTopicRequired,
    );
    final descriptionError = _validateRequired(
      state.description,
      S.current.lessonDescriptionRequired,
    );
    final youtubeError = state.isYouTubeLesson
        ? _validateRequired(
            state.youtubeUrl,
            S.current.lessonYoutubeUrlRequired,
          )
        : null;

    state = state.copyWith(
      titleErrorMessage: titleError,
      titleError: titleError != null,
      topicErrorMessage: topicError,
      topicError: topicError != null,
      descriptionErrorMessage: descriptionError,
      descriptionError: descriptionError != null,
      youtubeUrlErrorMessage: youtubeError,
      youtubeUrlError: youtubeError != null,
      commonErrorMessage: courseError,
    );

    return courseError == null &&
        titleError == null &&
        topicError == null &&
        descriptionError == null &&
        youtubeError == null;
  }

  String? _validateRequired(String value, String message) {
    if (value.trim().isEmpty) {
      return message;
    }
    return null;
  }
}

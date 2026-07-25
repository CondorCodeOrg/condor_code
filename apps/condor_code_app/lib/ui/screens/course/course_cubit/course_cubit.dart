import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/analytics_constants.dart';
import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/screens/course/course_cubit/course_state.dart';
import 'package:domain/domain.dart';

class CourseCubit extends BaseCubit<CourseState> {
  CourseCubit({
    required String courseId,
    required LessonsRepository lessonsRepository,
    required TasksRepository tasksRepository,
    required super.snackBarEventsProvider,
    this.initialLessonId,
  }) : _courseId = courseId,
       _lessonsRepository = lessonsRepository,
       _tasksRepository = tasksRepository,
       super(const CourseState()) {
    _loadLessons();
  }

  final LessonsRepository _lessonsRepository;
  final TasksRepository _tasksRepository;
  final String _courseId;
  final String? initialLessonId;
  final Map<String, (Lesson, bool)> _courseCache = {};
  String? _activeLessonRequestId;

  Future<void> _loadLessons() async {
    emit(state.copyWith(isLessonsLoading: true));
    await processDataResult(
      _lessonsRepository.getLessonsItems(_courseId),
      onSuccess: (lessons) async {
        emit(state.copyWith(lessons: lessons, isLessonsLoading: false));
        if (lessons.isNotEmpty) {
          final targetId = _resolveInitialLesson(lessons);
          await selectLesson(targetId);
        }
      },
      onError: (error) {
        emit(state.copyWith(isLessonsLoading: false));
        showErrorSnackBar(error.message);
      },
    );
  }

  String _resolveInitialLesson(List<LessonItem> lessons) {
    if (initialLessonId != null) {
      final match = lessons.where((l) => l.id == initialLessonId);
      if (match.isNotEmpty) return match.first.id;
    }
    return lessons.first.id;
  }

  Future<void> selectLesson(String lessonId) async {
    _activeLessonRequestId = lessonId;
    if (_courseCache.containsKey(lessonId)) {
      final (cachedLesson, cachedTasksExist) = _courseCache[lessonId]!;
      _logSelectLessonAnalytics(cachedLesson, lessonId);

      emit(
        state.copyWith(
          selectedLesson: cachedLesson,
          isTasksExist: cachedTasksExist,
          isLessonDetailsLoading: false,
        ),
      );
      _refreshLessonInBackground(lessonId);
      return;
    }

    emit(state.copyWith(isLessonDetailsLoading: true));
    await processDataResult(
      _lessonsRepository.getLesson(lessonId),
      onSuccess: (lesson) async {
        await processDataResult(
          _tasksRepository.getTasks(lesson.id),
          onSuccess: (tasks) {
            _logSelectLessonAnalytics(lesson, lessonId);
            _courseCache[lessonId] = (lesson, tasks.isNotEmpty);

            if (_activeLessonRequestId != lessonId) return;

            emit(
              state.copyWith(
                selectedLesson: lesson,
                isLessonDetailsLoading: false,
                isTasksExist: tasks.isNotEmpty,
              ),
            );
          },
          onError: (error) {
            emit(state.copyWith(isLessonDetailsLoading: false));
            showErrorSnackBar(error.message);
          },
        );
      },
      onError: (error) {
        emit(state.copyWith(isLessonDetailsLoading: false));
        showErrorSnackBar(error.message);
      },
    );
  }

  Future<void> _refreshLessonInBackground(String lessonId) async {
    await processDataResult(
      _lessonsRepository.getLesson(lessonId),
      onSuccess: (lesson) async {
        await processDataResult(
          _tasksRepository.getTasks(lesson.id),
          onSuccess: (tasks) {
            _courseCache[lessonId] = (lesson, tasks.isNotEmpty);
            if (state.selectedLesson?.id == lessonId) {
              emit(
                state.copyWith(
                  selectedLesson: lesson,
                  isTasksExist: tasks.isNotEmpty,
                ),
              );
            }
          },
          onError: (error) {
            if (kDebugMode) {
              log(
                'Background tasks refresh failed: ${error.message}',
                name: 'CourseCubit',
              );
            }
          },
        );
      },
    );
  }

  void _logSelectLessonAnalytics(Lesson lesson, String lessonId) {
    di<Analytics>().logEvent(AnalyticsEventName.selectLesson, {
      AnalyticsPropertyName.courseId: _courseId,
      AnalyticsPropertyName.lessonId: lessonId,
      AnalyticsPropertyName.lessonTitle: lesson.title,
    });
  }
}

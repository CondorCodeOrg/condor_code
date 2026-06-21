import 'package:condorcode_admin/presentation/logic/providers.dart';
import 'package:condorcode_admin/utilities/context_extensions.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

class _CourseMismatch implements Exception {}

typedef _LessonDetailBundle = ({
  Lesson lesson,
  List<Task> tasks,
  List<Question> questions,
});

final _lessonDetailBundleProvider = FutureProvider.autoDispose
    .family<_LessonDetailBundle, String>((ref, combined) async {
      final sep = combined.indexOf('|');
      final courseId = combined.substring(0, sep);
      final lessonId = combined.substring(sep + 1);
      final repo = ref.read(lessonsRepositoryProvider);

      final lessonResult = await repo.getLesson(lessonId);
      Lesson? lesson;
      String? lessonErr;
      lessonResult.fold(
        onSuccess: (l) => lesson = l,
        onError: (e) => lessonErr = e.message,
      );
      if (lessonErr != null) throw Exception(lessonErr);
      final les = lesson;
      if (les == null) throw Exception('empty');
      if (les.courseId != courseId) throw _CourseMismatch();

      final tasksResult = await repo.fetchTasksForLesson(lessonId);
      final questionsResult = await repo.fetchQuestionsForLesson(lessonId);

      List<Task> tasks = [];
      tasksResult.fold(
        onSuccess: (list) => tasks = list,
        onError: (e) => throw Exception(e.message),
      );

      List<Question> questions = [];
      questionsResult.fold(
        onSuccess: (list) => questions = list,
        onError: (e) => throw Exception(e.message),
      );

      return (lesson: les, tasks: tasks, questions: questions);
    });

class LessonDetailPage extends ConsumerWidget {
  const LessonDetailPage({
    super.key,
    required this.courseId,
    required this.lessonId,
  });

  final String courseId;
  final String lessonId;

  static BoxDecoration _cardDecoration(BuildContext context) => BoxDecoration(
    color: context.colors.popupSurface,
    borderRadius: const BorderRadius.all(Radius.circular(16)),
    border: Border.all(color: context.colors.border),
    boxShadow: const [
      BoxShadow(color: Color(0x0D000000), blurRadius: 12, offset: Offset(0, 4)),
    ],
  );

  static TextStyle _valueStyle(BuildContext context) => TextStyle(
    fontSize: 15,
    height: 1.45,
    color: context.colors.textPrimary,
    decoration: TextDecoration.none,
  );

  static TextStyle _labelStyle(BuildContext context) => TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13,
    color: context.colors.textSecondary,
    decoration: TextDecoration.none,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = '$courseId|$lessonId';
    final async = ref.watch(_lessonDetailBundleProvider(key));

    return Scaffold(
      backgroundColor: context.colors.scaffoldBackground,
      body: SafeArea(
        child: Material(
          color: context.colors.scaffoldBackground,
          child: DefaultTextStyle.merge(
            style: _valueStyle(context),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1024),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => context.pop(),
                            icon: Icon(
                              Icons.arrow_back,
                              color: context.colors.textPrimary,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              context.strings.lessonDetailsTitle,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: context.colors.textPrimary,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      async.when(
                        skipLoadingOnReload: true,
                        data: (bundle) => _LessonDetailContent(
                          bundle: bundle,
                          cardDecoration: _cardDecoration(context),
                          labelStyle: _labelStyle(context),
                          valueStyle: _valueStyle(context),
                        ),
                        loading: () => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 48),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        error: (e, _) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            e is _CourseMismatch
                                ? context.strings.lessonDetailCourseMismatch
                                : context.strings.lessonDetailLoadError,
                            style: TextStyle(
                              color: context.colors.alert,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LessonDetailContent extends StatelessWidget {
  const _LessonDetailContent({
    required this.bundle,
    required this.cardDecoration,
    required this.labelStyle,
    required this.valueStyle,
  });

  final _LessonDetailBundle bundle;
  final BoxDecoration cardDecoration;
  final TextStyle labelStyle;
  final TextStyle valueStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: cardDecoration,
          child: _LessonMeta(
            lesson: bundle.lesson,
            labelStyle: labelStyle,
            valueStyle: valueStyle,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: cardDecoration,
          child: _TasksSection(
            tasks: bundle.tasks,
            labelStyle: labelStyle,
            valueStyle: valueStyle,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: cardDecoration,
          child: _QuestionsSection(
            questions: bundle.questions,
            labelStyle: labelStyle,
            valueStyle: valueStyle,
          ),
        ),
      ],
    );
  }
}

class _LessonMeta extends StatelessWidget {
  const _LessonMeta({
    required this.lesson,
    required this.labelStyle,
    required this.valueStyle,
  });

  final Lesson lesson;
  final TextStyle labelStyle;
  final TextStyle valueStyle;

  @override
  Widget build(BuildContext context) {
    final topic = lesson.topic.trim();
    final url = lesson.youtubeUrl.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _DetailRow(
          label: context.strings.lessonTitleLabel,
          labelStyle: labelStyle,
          valueStyle: valueStyle,
          text: lesson.title.isEmpty ? '—' : lesson.title,
        ),
        if (topic.isNotEmpty) ...[
          const SizedBox(height: 16),
          _DetailRow(
            label: context.strings.lessonTopicLabel,
            labelStyle: labelStyle,
            valueStyle: valueStyle,
            text: topic,
          ),
        ],
        const SizedBox(height: 16),
        _DetailRow(
          label: context.strings.lessonDescriptionLabel,
          labelStyle: labelStyle,
          valueStyle: valueStyle,
          text: lesson.description.trim().isEmpty ? '—' : lesson.description,
        ),
        const SizedBox(height: 16),
        _DetailRow(
          label: context.strings.youtubeLessonLabel,
          labelStyle: labelStyle,
          valueStyle: valueStyle,
          text: lesson.isYouTubeLesson ? (url.isEmpty ? '—' : url) : '—',
        ),
      ],
    );
  }
}

class _TasksSection extends StatelessWidget {
  const _TasksSection({
    required this.tasks,
    required this.labelStyle,
    required this.valueStyle,
  });

  final List<Task> tasks;
  final TextStyle labelStyle;
  final TextStyle valueStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.strings.taskSectionTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: context.colors.textPrimary,
            decoration: TextDecoration.none,
          ),
        ),
        const SizedBox(height: 16),
        if (tasks.isEmpty)
          Text(
            context.strings.lessonDetailNoTasks,
            style: TextStyle(color: context.colors.textSecondary, fontSize: 14),
          )
        else
          ...List.generate(tasks.length, (i) {
            return Padding(
              padding: EdgeInsets.only(top: i == 0 ? 0 : 12),
              child: _TaskCard(
                task: tasks[i],
                index: i,
                labelStyle: labelStyle,
                valueStyle: valueStyle,
              ),
            );
          }),
      ],
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.task,
    required this.index,
    required this.labelStyle,
    required this.valueStyle,
  });

  final Task task;
  final int index;
  final TextStyle labelStyle;
  final TextStyle valueStyle;

  @override
  Widget build(BuildContext context) {
    final a = task.answer;

    return Material(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${context.strings.taskSectionTitle} ${index + 1}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: context.colors.textPrimary,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 10),
            _DetailRow(
              label: context.strings.taskTitleLabel,
              labelStyle: labelStyle,
              valueStyle: valueStyle,
              text: task.title.isEmpty ? '—' : task.title,
            ),
            const SizedBox(height: 10),
            _DetailRow(
              label: context.strings.taskDescriptionLabel,
              labelStyle: labelStyle,
              valueStyle: valueStyle,
              text: task.description.trim().isEmpty ? '—' : task.description,
            ),
            if (task.mediaUrl.trim().isNotEmpty) ...[
              const SizedBox(height: 10),
              _DetailRow(
                label: context.strings.taskMediaUrlLabel,
                labelStyle: labelStyle,
                valueStyle: valueStyle,
                text: task.mediaUrl,
              ),
            ],
            const SizedBox(height: 12),
            Text(
              context.strings.answerBlockTitle,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: context.colors.textPrimary,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 8),
            _DetailRow(
              label: context.strings.answerTitleLabel,
              labelStyle: labelStyle,
              valueStyle: valueStyle,
              text: a.title.isEmpty ? '—' : a.title,
            ),
            const SizedBox(height: 8),
            _DetailRow(
              label: context.strings.answerDescriptionLabel,
              labelStyle: labelStyle,
              valueStyle: valueStyle,
              text: a.description.trim().isEmpty ? '—' : a.description,
            ),
            if (a.mediaUrl.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              _DetailRow(
                label: context.strings.answerMediaUrlLabel,
                labelStyle: labelStyle,
                valueStyle: valueStyle,
                text: a.mediaUrl,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _QuestionsSection extends StatelessWidget {
  const _QuestionsSection({
    required this.questions,
    required this.labelStyle,
    required this.valueStyle,
  });

  final List<Question> questions;
  final TextStyle labelStyle;
  final TextStyle valueStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.strings.questionSectionTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: context.colors.textPrimary,
            decoration: TextDecoration.none,
          ),
        ),
        const SizedBox(height: 16),
        if (questions.isEmpty)
          Text(
            context.strings.lessonDetailNoQuestions,
            style: TextStyle(color: context.colors.textSecondary, fontSize: 14),
          )
        else
          ...List.generate(questions.length, (i) {
            return Padding(
              padding: EdgeInsets.only(top: i == 0 ? 0 : 12),
              child: _QuestionCard(
                question: questions[i],
                index: i,
                labelStyle: labelStyle,
                valueStyle: valueStyle,
              ),
            );
          }),
      ],
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.question,
    required this.index,
    required this.labelStyle,
    required this.valueStyle,
  });

  final Question question;
  final int index;
  final TextStyle labelStyle;
  final TextStyle valueStyle;

  @override
  Widget build(BuildContext context) {
    final img = question.imageUrl?.trim() ?? '';

    return Material(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${context.strings.questionSectionTitle} ${index + 1}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: context.colors.textPrimary,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 10),
            _DetailRow(
              label: context.strings.questionTitleLabel,
              labelStyle: labelStyle,
              valueStyle: valueStyle,
              text: question.title.isEmpty ? '—' : question.title,
            ),
            const SizedBox(height: 10),
            _DetailRow(
              label: context.strings.questionDescriptionLabel,
              labelStyle: labelStyle,
              valueStyle: valueStyle,
              text: question.description.trim().isEmpty
                  ? '—'
                  : question.description,
            ),
            if (img.isNotEmpty) ...[
              const SizedBox(height: 10),
              _DetailRow(
                label: context.strings.questionImageUrlLabel,
                labelStyle: labelStyle,
                valueStyle: valueStyle,
                text: img,
              ),
            ],
            const SizedBox(height: 10),
            _DetailRow(
              label: context.strings.answerVariant1,
              labelStyle: labelStyle,
              valueStyle: valueStyle,
              text: question.firstAnswer.isEmpty ? '—' : question.firstAnswer,
            ),
            const SizedBox(height: 8),
            _DetailRow(
              label: context.strings.answerVariant2,
              labelStyle: labelStyle,
              valueStyle: valueStyle,
              text: question.secondAnswer.isEmpty ? '—' : question.secondAnswer,
            ),
            const SizedBox(height: 8),
            _DetailRow(
              label: context.strings.answerVariant3,
              labelStyle: labelStyle,
              valueStyle: valueStyle,
              text: question.thirdAnswer.isEmpty ? '—' : question.thirdAnswer,
            ),
            const SizedBox(height: 10),
            Text(
              '${context.strings.correctAnswerLabel}: ${question.rightAnswerNumber}',
              style: valueStyle.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.text,
    required this.labelStyle,
    required this.valueStyle,
  });

  final String label;
  final String text;
  final TextStyle labelStyle;
  final TextStyle valueStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 6),
        Text(text, style: valueStyle),
      ],
    );
  }
}

import 'package:condorcode_admin/presentation/logic/lessons/lesson_editor_notifier/lesson_editor_notifier.dart';
import 'package:condorcode_admin/presentation/view/common/widgets/text_field.dart';
import 'package:condorcode_admin/presentation/view/pages/home/widgets/section_card.dart';
import 'package:condorcode_admin/utilities/context_extensions.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_kit/ui_kit.dart';

class LessonEditorView extends ConsumerStatefulWidget {
  const LessonEditorView({
    required this.course,
    required this.onBack,
    super.key,
  });

  final Course course;
  final VoidCallback onBack;

  @override
  ConsumerState<LessonEditorView> createState() => _LessonEditorViewState();
}

class _LessonEditorViewState extends ConsumerState<LessonEditorView> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _topicCtrl;
  late final TextEditingController _descriptionCtrl;
  late final TextEditingController _youtubeCtrl;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController();
    _topicCtrl = TextEditingController();
    _descriptionCtrl = TextEditingController();
    _youtubeCtrl = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _syncLessonControllers(ref.read(lessonEditorProvider).lesson);
    });
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _topicCtrl.dispose();
    _descriptionCtrl.dispose();
    _youtubeCtrl.dispose();
    super.dispose();
  }

  void _syncLessonControllers(Lesson? lesson) {
    if (lesson == null || !mounted) return;
    _titleCtrl.text = lesson.title;
    _topicCtrl.text = lesson.topic;
    _descriptionCtrl.text = lesson.description;
    _youtubeCtrl.text = lesson.youtubeUrl;
  }

  void _updateLesson(Lesson Function(Lesson base) build) {
    final base = ref.read(lessonEditorProvider).lesson;
    if (base == null) return;
    ref.read(lessonEditorProvider.notifier).updateLesson(build(base));
  }

  Future<void> _save() async {
    await ref.read(lessonEditorProvider.notifier).save();
    if (!mounted) return;
    final err = ref.read(lessonEditorProvider).errorMessage;
    if (err == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.strings.lessonBundleSaved)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final editorState = ref.watch(lessonEditorProvider);
    final notifier = ref.read(lessonEditorProvider.notifier);
    final screenTitle = editorState.isEditMode
        ? 'Edit Lesson'
        : context.strings.createLesson;

    final lesson = editorState.lesson;
    if (lesson == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: widget.onBack,
              icon: const Icon(Icons.arrow_back),
            ),
            Expanded(
              child: Text(
                '$screenTitle • ${widget.course.name}',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: context.colors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          context.strings.createLessonHint,
          style: TextStyle(color: context.colors.textSecondary),
        ),
        const SizedBox(height: 16),
        if (editorState.errorMessage != null) ...[
          Material(
            color: context.colors.alert.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: context.colors.alert),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      editorState.errorMessage!,
                      style: TextStyle(color: context.colors.alert),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        SectionCard(
          title: context.strings.lessonDetailsTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: _titleCtrl,
                label: context.strings.lessonTitleLabel,
                icon: Icons.title,
                onChanged: (v) => _updateLesson((b) => b.copyWith(title: v)),
              ),
              CustomTextField(
                controller: _topicCtrl,
                label: context.strings.lessonTopicLabel,
                icon: Icons.category,
                onChanged: (v) => _updateLesson((b) => b.copyWith(topic: v)),
              ),
              CustomTextField(
                controller: _descriptionCtrl,
                label: context.strings.lessonDescriptionLabel,
                icon: Icons.notes,
                maxLines: 4,
                minLines: 3,
                onChanged: (v) =>
                    _updateLesson((b) => b.copyWith(description: v)),
              ),
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: Text(context.strings.youtubeLessonLabel),
                value: lesson.isYouTubeLesson,
                thumbColor: WidgetStateProperty.all(context.colors.accent),
                onChanged: (value) {
                  _updateLesson((b) => b.copyWith(isYouTubeLesson: value));
                },
              ),
              if (lesson.isYouTubeLesson)
                CustomTextField(
                  controller: _youtubeCtrl,
                  label: context.strings.youtubeUrlLabel,
                  icon: Icons.link,
                  onChanged: (v) =>
                      _updateLesson((b) => b.copyWith(youtubeUrl: v)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SectionCard(
          title: context.strings.taskSectionTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < editorState.tasks.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _TaskEditorCard(
                    key: ValueKey('lesson_editor_task_$i'),
                    task: editorState.tasks[i],
                    index: i,
                    onChanged: (t) => notifier.updateTask(i, t),
                    onRemove: () => notifier.removeTask(i),
                  ),
                ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: notifier.addTask,
                  icon: const Icon(Icons.add_task_outlined),
                  label: Text(context.strings.addTask),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SectionCard(
          title: context.strings.questionSectionTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < editorState.questions.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _QuestionEditorCard(
                    key: ValueKey('lesson_editor_question_$i'),
                    question: editorState.questions[i],
                    index: i,
                    onChanged: (q) => notifier.updateQuestion(i, q),
                    onRemove: () => notifier.removeQuestion(i),
                  ),
                ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: notifier.addQuestion,
                  icon: const Icon(Icons.quiz_outlined),
                  label: Text(context.strings.addQuestion),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: editorState.isSaving ? null : _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colors.accent,
            foregroundColor: context.colors.accentForeground,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: editorState.isSaving
              ? SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: context.colors.accentForeground,
                  ),
                )
              : Text(
                  context.strings.saveLessonBundle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _TaskEditorCard extends StatefulWidget {
  const _TaskEditorCard({
    super.key,
    required this.task,
    required this.index,
    required this.onChanged,
    required this.onRemove,
  });

  final Task task;
  final int index;
  final ValueChanged<Task> onChanged;
  final VoidCallback onRemove;

  @override
  State<_TaskEditorCard> createState() => _TaskEditorCardState();
}

class _TaskEditorCardState extends State<_TaskEditorCard> {
  late TextEditingController _title;
  late TextEditingController _desc;
  late TextEditingController _media;
  late TextEditingController _ansTitle;
  late TextEditingController _ansDesc;
  late TextEditingController _ansMedia;

  @override
  void initState() {
    super.initState();
    _attachTask(widget.task);
  }

  @override
  void didUpdateWidget(covariant _TaskEditorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index ||
        oldWidget.task.id != widget.task.id) {
      _disposeControllers();
      _attachTask(widget.task);
    }
  }

  void _attachTask(Task t) {
    _title = TextEditingController(text: t.title);
    _desc = TextEditingController(text: t.description);
    _media = TextEditingController(text: t.mediaUrl);
    _ansTitle = TextEditingController(text: t.answer.title);
    _ansDesc = TextEditingController(text: t.answer.description);
    _ansMedia = TextEditingController(text: t.answer.mediaUrl);
  }

  void _disposeControllers() {
    _title.dispose();
    _desc.dispose();
    _media.dispose();
    _ansTitle.dispose();
    _ansDesc.dispose();
    _ansMedia.dispose();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  Task _buildTask() {
    return widget.task.copyWith(
      title: _title.text,
      description: _desc.text,
      mediaUrl: _media.text,
      answer: Answer(
        title: _ansTitle.text,
        description: _ansDesc.text,
        mediaUrl: _ansMedia.text,
        listImages: widget.task.answer.listImages,
      ),
    );
  }

  void _notify() => widget.onChanged(_buildTask());

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  '${context.strings.taskSectionTitle} ${widget.index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: widget.onRemove,
                  child: Text(context.strings.removeItem),
                ),
              ],
            ),
            CustomTextField(
              controller: _title,
              label: context.strings.taskTitleLabel,
              icon: Icons.short_text,
              onChanged: (_) => _notify(),
            ),
            CustomTextField(
              controller: _desc,
              label: context.strings.taskDescriptionLabel,
              icon: Icons.description_outlined,
              maxLines: 3,
              minLines: 2,
              onChanged: (_) => _notify(),
            ),
            CustomTextField(
              controller: _media,
              label: context.strings.taskMediaUrlLabel,
              icon: Icons.perm_media_outlined,
              onChanged: (_) => _notify(),
            ),
            const SizedBox(height: 8),
            Text(
              context.strings.answerBlockTitle,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _ansTitle,
              label: context.strings.answerTitleLabel,
              icon: Icons.check_circle_outline,
              onChanged: (_) => _notify(),
            ),
            CustomTextField(
              controller: _ansDesc,
              label: context.strings.answerDescriptionLabel,
              icon: Icons.notes,
              maxLines: 3,
              minLines: 2,
              onChanged: (_) => _notify(),
            ),
            CustomTextField(
              controller: _ansMedia,
              label: context.strings.answerMediaUrlLabel,
              icon: Icons.link,
              onChanged: (_) => _notify(),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestionEditorCard extends StatefulWidget {
  const _QuestionEditorCard({
    super.key,
    required this.question,
    required this.index,
    required this.onChanged,
    required this.onRemove,
  });

  final Question question;
  final int index;
  final ValueChanged<Question> onChanged;
  final VoidCallback onRemove;

  @override
  State<_QuestionEditorCard> createState() => _QuestionEditorCardState();
}

class _QuestionEditorCardState extends State<_QuestionEditorCard> {
  late TextEditingController _title;
  late TextEditingController _desc;
  late TextEditingController _imageUrl;
  late TextEditingController _a1;
  late TextEditingController _a2;
  late TextEditingController _a3;
  late int _correct;

  @override
  void initState() {
    super.initState();
    _attachQuestion(widget.question);
  }

  @override
  void didUpdateWidget(covariant _QuestionEditorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index ||
        oldWidget.question.id != widget.question.id) {
      _disposeQuestionControllers();
      _attachQuestion(widget.question);
    }
  }

  void _attachQuestion(Question q) {
    _title = TextEditingController(text: q.title);
    _desc = TextEditingController(text: q.description);
    _imageUrl = TextEditingController(text: q.imageUrl ?? '');
    _a1 = TextEditingController(text: q.firstAnswer);
    _a2 = TextEditingController(text: q.secondAnswer);
    _a3 = TextEditingController(text: q.thirdAnswer);
    _correct = q.rightAnswerNumber.clamp(1, 3);
  }

  void _disposeQuestionControllers() {
    _title.dispose();
    _desc.dispose();
    _imageUrl.dispose();
    _a1.dispose();
    _a2.dispose();
    _a3.dispose();
  }

  @override
  void dispose() {
    _disposeQuestionControllers();
    super.dispose();
  }

  Question _buildQuestion() {
    final img = _imageUrl.text.trim();
    return widget.question.copyWith(
      title: _title.text,
      description: _desc.text,
      imageUrl: img.isEmpty ? null : img,
      firstAnswer: _a1.text,
      secondAnswer: _a2.text,
      thirdAnswer: _a3.text,
      rightAnswerNumber: _correct,
    );
  }

  void _notify() => widget.onChanged(_buildQuestion());

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  '${context.strings.questionSectionTitle} ${widget.index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: widget.onRemove,
                  child: Text(context.strings.removeItem),
                ),
              ],
            ),
            CustomTextField(
              controller: _title,
              label: context.strings.questionTitleLabel,
              icon: Icons.help_outline,
              onChanged: (_) => _notify(),
            ),
            CustomTextField(
              controller: _desc,
              label: context.strings.questionDescriptionLabel,
              icon: Icons.notes,
              maxLines: 2,
              minLines: 1,
              onChanged: (_) => _notify(),
            ),
            CustomTextField(
              controller: _imageUrl,
              label: context.strings.questionImageUrlLabel,
              icon: Icons.image_outlined,
              onChanged: (_) => _notify(),
            ),
            CustomTextField(
              controller: _a1,
              label: context.strings.answerVariant1,
              icon: Icons.looks_one_outlined,
              onChanged: (_) => _notify(),
            ),
            CustomTextField(
              controller: _a2,
              label: context.strings.answerVariant2,
              icon: Icons.looks_two_outlined,
              onChanged: (_) => _notify(),
            ),
            CustomTextField(
              controller: _a3,
              label: context.strings.answerVariant3,
              icon: Icons.looks_3_outlined,
              onChanged: (_) => _notify(),
            ),
            const SizedBox(height: 8),
            Text(
              context.strings.correctAnswerLabel,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 1, label: Text('1')),
                ButtonSegment(value: 2, label: Text('2')),
                ButtonSegment(value: 3, label: Text('3')),
              ],
              selected: {_correct},
              onSelectionChanged: (set) {
                setState(() {
                  _correct = set.first;
                });
                _notify();
              },
            ),
          ],
        ),
      ),
    );
  }
}

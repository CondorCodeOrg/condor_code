import 'package:condorcode_admin/presentation/logic/lessons/lesson_editor_notifier/lesson_editor_state.dart';
import 'package:condorcode_admin/presentation/logic/providers.dart';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final lessonEditorProvider =
    StateNotifierProvider<LessonEditorNotifier, LessonEditorState>(
      (ref) => LessonEditorNotifier(
        ref: ref,
        lessonsRepository: ref.watch(lessonsRepositoryProvider),
      ),
    );

class LessonEditorNotifier extends StateNotifier<LessonEditorState> {
  LessonEditorNotifier({required this.ref, required this.lessonsRepository})
    : super(const LessonEditorState());

  final Ref ref;
  final LessonsRepository lessonsRepository;

  void startNew(String courseId) {
    state = LessonEditorState(
      lesson: Lesson(
        id: '',
        courseId: courseId.trim(),
        youtubeUrl: '',
        isYouTubeLesson: true,
        title: '',
        topic: '',
        description: '',
      ),
      tasks: const [],
      questions: const [],
      isLoading: false,
      isSaving: false,
      errorMessage: null,
    );
  }

  Future<void> loadForEdit(String lessonId) async {
    final id = lessonId.trim();
    if (id.isEmpty) {
      state = state.copyWith(errorMessage: 'lessonId is empty');
      return;
    }

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      lesson: null,
      tasks: const [],
      questions: const [],
    );

    final lessonResult = await lessonsRepository.getLesson(id);
    if (lessonResult is ErrorResult<Lesson>) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: lessonResult.message,
      );
      return;
    }
    final lesson = (lessonResult as SuccessResult<Lesson>).data;
    if (lesson == null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Lesson not found',
      );
      return;
    }

    final parallel = await Future.wait([
      lessonsRepository.fetchTasksForLesson(id),
      lessonsRepository.fetchQuestionsForLesson(id),
    ]);

    final tasksResult = parallel[0] as DataResult<List<Task>>;
    final questionsResult = parallel[1] as DataResult<List<Question>>;

    if (tasksResult is ErrorResult<List<Task>>) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: tasksResult.message,
        lesson: lesson,
      );
      return;
    }
    if (questionsResult is ErrorResult<List<Question>>) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: questionsResult.message,
        lesson: lesson,
      );
      return;
    }

    final tasks = (tasksResult as SuccessResult<List<Task>>).data ?? const [];
    final questions =
        (questionsResult as SuccessResult<List<Question>>).data ?? const [];

    state = state.copyWith(
      isLoading: false,
      lesson: lesson,
      tasks: List<Task>.from(tasks),
      questions: List<Question>.from(questions),
    );
  }

  void updateLesson(Lesson lesson) {
    state = state.copyWith(lesson: lesson, errorMessage: null);
  }

  void addTask() {
    final current = state.lesson;
    if (current == null) return;

    final task = Task(
      id: '',
      lessonId: current.id,
      mediaUrl: '',
      title: '',
      description: '',
      answer: Answer(
        title: '',
        mediaUrl: '',
        description: '',
        listImages: const [],
      ),
      listImages: const [],
    );
    state = state.copyWith(tasks: [...state.tasks, task], errorMessage: null);
  }

  void updateTask(int index, Task task) {
    if (index < 0 || index >= state.tasks.length) return;
    final next = List<Task>.from(state.tasks);
    next[index] = task;
    state = state.copyWith(tasks: next, errorMessage: null);
  }

  void removeTask(int index) {
    if (index < 0 || index >= state.tasks.length) return;
    final next = List<Task>.from(state.tasks)..removeAt(index);
    state = state.copyWith(tasks: next, errorMessage: null);
  }

  void addQuestion() {
    final current = state.lesson;
    if (current == null) return;

    final question = Question(
      id: '',
      lessonId: current.id,
      rightAnswerNumber: 1,
      title: '',
      description: '',
      firstAnswer: '',
      secondAnswer: '',
      thirdAnswer: '',
    );
    state = state.copyWith(
      questions: [...state.questions, question],
      errorMessage: null,
    );
  }

  void updateQuestion(int index, Question question) {
    if (index < 0 || index >= state.questions.length) return;
    final next = List<Question>.from(state.questions);
    next[index] = question;
    state = state.copyWith(questions: next, errorMessage: null);
  }

  void removeQuestion(int index) {
    if (index < 0 || index >= state.questions.length) return;
    final next = List<Question>.from(state.questions)..removeAt(index);
    state = state.copyWith(questions: next, errorMessage: null);
  }

  Future<void> save() async {
    final lesson = state.lesson;
    if (lesson == null) {
      state = state.copyWith(errorMessage: 'No lesson to save');
      return;
    }

    state = state.copyWith(isSaving: true, errorMessage: null);

    final result = await lessonsRepository.saveLessonBundle(
      lesson: lesson,
      tasks: state.tasks,
      questions: state.questions,
    );

    if (result is ErrorResult<LessonBundle>) {
      if (mounted) {
        state = state.copyWith(isSaving: false, errorMessage: result.message);
      }
      return;
    }

    final bundle = (result as SuccessResult<LessonBundle>).data;
    if (bundle == null) {
      if (mounted) {
        state = state.copyWith(
          isSaving: false,
          errorMessage: 'Empty bundle response',
        );
      }
      return;
    }

    if (mounted) {
      state = state.copyWith(
        isSaving: false,
        lesson: bundle.lesson,
        tasks: List<Task>.from(bundle.tasks),
        questions: List<Question>.from(bundle.questions),
        errorMessage: null,
      );
    }
  }
}

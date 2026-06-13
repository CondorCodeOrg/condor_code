import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/screens/lesson/provider/lesson_screen_events_provider.dart';

part 'lesson_state.dart';

class LessonCubit extends BaseCubit<LessonState> {
  final LessonScreenEventsProvider lessonScreenEventsProvider;

  LessonCubit({
    required this.lessonScreenEventsProvider,
    required super.snackBarEventsProvider,
  }) : super(LessonLoading()) {
    subscriptions.add(
      lessonScreenEventsProvider.events.listen((action) {
        switch (action) {
          case LessonScreenAction.loaded:
            emit(LessonLoaded());
          case LessonScreenAction.rightAnswer:
            emit(LessonRightAnswer());
          case LessonScreenAction.wrongAnswer:
            emit(LessonWrongAnswer());
          case LessonScreenAction.workOnMistakes:
            emit(LessonWorkOnMistakes());
          case LessonScreenAction.move:
            emit(LessonMoving());
          case LessonScreenAction.loseHearts:
            emit(LessonLoseHearts());
          case LessonScreenAction.finish:
            emit(LessonFinished());
          case LessonScreenAction.failedToLoad:
            emit(LessonLoadFailure());
        }
      }),
    );
  }

  void moveNextQuestion() {
    emit(LessonMoving());
  }
}

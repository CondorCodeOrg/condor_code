import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/screens/test/provider/test_screen_events_provider.dart';

part 'test_state.dart';

class TestCubit extends BaseCubit<TestState> {
  final TestScreenEventsProvider testScreenEventsProvider;

  TestCubit({
    required this.testScreenEventsProvider,
    required super.snackBarEventsProvider,
  }) : super(TestLoading()) {
    subscriptions.add(
      testScreenEventsProvider.events.listen((action) {
        switch (action) {
          case TestScreenAction.loaded:
            emit(TestLoaded());
          case TestScreenAction.rightAnswer:
            emit(TestRightAnswer());
          case TestScreenAction.wrongAnswer:
            emit(TestWrongAnswer());
          case TestScreenAction.workOnMistakes:
            emit(TestWorkOnMistakes());
          case TestScreenAction.move:
            emit(TestMoving());
          case TestScreenAction.loseHearts:
            emit(TestLoseHearts());
          case TestScreenAction.finish:
            emit(TestFinished());
          case TestScreenAction.failedToLoad:
            emit(TestLoadFailure());
        }
      }),
    );
  }

  void moveNextQuestion() {
    emit(TestMoving());
  }
}

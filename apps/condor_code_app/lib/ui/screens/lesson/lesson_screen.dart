import 'package:audioplayers/audioplayers.dart';
import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/screens/heart_information_screen.dart';
import 'package:condor_code/ui/screens/lesson/bloc/lesson_cubit.dart';
import 'package:condor_code/ui/screens/lesson/bloc/questions/questions_bloc.dart';
import 'package:condor_code/ui/screens/lesson/bloc/questions/questions_event.dart';
import 'package:condor_code/ui/screens/lesson/bloc/questions/questions_state.dart';
import 'package:condor_code/ui/screens/lesson/utils/timer_controller.dart';
import 'package:condor_code/ui/screens/result_screen.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:condor_code/ui/widgets/answer_result_bottom_sheet.dart';
import 'package:condor_code/ui/widgets/exit_from_lesson_bottom_sheet.dart';
import 'package:condor_code/ui/widgets/lesson_progress_bar.dart';
import 'package:condor_code/ui/widgets/lesson_timer.dart';
import 'package:condor_code/ui/widgets/question_page.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

part '_lesson_header.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final timerController = TimerController();

  PageController controller = PageController(initialPage: 0);

  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    timerController.start();
  }

  @override
  void dispose() {
    controller.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => di<LessonCubit>()),
      BlocProvider(
        create: (context) =>
            di<QuestionsBloc>(param1: widget.lessonId)
              ..add(OnLoadQuestionsEvent()),
        lazy: false,
      ),
    ],
    //TODO: Refactor deprecated popscope.
    child: PopScope(
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        if (!didPop) {
          _showExitBottomSheet();
        }
      },
      child: Scaffold(
        backgroundColor: context.colors.scaffoldBackground,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: BlocConsumer<LessonCubit, LessonState>(
            listener: (BuildContext context, LessonState state) {
              final questionsBloc = BlocProvider.of<QuestionsBloc>(context);

              switch (state) {
                case LessonMoving():
                  _scrollToNextQuestion();
                  break;
                case LessonRightAnswer():
                  _playCorrectSound();
                  _showAnswerResultBottomSheet(questionsBloc, isSuccess: true);
                  break;
                case LessonWrongAnswer():
                  _playInCorrectSound();
                  _showAnswerResultBottomSheet(questionsBloc, isSuccess: false);
                  break;
                case LessonWorkOnMistakes():
                  _showWorkOnMistakesBottomSheet();
                  _scrollToFirstQuestion();
                  break;
                case LessonLoseHearts():
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HeartInformationScreen(),
                    ),
                  );
                  break;
                case LessonFinished():
                  _navigateToResultScreen(context, questionsBloc);
                  break;
                case LessonLoadFailure():
                  _returnToPreviousPageWithError(context);
                  break;
                case LessonLoading():
                  break;
                case LessonLoaded():
                  break;
              }
            },
            buildWhen: (prev, cur) =>
                prev is LessonLoading || cur is LessonLoading,
            builder: (context, state) {
              if (state is LessonLoading) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Skeleton(
                      name: CondorHollowSkeletonIds.lessonScreen,
                      loading: true,
                      color: context.colors.surface.withValues(alpha: 0.45),
                      highlightColor: context.colors.accent.withValues(alpha: 0.1),
                      child: const SizedBox.shrink(),
                    ),
                  ),
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(child: LessonTimer(timerController: timerController)),
                  _LessonHeader(
                    onBackBottomPressed: () {
                      _showExitBottomSheet();
                    },
                  ),
                  Expanded(
                    child:
                        BlocSelector<
                          QuestionsBloc,
                          QuestionsState,
                          List<Question>
                        >(
                          selector: (state) => state.questions,
                          builder: (context, value) => PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: controller,
                            children: _convertQuestionsToWidgets(
                              value,
                              context,
                            ),
                          ),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton(
                      style: AppButtonStyles.mainButtonStyle(context),
                      onPressed: () {
                        BlocProvider.of<QuestionsBloc>(
                          context,
                        ).add(OnMoveOnButtonPressedEvent());
                      },
                      child: const Text('MOVE ON', style: AppTextStyles.button),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ),
  );

  Future<void> _playCorrectSound() async {
    const String audioPath = 'audio/correct_answer.mp3';
    await player.play(AssetSource(audioPath));
  }

  Future<void> _playInCorrectSound() async {
    const String audioPath = 'audio/buzzerwav-14769.mp3';
    await player.play(AssetSource(audioPath));
  }

  void _navigateToResultScreen(BuildContext context, QuestionsBloc bloc) {
    timerController.stop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          seconds: timerController.seconds,
          correctAnswer: bloc.state.correctCounter,
          inCorrectAnswer: bloc.state.incorrectCounter,
        ),
      ),
    );
  }

  _onAnswerResultDialogButtonPressed(QuestionsBloc bloc) async {
    bloc.add(OnConfirmQuestionEvent());
    Navigator.pop(context);
  }

  void _scrollToNextQuestion() {
    controller.animateToPage(
      controller.page!.toInt() + 1,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToFirstQuestion() {
    controller.animateToPage(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  List<Widget> _convertQuestionsToWidgets(
    List<Question> questions,
    BuildContext context,
  ) {
    final List<Widget> widgets = [];
    for (int i = 0; i < questions.length; i++) {
      widgets.add(
        QuestionPage(
          question: questions[i],
          questionPosition: i,
          onAnswerSelected: (int questionPosition, int selectedAnswerNumber) {
            if (selectedAnswerNumber != 0) {
              BlocProvider.of<QuestionsBloc>(
                context,
              ).add(OnAnswerSelectedEvent(answerNumber: selectedAnswerNumber));
            }
          },
        ),
      );
    }
    return widgets;
  }

  void _showAnswerResultBottomSheet(
    QuestionsBloc questionsBloc, {
    required bool isSuccess,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (BuildContext context) => PopScope(
        canPop: false,
        child: BlocProvider<QuestionsBloc>.value(
          value: questionsBloc,
          child: isSuccess
              ? AnswerResultBottomSheet.correct(
                  onButtonPressed: () =>
                      _onAnswerResultDialogButtonPressed(questionsBloc),
                )
              : AnswerResultBottomSheet.incorrect(
                  rightAnswerNumber:
                      questionsBloc.state.currentQuestion.rightAnswerNumber,
                  onButtonPressed: () =>
                      _onAnswerResultDialogButtonPressed(questionsBloc),
                ),
        ),
      ),
    );
  }

  Future<void> _showWorkOnMistakesBottomSheet() async => showModalBottomSheet(
    isDismissible: false,
    enableDrag: false,
    context: context,
    builder: (BuildContext context) => PopScope(
      canPop: false,
      child: AnswerResultBottomSheet.mistakesInformation(
        onButtonPressed: () => Navigator.pop(context),
      ),
    ),
  );

  void _returnToPreviousPageWithError(BuildContext context) {
    Navigator.of(context).pop();
    Fluttertoast.showToast(msg: 'Извините, случилась ошибка', fontSize: 16.0);
  }

  _showExitBottomSheet() => showModalBottomSheet(
    isDismissible: false,
    enableDrag: false,
    context: context,
    builder: (BuildContext context) => const ExitFromlessonBottomSheet(),
  );
}

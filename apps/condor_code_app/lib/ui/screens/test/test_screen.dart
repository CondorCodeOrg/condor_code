import 'package:audioplayers/audioplayers.dart';
import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/screens/test/bloc/test_cubit.dart';
import 'package:condor_code/ui/screens/test/bloc/questions/questions_bloc.dart';
import 'package:condor_code/ui/screens/test/bloc/questions/questions_event.dart';
import 'package:condor_code/ui/screens/test/bloc/questions/questions_state.dart';
import 'package:condor_code/ui/screens/test/utils/timer_controller.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:condor_code/ui/widgets/answer_result_bottom_sheet.dart';
import 'package:condor_code/ui/widgets/exit_from_test_bottom_sheet.dart';
import 'package:condor_code/ui/widgets/test_progress_bar.dart';
import 'package:condor_code/ui/widgets/test_timer.dart';
import 'package:condor_code/ui/widgets/question_page.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:condor_code/ui/base/provider/events/snack_bar_events_provider.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/analytics_constants.dart';

part '_test_header.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key, required this.lessonId, required this.courseId});

  final String lessonId;
  final String courseId;

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final timerController = TimerController();

  PageController controller = PageController(initialPage: 0);

  final player = AudioPlayer();
  bool _isBottomSheetOpen = false;

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
      BlocProvider(create: (context) => di<TestCubit>()),
      BlocProvider(
        create: (context) =>
            di<QuestionsBloc>(param1: widget.lessonId)
              ..add(OnLoadQuestionsEvent()),
        lazy: false,
      ),
    ],
    child: PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _showExitBottomSheet();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.grey800,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Focus(
            autofocus: true,
            onKeyEvent: (node, event) {
              if (event is KeyDownEvent) {
                final keyLabel = event.logicalKey.keyLabel;
                if (keyLabel == '1' ||
                    keyLabel == '2' ||
                    keyLabel == '3' ||
                    keyLabel == '4') {
                  final option = int.parse(keyLabel);
                  BlocProvider.of<QuestionsBloc>(
                    context,
                  ).add(OnAnswerSelectedEvent(answerNumber: option));
                  return KeyEventResult.handled;
                } else if (event.logicalKey == LogicalKeyboardKey.enter) {
                  if (_isBottomSheetOpen) {
                    _onAnswerResultDialogButtonPressed(
                      BlocProvider.of<QuestionsBloc>(context),
                    );
                  } else {
                    BlocProvider.of<QuestionsBloc>(
                      context,
                    ).add(OnMoveOnButtonPressedEvent());
                  }
                  return KeyEventResult.handled;
                }
              }
              return KeyEventResult.ignored;
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth >= 1024;
                final widgetContent = BlocConsumer<TestCubit, TestState>(
                  listener: (BuildContext context, TestState state) {
                    final questionsBloc = BlocProvider.of<QuestionsBloc>(
                      context,
                    );

                    switch (state) {
                      case TestMoving():
                        _scrollToNextQuestion();
                        break;
                      case TestRightAnswer():
                        _playCorrectSound();
                        _showAnswerResultBottomSheet(
                          questionsBloc,
                          isSuccess: true,
                        );
                        break;
                      case TestWrongAnswer():
                        _playInCorrectSound();
                        _showAnswerResultBottomSheet(
                          questionsBloc,
                          isSuccess: false,
                        );
                        break;
                      case TestWorkOnMistakes():
                        _showWorkOnMistakesBottomSheet();
                        _scrollToFirstQuestion();
                        break;
                      case TestLoseHearts():
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          context.go(
                            '/course/${widget.courseId}/${widget.lessonId}/tests/${widget.lessonId}/hearts',
                          );
                        });
                        break;
                      case TestFinished():
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _navigateToResultScreen(context, questionsBloc);
                        });
                        break;
                      case TestLoadFailure():
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _returnToPreviousPageWithError(context);
                        });
                        break;
                      case TestLoading():
                        break;
                      case TestLoaded():
                        break;
                    }
                  },
                  buildWhen: (prev, cur) =>
                      prev is TestLoading || cur is TestLoading,
                  builder: (context, state) {
                    if (state is TestLoading) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Skeleton(
                            name: CondorHollowSkeletonIds.lessonScreen,
                            loading: true,
                            color: AppColors.grey600.withValues(alpha: 0.45),
                            highlightColor: AppColors.neon.withValues(
                              alpha: 0.1,
                            ),
                            child: const SizedBox.shrink(),
                          ),
                        ),
                      );
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: TestTimer(timerController: timerController),
                        ),
                        _TestHeader(
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
                            style: AppButtonStyles.mainButtonStyle,
                            onPressed: () {
                              BlocProvider.of<QuestionsBloc>(
                                context,
                              ).add(OnMoveOnButtonPressedEvent());
                            },
                            child: const Text(
                              'MOVE ON',
                              style: AppTextStyles.button,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );

                if (isDesktop) {
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: widgetContent,
                    ),
                  );
                }

                return widgetContent;
              },
            ),
          ),
        ),
      ),
    ),
  );

  Future<void> _playCorrectSound() async {
    try {
      const String audioPath = 'audio/correct_answer.mp3';
      await player.play(AssetSource(audioPath));
    } catch (e) {
      debugPrint('Failed to play correct sound: $e');
    }
  }

  Future<void> _playInCorrectSound() async {
    try {
      const String audioPath = 'audio/buzzerwav-14769.mp3';
      await player.play(AssetSource(audioPath));
    } catch (e) {
      debugPrint('Failed to play incorrect sound: $e');
    }
  }

  void _navigateToResultScreen(BuildContext context, QuestionsBloc bloc) {
    timerController.stop();
    di<Analytics>().logEvent(AnalyticsEventName.testCompleted, {
      AnalyticsPropertyName.lessonId: widget.lessonId,
      'correct_count': bloc.state.correctCounter,
      'incorrect_count': bloc.state.incorrectCounter,
      'duration_seconds': timerController.seconds,
    });
    context.go(
      '/course/${widget.courseId}/${widget.lessonId}/tests/${widget.lessonId}/result',
      extra: {
        'seconds': timerController.seconds,
        'correctAnswer': bloc.state.correctCounter,
        'inCorrectAnswer': bloc.state.incorrectCounter,
      },
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
    _isBottomSheetOpen = true;
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
    ).then((_) {
      _isBottomSheetOpen = false;
    });
  }

  Future<void> _showWorkOnMistakesBottomSheet() async {
    _isBottomSheetOpen = true;
    await showModalBottomSheet(
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
    _isBottomSheetOpen = false;
  }

  void _returnToPreviousPageWithError(BuildContext context) {
    context.pop();
    di<SnackBarEventsProvider>().addEvent(
      SnackBarEvent.error('Sorry, an error occurred.'),
    );
  }

  _showExitBottomSheet() => showModalBottomSheet(
    isDismissible: false,
    enableDrag: false,
    context: context,
    builder: (BuildContext context) => const ExitFromTestBottomSheet(),
  );
}

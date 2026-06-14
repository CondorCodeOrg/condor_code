import 'package:condor_code/ui/l10n/app_localizations.dart';
import 'package:condor_code/ui/screens/test_selection/test_selection_cubit.dart';
import 'package:condor_code/ui/screens/test_selection/test_selection_state.dart';
import 'package:condor_code/ui/screens/test_selection/widgets/test_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/analytics_constants.dart';

class TestSelectionScreen extends StatefulWidget {
  final String courseId;
  final String lessonId;

  const TestSelectionScreen({
    super.key,
    required this.courseId,
    required this.lessonId,
  });

  @override
  State<TestSelectionScreen> createState() => _TestSelectionScreenState();
}

class _TestSelectionScreenState extends State<TestSelectionScreen> {
  @override
  void initState() {
    super.initState();
    // Load the test details when the screen initializes.
    context.read<TestSelectionCubit>().loadTests();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.grey800,
      appBar: AppBar(
        backgroundColor: AppColors.grey800,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.white,
          ),
          onPressed: () => context.pop(),
        ),
        title: BlocBuilder<TestSelectionCubit, TestSelectionState>(
          builder: (context, state) {
            final lessonName = state is TestSelectionLoaded
                ? state.lessonName
                : '';
            return Text(
              lessonName.isNotEmpty ? 'Tests for $lessonName' : 'Select Test',
              style: AppTextStyles.h1.copyWith(color: AppColors.white),
            );
          },
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<TestSelectionCubit, TestSelectionState>(
          builder: (context, state) {
            if (state is TestSelectionLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.neon),
              );
            }

            if (state is TestSelectionError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.alertRed,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.message,
                        style: AppTextStyles.body1.copyWith(
                          color: AppColors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: AppButtonStyles.smallButtonStyle,
                        onPressed: () =>
                            context.read<TestSelectionCubit>().loadTests(),
                        child: const Text('Retry', style: AppTextStyles.button),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is TestSelectionLoaded) {
              final tests = state.tests;
              final selectedTestId = state.selectedTestId;

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: tests.length,
                      itemBuilder: (context, index) {
                        final test = tests[index];
                        final isSelected = test.id == selectedTestId;
                        return TestCard(
                          test: test,
                          isSelected: isSelected,
                          onTap: () {
                            context.read<TestSelectionCubit>().selectTest(
                              test.id,
                            );
                            di<Analytics>().logEvent(
                              AnalyticsEventName.testSelected,
                              {
                                AnalyticsPropertyName.lessonId: widget.lessonId,
                                'test_id': test.id,
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: AppButtonStyles.mainButtonStyle.copyWith(
                          backgroundColor:
                              WidgetStateProperty.resolveWith<Color?>((states) {
                                if (selectedTestId == null) {
                                  return AppColors.grey400;
                                }
                                return AppColors.neon;
                              }),
                        ),
                        onPressed: selectedTestId == null
                            ? null
                            : () {
                                di<Analytics>()
                                    .logEvent(AnalyticsEventName.testStarted, {
                                      AnalyticsPropertyName.lessonId:
                                          widget.lessonId,
                                      'test_id': selectedTestId,
                                    });
                                context.go(
                                  '/course/${widget.courseId}/${widget.lessonId}/tests/$selectedTestId',
                                );
                              },
                        child: Text(
                          l10n.startTest.toUpperCase(),
                          style: AppTextStyles.button.copyWith(
                            color: selectedTestId == null
                                ? AppColors.grey200
                                : AppColors.darkGrey800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

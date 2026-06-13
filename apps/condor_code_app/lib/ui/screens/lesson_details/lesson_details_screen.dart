import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/analytics_constants.dart';
import 'package:condor_code/ui/navigation/route_constants.dart';
import 'package:condor_code/ui/screens/lesson_details/lesson_details_cubit/lesson_details_cubit.dart';
import 'package:condor_code/ui/screens/lesson_details/lesson_details_cubit/lesson_details_state.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/top_navigation_bar.dart';
import 'package:condor_code/ui/widgets/youtube_player.dart';
import 'package:domain/models/lesson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class LessonDetailsScreen extends StatelessWidget {
  final String lessonId;

  const LessonDetailsScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<LessonDetailsCubit>(param1: lessonId),
      child: BlocBuilder<LessonDetailsCubit, LessonDetailsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.grey800,
            body: SafeArea(child: _MainContent(state: state)),
          );
        },
      ),
    );
  }
}

class _CheckButton extends StatelessWidget {
  final Lesson lesson;

  const _CheckButton({required this.lesson});

  @override
  Widget build(BuildContext context) {
    // TODO: add this logic for mobile app.
    // final TasksListScreenExtra tasksInfo = TasksListScreenExtra(lesson: lesson);
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            di<Analytics>().logEvent(AnalyticsEventName.buttonClick, {
              AnalyticsPropertyName.buttonId: AnalyticsButtonId.checkKnowledge,
              AnalyticsPropertyName.lessonId: lesson.id,
            });
            context.push(RouteConstants.tasksListScreen);
          },
          style: AppButtonStyles.mainButtonStyle,
          child: Text(localization.checkMyKnowledge),
        ),
      ),
    );
  }
}

class _DescriptionText extends StatelessWidget {
  final String description;

  const _DescriptionText({required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18, right: 24, left: 24),
      child: Text(
        description,
        style: AppTextStyles.body3.copyWith(color: AppColors.lightGrey),
      ),
    );
  }
}

class _WatchOnYouTubeTextButton extends StatelessWidget {
  final String youtubeUrl;

  const _WatchOnYouTubeTextButton({required this.youtubeUrl});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LessonDetailsCubit>(context);
    return TextButton(
      onPressed: () async {
        final url = Uri.parse(youtubeUrl);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          cubit.showErrorSnackBar(localization.canNotOpenUrl(youtubeUrl));
        }
      },
      child: Text(
        localization.watchOnYouTube,
        style: AppTextStyles.body2.copyWith(color: AppColors.neon),
      ),
    );
  }
}

class _YouTubePlayer extends StatelessWidget {
  final String youtubeUrl;

  const _YouTubePlayer({required this.youtubeUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 24, left: 24),
      child: YouTubePlayerWidget(
        // TODO: Make a full screen YouTubePlayer
        youtubeUrl: youtubeUrl,
      ),
    );
  }
}

class _LessonDetailsSkeleton extends StatelessWidget {
  const _LessonDetailsSkeleton();

  @override
  Widget build(BuildContext context) {
    // TODO: add this logic for mobile app.
    // final height = MediaQuery.of(context).size.height;

    return const Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TODO: add this logic for mobile app.
            // const Skeleton(loading: loadin, child: child),
            //
            // const SizedBox(height: 24),
            //
            // Skeleton(
            //   height: 28,
            //   width: MediaQuery.of(context).size.width * 0.5,
            // ),
            //
            // const SizedBox(height: 24),
            //
            // Skeleton(height: height * 0.25, width: double.infinity),
            //
            // const SizedBox(height: 20),
            //
            // Skeleton(
            //   height: 20,
            //   width: MediaQuery.of(context).size.width * 0.4,
            // ),
            //
            // const SizedBox(height: 24),
            //
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const Skeleton(height: 16, width: double.infinity),
            //     const SizedBox(height: 12),
            //     Skeleton(
            //       height: 16,
            //       width: MediaQuery.of(context).size.width * 0.6,
            //     ),
            //     const SizedBox(height: 12),
            //     Skeleton(
            //       height: 16,
            //       width: MediaQuery.of(context).size.width * 0.8,
            //     ),
            //     const SizedBox(height: 12),
            //     Skeleton(
            //       height: 16,
            //       width: MediaQuery.of(context).size.width * 0.4,
            //     ),
            //   ],
            // ),
            // const Spacer(),
            // const Skeleton(height: 56, width: double.infinity),
          ],
        ),
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  final LessonDetailsState state;

  const _MainContent({required this.state});

  @override
  Widget build(BuildContext context) {
    final state = this.state;
    return switch (state) {
      LessonDetailsLoading() => const Expanded(child: _LessonDetailsSkeleton()),
      LessonDetailsLoaded() => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TopNavigationBar(text: state.lesson.title),
            Text(
              state.lesson.topic,
              style: AppTextStyles.h2.copyWith(color: AppColors.neon),
            ),
            _YouTubePlayer(youtubeUrl: state.lesson.youtubeUrl),
            state.lesson.isYouTubeLesson
                ? _WatchOnYouTubeTextButton(youtubeUrl: state.lesson.youtubeUrl)
                : const SizedBox.shrink(),
            _DescriptionText(description: state.lesson.description),
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            _CheckButton(lesson: state.lesson),
          ],
        ),
      ),
    };
  }
}

import 'package:condor_code/ui/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:domain/models/lesson.dart';
import 'package:ui_kit/ui_kit.dart';

class LessonSummaryScreen extends StatelessWidget {
  final Lesson lesson;

  const LessonSummaryScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final summary = lesson.summary;

    return Scaffold(
      backgroundColor: AppColors.grey800,
      appBar: AppBar(title: Text(localization.summary)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lesson.title,
                style: AppTextStyles.h2.copyWith(color: AppColors.neon),
              ),

              const SizedBox(height: 12),

              Text(
                lesson.topic,
                style: AppTextStyles.body2.copyWith(color: AppColors.lightGrey),
              ),

              const SizedBox(height: 24),

              Text(
                (summary != null && summary.isNotEmpty)
                    ? summary
                    : localization.noSummaryAvailable,
                style: AppTextStyles.body3.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

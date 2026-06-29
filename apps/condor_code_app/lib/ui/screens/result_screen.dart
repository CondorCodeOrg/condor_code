import 'package:audioplayers/audioplayers.dart';
import 'package:condor_code/ui/l10n/app_localizations.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends StatefulWidget {
  final int seconds;
  final int correctAnswer;
  final int inCorrectAnswer;
  final String? courseId;
  final String? lessonId;

  const ResultScreen({
    super.key,
    required this.seconds,
    required this.correctAnswer,
    required this.inCorrectAnswer,
    this.courseId,
    this.lessonId,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    playCelebrationSound();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int sumAnswers = widget.inCorrectAnswer + widget.correctAnswer;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.grey800,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Lottie.asset(
                'packages/ui_kit/assets/animations/celebration.json',
              ),
            ),
            Text(l10n.resultPerfectTest, style: AppTextStyles.body2),
            Text(l10n.resultApplause, style: AppTextStyles.body3),
            const SizedBox(height: 80),
            _ResultScoreCards(
              seconds: widget.seconds,
              correctAnswer: widget.correctAnswer,
              sumAnswers: sumAnswers,
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  if (widget.courseId != null && widget.lessonId != null) {
                    context.go('/course/${widget.courseId}/${widget.lessonId}');
                  } else {
                    context.pop();
                  }
                },
                style: AppButtonStyles.mainButtonStyle,
                child: Text(l10n.resultGetPoints, style: AppTextStyles.body2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> playCelebrationSound() async {
    try {
      const String audioPath = 'packages/ui_kit/assets/audio/wow.mp3';
      await player.play(AssetSource(audioPath));
    } catch (e) {
      debugPrint('Failed to play celebration sound: $e');
    }
  }
}

class _ResultScoreCards extends StatelessWidget {
  final int seconds;
  final int correctAnswer;
  final int sumAnswers;

  const _ResultScoreCards({
    required this.seconds,
    required this.correctAnswer,
    required this.sumAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final correctTime = formattedTime(timeInSecond: seconds);
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ResultScoreCard(
          color: Colors.purpleAccent,
          title: l10n.resultTotalPoints,
          value: '50',
          imagePath: 'packages/ui_kit/assets/images/lightning-bolt-4128.svg',
        ),
        _ResultScoreCard(
          color: Colors.blue,
          title: l10n.resultInstantly,
          value: correctTime,
          imagePath: 'packages/ui_kit/assets/images/result_time.svg',
        ),
        _ResultScoreCard(
          color: Colors.green,
          title: l10n.resultAmazing,
          value: '${convertToPercent(sumAnswers, correctAnswer)} %',
          imagePath: 'packages/ui_kit/assets/images/percentage_score.svg',
        ),
      ],
    );
  }

  // TODO: Move to utils
  double convertToPercent(int a, int b) {
    final result = 100 * b / a;
    return result;
  }

  String formattedTime({required int timeInSecond}) {
    final int sec = timeInSecond % 60;
    final int min = (timeInSecond / 60).floor();
    final String minute = min.toString().length <= 1 ? '0$min' : '$min';
    final String second = sec.toString().length <= 1 ? '0$sec' : '$sec';
    return '$minute : $second';
  }
}

class _ResultScoreCard extends StatelessWidget {
  final Color color;
  final String title;
  final String value;
  final String imagePath;

  const _ResultScoreCard({
    required this.color,
    required this.title,
    required this.value,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(title, style: AppTextStyles.body3),
      const SizedBox(height: 6),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: SizedBox(
              height: 30,
              width: 30,
              child: SvgPicture.asset(imagePath),
            ),
          ),
          Text(value, style: AppTextStyles.body2),
          const SizedBox(width: 16),
        ],
      ),
    ],
  );
}

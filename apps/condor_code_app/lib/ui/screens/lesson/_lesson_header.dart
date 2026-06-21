part of 'lesson_screen.dart';

class _LessonHeader extends StatelessWidget {
  final VoidCallback onBackBottomPressed;

  const _LessonHeader({required this.onBackBottomPressed});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined, size: 34, color: context.colors.textPrimary),
            onPressed: () {
              onBackBottomPressed();
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: BlocSelector<QuestionsBloc, QuestionsState, double>(
              selector: (QuestionsState state) => state.completePercentage,
              builder: (context, value) => LayoutBuilder(
                builder: (context, constraints) => LessonProgressBar(
                  width: constraints.maxWidth,
                  height: 20,
                  progress: value,
                  color: context.colors.scaffoldBackground,
                ),
              ),
            ),
          ),
        ),
        Image.asset('assets/images/heart.webp', width: 30, height: 30),
        const Padding(padding: EdgeInsets.only(left: 10)),
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: BlocSelector<QuestionsBloc, QuestionsState, int>(
            selector: (state) => state.heartCounter,
            builder: (context, value) =>
                Text('$value', style: AppTextStyles.body2),
          ),
        ),
      ],
    ),
  );
}

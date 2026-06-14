part of 'test_screen.dart';

class _TestHeader extends StatelessWidget {
  final VoidCallback onBackBottomPressed;

  const _TestHeader({required this.onBackBottomPressed});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 34),
            color: AppColors.white,
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
                builder: (context, constraints) => TestProgressBar(
                  width: constraints.maxWidth,
                  height: 20,
                  progress: value,
                  color: AppColors.grey800,
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

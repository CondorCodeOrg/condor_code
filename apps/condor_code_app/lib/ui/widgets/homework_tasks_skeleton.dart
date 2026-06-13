import 'package:flutter/material.dart';

class HomeworkTasksSkeleton extends StatelessWidget {
  final bool? isBottomButton;

  const HomeworkTasksSkeleton({this.isBottomButton, super.key});

  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;

    return const Padding(
      padding: EdgeInsets.only(bottom: 16, right: 20, left: 20, top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: add this logic for mobile app.

          // Padding(
          //   padding: const EdgeInsets.only(bottom: 8),
          //   child: Center(
          //     child: Skeleton(
          //       height: 20,
          //       width: MediaQuery.of(context).size.width * 0.5,
          //     ),
          //   ),
          // ),
          // Skeleton(height: h * 0.3, width: w),
          // const SizedBox(height: 20),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Skeleton(
          //         height: MediaQuery.of(context).size.height * 0.15,
          //         width: double.infinity,
          //       ),
          //     ),
          //     const SizedBox(width: 12),
          //     Expanded(
          //       child: Skeleton(
          //         height: MediaQuery.of(context).size.height * 0.15,
          //         width: double.infinity,
          //       ),
          //     ),
          //     const SizedBox(width: 12),
          //     Expanded(
          //       child: Skeleton(
          //         height: MediaQuery.of(context).size.height * 0.15,
          //         width: double.infinity,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 24),
          // Skeleton(height: 18, width: w * 0.8),
          // const SizedBox(height: 12),
          // Skeleton(height: 18, width: w * 0.9),
          // const SizedBox(height: 12),
          // Skeleton(height: 18, width: w * 0.7),
          // const SizedBox(height: 12),
          // Skeleton(height: 18, width: w * 0.85),
          // const SizedBox(height: 12),
          // Skeleton(height: 18, width: w * 0.6),
          // const Spacer(),
          //
          // if (isBottomButton == true)
          //   const Skeleton(height: 56, width: double.infinity),
        ],
      ),
    );
  }
}

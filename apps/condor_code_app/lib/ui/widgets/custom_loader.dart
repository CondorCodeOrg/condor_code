import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      margin: const EdgeInsets.only(top: 150),
      child: Column(
        children: [
          Image.asset('assets/images/duolingo.webp', width: 250),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Skeleton(
              name: CondorHollowSkeletonIds.customLoader,
              loading: true,
              color: Colors.grey.shade700,
              highlightColor: Colors.orangeAccent.withValues(alpha: 0.35),
              child: const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    ),
  );
}

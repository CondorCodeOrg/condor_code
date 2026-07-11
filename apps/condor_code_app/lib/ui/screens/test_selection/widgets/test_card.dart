import 'package:condor_code/ui/screens/test_selection/test_selection_state.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TestCard extends StatelessWidget {
  final TestModel test;
  final bool isSelected;
  final VoidCallback onTap;

  const TestCard({
    super.key,
    required this.test,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.grey600 : AppColors.grey400,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.neon : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.neon.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    test.title,
                    style: AppTextStyles.h2.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.neon.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    test.difficulty,
                    style: AppTextStyles.caption2.copyWith(
                      color: AppColors.neon,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.timer_outlined,
                  size: 16,
                  color: AppColors.lightGrey,
                ),
                const SizedBox(width: 4),
                Text(
                  '${test.durationMinutes} min',
                  style: AppTextStyles.caption1.copyWith(
                    color: AppColors.lightGrey,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.assignment_outlined,
                  size: 16,
                  color: AppColors.lightGrey,
                ),
                const SizedBox(width: 4),
                Text(
                  '${test.questionCount} Qs',
                  style: AppTextStyles.caption1.copyWith(
                    color: AppColors.lightGrey,
                  ),
                ),
                const Spacer(),
                Text(
                  test.status,
                  style: AppTextStyles.caption1.copyWith(
                    color: isSelected ? AppColors.neon : AppColors.grey200,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/empty_state.dart';
import 'package:flutter/material.dart';

class EmptyCourseScreen extends StatelessWidget {
  final String courseName;

  const EmptyCourseScreen({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: EmptyStateWidget(
                  imgUrl: 'packages/ui_kit/assets/images/flutter_logo.png',
                  title: localization.noLessonsInformation,
                  description: localization.informationWhereCoursesLocated(
                    courseName,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

//TODO: Return later.
// class _CourseHeader extends StatelessWidget {
//   const _CourseHeader({required this.courseName});
//
//   final String courseName;
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final isMobile = width < 700;
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//       decoration: BoxDecoration(
//         color: AppColors.grey600.withValues(alpha: 0.35),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: AppColors.grey400.withValues(alpha: 0.45)),
//       ),
//       child: Row(
//         children: [
//           if (isMobile) const SizedBox(width: 50),
//           ScreenBackButton(onPressed: () => context.go(RouteConstants.courses)),
//           const SizedBox(width: 10),
//           Container(
//             width: 34,
//             height: 34,
//             decoration: BoxDecoration(
//               color: AppColors.neon.withValues(alpha: 0.15),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(
//               Icons.school_rounded,
//               color: AppColors.neon,
//               size: 20,
//             ),
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Text(
//               courseName,
//               style: AppTextStyles.h2.copyWith(
//                 color: AppColors.white,
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

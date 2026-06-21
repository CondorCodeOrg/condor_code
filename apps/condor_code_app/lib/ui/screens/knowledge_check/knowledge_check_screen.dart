import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/analytics_constants.dart';
import 'package:condor_code/ui/navigation/route_constants.dart';
import 'package:condor_code/ui/screens/knowledge_check/knowledge_check_cubit/knowledge_check_cubit.dart';
import 'package:condor_code/ui/screens/knowledge_check/knowledge_check_cubit/knowledge_check_state.dart';
import 'package:condor_code/ui/screens/knowledge_check/widgets/knowledge_check_task_details_panel.dart';
import 'package:condor_code/ui/screens/knowledge_check/widgets/knowledge_check_task_list.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/screen_back_button.dart';
import 'package:condor_code/ui/widgets/side_panel_screen_widget.dart';
import 'package:condor_code/ui/widgets/snack_bar/snack_bar_producer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

class KnowledgeCheckScreen extends StatelessWidget {
  const KnowledgeCheckScreen({
    super.key,
    required this.courseId,
    required this.lessonId,
    required this.courseName,
    this.initialTaskId,
  });

  final String courseId;
  final String lessonId;
  final String courseName;
  final String? initialTaskId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          di<KnowledgeCheckCubit>(param1: lessonId, param2: initialTaskId),
      child: _KnowledgeCheckBody(
        courseId: courseId,
        lessonId: lessonId,
        courseName: courseName,
        routeTaskId: initialTaskId,
      ),
    );
  }
}

class _KnowledgeCheckBody extends StatelessWidget {
  const _KnowledgeCheckBody({
    required this.courseId,
    required this.lessonId,
    required this.courseName,
    required this.routeTaskId,
  });

  final String courseId;
  final String lessonId;
  final String courseName;
  final String? routeTaskId;

  void _onTaskSelected(BuildContext context, String taskId) {
    final currentTaskId = GoRouterState.of(context).pathParameters['taskId'];
    if (currentTaskId == taskId) return;

    di<Analytics>().logEvent(AnalyticsEventName.openTask, {
      AnalyticsPropertyName.courseId: courseId,
      AnalyticsPropertyName.lessonId: lessonId,
      AnalyticsPropertyName.taskId: taskId,
    });
    context.pushReplacement(
      '${RouteConstants.knowledgeCheck}/$courseId/lessons/$lessonId/tasks/$taskId',
      extra: courseName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = localization.knowledgeCheckTitle(courseName);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SnackBarProducerWidget(
          child: BlocBuilder<KnowledgeCheckCubit, KnowledgeCheckState>(
            builder: (context, state) {
              void onSelect(String id) => _onTaskSelected(context, id);

              return SidePanelScreenWidget(
                sidePanelBuilder: (collapsed) => _KnowledgeCheckWideTasksPanel(
                  collapsed: collapsed,
                  state: state,
                  sidebarSelectedTaskId: _effectiveSidebarTaskId(
                    state,
                    routeTaskId,
                  ),
                  onTaskSelected: onSelect,
                ),
                body: KnowledgeCheckTaskDetailsPanel(
                  task: state.selectedTask,
                  isLoading: state.isTaskDetailsLoading,
                ),
                // TODO uncomment if this logic will be need
                // actionsContentBuilder: (isExpanded) =>
                //     KnowledgeCheckActionPanel(
                //       expanded: isExpanded,
                //     ),
                header: _KnowledgeCheckHeader(
                  title: title,
                  courseId: courseId,
                  lessonId: lessonId,
                  courseName: courseName,
                ),
                narrowLayout: _NarrowLayout(
                  state: state,
                  title: title,
                  courseId: courseId,
                  lessonId: lessonId,
                  courseName: courseName,
                  sidebarSelectedTaskId: _effectiveSidebarTaskId(
                    state,
                    routeTaskId,
                  ),
                  onTaskSelected: onSelect,
                ),
                actionsContentWidth: 220,
                contentPadding: const EdgeInsets.all(16),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _KnowledgeCheckWideTasksPanel extends SidePanel {
  _KnowledgeCheckWideTasksPanel({
    required super.collapsed,
    required KnowledgeCheckState state,
    required String? sidebarSelectedTaskId,
    required ValueChanged<String> onTaskSelected,
  }) : super(
         expandedWidth: 280,
         collapsedWidth: 62,
         isLoading: state.isTasksLoading && state.tasks.isEmpty,
         loadingSkeletonName: CondorHollowSkeletonIds.tasksList,
         header: SidePanelHeader(
           icon: Icons.assignment_rounded,
           title: localization.knowledgeCheckTasks,
         ),
         child: KnowledgeCheckTaskList(
           tasks: state.tasks,
           selectedTaskId: sidebarSelectedTaskId,
           onTaskSelected: onTaskSelected,
           collapsed: collapsed,
         ),
       );
}

class _KnowledgeCheckNarrowTasksPanel extends SidePanel {
  _KnowledgeCheckNarrowTasksPanel({
    required KnowledgeCheckState state,
    required String? sidebarSelectedTaskId,
    required ValueChanged<String> onTaskSelected,
  }) : super(
         collapsed: false,
         compact: true,
         isLoading: state.isTasksLoading && state.tasks.isEmpty,
         loadingSkeletonName: CondorHollowSkeletonIds.tasksList,
         header: SidePanelHeader(
           icon: Icons.assignment_rounded,
           title: localization.knowledgeCheckTasks,
         ),
         child: KnowledgeCheckTaskList(
           tasks: state.tasks,
           selectedTaskId: sidebarSelectedTaskId,
           onTaskSelected: onTaskSelected,
           shrinkWrap: true,
         ),
       );
}

class _KnowledgeCheckHeader extends StatelessWidget {
  const _KnowledgeCheckHeader({
    required this.title,
    required this.courseId,
    required this.lessonId,
    required this.courseName,
    this.isNarrowLayout = false,
  });

  final String title;
  final String courseId;
  final String lessonId;
  final String courseName;
  final bool isNarrowLayout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: context.colors.surface.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.colors.border.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: [
          if (isNarrowLayout) const SizedBox(width: 50),
          ScreenBackButton(
            onPressed: () => _exitKnowledgeCheckViaAppBar(
              context,
              courseId: courseId,
              lessonId: lessonId,
              courseName: courseName,
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: context.colors.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.quiz_rounded,
              color: context.colors.accent,
              size: 20,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.h2.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({
    required this.state,
    required this.title,
    required this.courseId,
    required this.lessonId,
    required this.courseName,
    required this.sidebarSelectedTaskId,
    required this.onTaskSelected,
  });

  final KnowledgeCheckState state;
  final String title;
  final String courseId;
  final String lessonId;
  final String courseName;
  final String? sidebarSelectedTaskId;
  final ValueChanged<String> onTaskSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _KnowledgeCheckHeader(
          title: title,
          courseId: courseId,
          lessonId: lessonId,
          courseName: courseName,
          isNarrowLayout: true,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _KnowledgeCheckNarrowTasksPanel(
                  state: state,
                  sidebarSelectedTaskId: sidebarSelectedTaskId,
                  onTaskSelected: onTaskSelected,
                ),
                const SizedBox(height: 12),
                KnowledgeCheckTaskDetailsPanel(
                  task: state.selectedTask,
                  isLoading: state.isTaskDetailsLoading,
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        ),
        // TODO uncomment if this logic will be need
        // const Padding(
        //   padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
        //   child: KnowledgeCheckActionPanel(),
        // ),
      ],
    );
  }
}

void _exitKnowledgeCheckViaAppBar(
  BuildContext context, {
  required String courseId,
  required String lessonId,
  required String courseName,
}) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.go(
      '${RouteConstants.course}/$courseId/$lessonId',
      extra: courseName,
    );
  }
}

String? _effectiveSidebarTaskId(
  KnowledgeCheckState state,
  String? routeTaskId,
) {
  final route = routeTaskId;
  if (route != null && route.isNotEmpty && route != 'first') return route;
  return state.selectedTask?.id;
}

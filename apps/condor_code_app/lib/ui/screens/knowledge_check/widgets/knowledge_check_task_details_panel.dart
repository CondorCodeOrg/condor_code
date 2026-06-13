import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/custom_tab_bar.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:ui_kit/widgets/markdown.dart';

class KnowledgeCheckTaskDetailsPanel extends StatefulWidget {
  const KnowledgeCheckTaskDetailsPanel({
    super.key,
    required this.task,
    required this.isLoading,
    this.shrinkWrap = false,
  });

  final Task? task;
  final bool isLoading;
  final bool shrinkWrap;

  @override
  State<KnowledgeCheckTaskDetailsPanel> createState() =>
      _KnowledgeCheckTaskDetailsPanelState();
}

class _KnowledgeCheckTaskDetailsPanelState
    extends State<KnowledgeCheckTaskDetailsPanel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static const _tabsAmount = 2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabsAmount, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant KnowledgeCheckTaskDetailsPanel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.task?.id != widget.task?.id) {
      _tabController.animateTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey600.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey400.withValues(alpha: 0.55)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: (widget.isLoading || widget.task == null)
            ? Skeleton(
                name:
                    CondorHollowSkeletonIds.lessonAnswersDetailPanelFullScreen,
                loading: true,
                color: AppColors.grey600.withValues(alpha: 0.42),
                highlightColor: AppColors.neon.withValues(alpha: 0.12),
                child: const SizedBox.shrink(),
              )
            : _TaskContent(
                task: widget.task!,
                shrinkWrap: widget.shrinkWrap,
                tabController: _tabController,
              ),
      ),
    );
  }
}

class _TaskContent extends StatelessWidget {
  const _TaskContent({
    required this.task,
    required this.shrinkWrap,
    required this.tabController,
  });

  final Task task;
  final bool shrinkWrap;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1024;
    final body = Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // TODO uncomment when this logic will be need
          // SizedBox(height: 220, child: MediaWidget(url: task.mediaUrl)),
          // if (task.listImages.isNotEmpty)
          //   Padding(
          //     padding: const EdgeInsets.only(top: 8, bottom: 20),
          //     child: HomeworkImagesGallery(listImages: task.listImages),
          //   ),
          Center(
            child: SizedBox(
              width: isDesktop
                  ? MediaQuery.of(context).size.width * 0.28
                  : double.infinity,
              child: CustomTabBar(
                tabController: tabController,
                tabs: [
                  Tab(text: localization.task),
                  Tab(text: localization.answer),
                ],
              ),
            ),
          ),
          SizedBox(height: isDesktop ? 32 : 22),
          if (shrinkWrap)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  SingleChildScrollView(
                    child: Markdown(data: task.description),
                  ),
                  SingleChildScrollView(
                    child: Markdown(data: task.answer.description),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  SingleChildScrollView(
                    child: Markdown(data: task.description),
                  ),
                  SingleChildScrollView(
                    child: Markdown(data: task.answer.description),
                  ),
                ],
              ),
            ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
      children: [
        _TaskHeader(task: task),
        const Divider(color: AppColors.grey600, height: 1),
        if (shrinkWrap) body else Expanded(child: body),
      ],
    );
  }
}

class _TaskHeader extends StatelessWidget {
  const _TaskHeader({required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      child: Text(
        task.title,
        style: AppTextStyles.body1.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

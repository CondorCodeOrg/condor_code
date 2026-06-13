import 'package:condor_code/ui/widgets/sidebar_menu_tile.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// Lesson list content for the course side panel.
/// Wrap in [SidePanel] to get the container, header and collapse behaviour.
class CourseLessonsList extends StatefulWidget {
  const CourseLessonsList({
    super.key,
    required this.lessons,
    required this.selectedLessonId,
    required this.onLessonSelected,
    this.collapsed = false,
    this.shrinkWrap = false,
    this.courseId,
  });

  final List<LessonItem> lessons;
  final String? selectedLessonId;
  final ValueChanged<String> onLessonSelected;
  final bool collapsed;
  final bool shrinkWrap;
  final String? courseId;

  @override
  State<CourseLessonsList> createState() => _CourseLessonsListState();
}

class _CourseLessonsListState extends State<CourseLessonsList> {
  static final _scrollOffsets = <String, double>{};

  ScrollController? _controller;

  @override
  void initState() {
    super.initState();
    if (!widget.shrinkWrap) {
      _controller = ScrollController(initialScrollOffset: _savedOffset);
    }
  }

  double get _savedOffset {
    final id = widget.courseId;
    if (id != null && _scrollOffsets.containsKey(id)) {
      return _scrollOffsets[id]!;
    }
    return 0;
  }

  void _saveOffset() {
    final id = widget.courseId;
    if (id != null && _controller != null && _controller!.hasClients) {
      _scrollOffsets[id] = _controller!.offset;
    }
  }

  @override
  void dispose() {
    _saveOffset();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      padding: EdgeInsets.symmetric(vertical: widget.collapsed ? 4 : 8),
      itemCount: widget.lessons.length,
      itemBuilder: (context, index) {
        final lesson = widget.lessons[index];
        final isSelected = lesson.id == widget.selectedLessonId;

        if (widget.collapsed) {
          return CollapsedSidebarMenuTile(
            tooltipMessage: lesson.name,
            isSelected: isSelected,
            onTap: () {
              _saveOffset();
              widget.onLessonSelected(lesson.id);
            },
            child: Text(
              '${index + 1}',
              style: AppTextStyles.body2.copyWith(
                color: isSelected ? AppColors.neon : AppColors.grey200,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }

        return SidebarMenuTile(
          leading: SidebarMenuNumberBadge(
            index: index + 1,
            isSelected: isSelected,
          ),
          title: lesson.name,
          subtitle: lesson.topic.isEmpty ? null : lesson.topic,
          isSelected: isSelected,
          onTap: () {
            _saveOffset();
            widget.onLessonSelected(lesson.id);
          },
        );
      },
    );
  }
}

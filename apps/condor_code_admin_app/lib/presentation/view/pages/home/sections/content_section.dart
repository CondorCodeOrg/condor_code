import 'package:condorcode_admin/presentation/logic/courses/course_create_notifier/course_create_notifier.dart';
import 'package:condorcode_admin/presentation/logic/courses/courses_load_notifier/courses_load_notifier.dart';
import 'package:condorcode_admin/presentation/logic/lessons/course_lessons_provider.dart';
import 'package:condorcode_admin/presentation/logic/lessons/lesson_editor_notifier/lesson_editor_notifier.dart';
import 'package:condorcode_admin/presentation/logic/providers.dart';
import 'package:condorcode_admin/presentation/view/pages/home/sections/create_course_section.dart';
import 'package:condorcode_admin/presentation/view/pages/home/widgets/lesson_editor_view.dart';
import 'package:condorcode_admin/utilities/context_extensions.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:ui_kit/widgets/condor_code_network_image_view.dart';

class ContentSection extends ConsumerStatefulWidget {
  const ContentSection({super.key});

  @override
  ConsumerState<ContentSection> createState() => _ContentSectionState();
}

class _ContentSectionState extends ConsumerState<ContentSection> {
  _CourseView _view = _CourseView.courses;
  Course? _selectedCourse;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(coursesLoadProvider.notifier).loadCourses();
    });
  }

  void _openCourse(Course course) {
    ref.invalidate(courseLessonsProvider(course.id));
    setState(() {
      _selectedCourse = course;
      _view = _CourseView.details;
    });
  }

  void _backToCourses() {
    setState(() {
      _selectedCourse = null;
      _view = _CourseView.courses;
    });
  }

  void _backToDetails() {
    final c = _selectedCourse;
    if (c != null) {
      ref.invalidate(courseLessonsProvider(c.id));
    }
    ref.invalidate(lessonEditorProvider);
    setState(() {
      _view = _CourseView.details;
    });
  }

  void _openCreateLesson() {
    final course = _selectedCourse;
    if (course != null) {
      ref.read(lessonEditorProvider.notifier).startNew(course.id);
    }
    setState(() {
      _view = _CourseView.createLesson;
    });
  }

  Future<void> _openEditLesson(String lessonId) async {
    await ref.read(lessonEditorProvider.notifier).loadForEdit(lessonId);
    if (!mounted) return;
    setState(() {
      _view = _CourseView.createLesson;
    });
  }

  void _openCreateCourse() {
    setState(() {
      _view = _CourseView.createCourse;
    });
  }

  void _backFromCreateCourse() {
    setState(() {
      _view = _CourseView.courses;
    });
  }

  void _onCourseCreated(Course course) {
    ref.read(courseCreateProvider.notifier).reset();
    ref.read(coursesLoadProvider.notifier).loadCourses();
    setState(() {
      _selectedCourse = course;
      _view = _CourseView.details;
    });
  }

  void _onSelectedCourseLessonsChanged(int lessonsAmount) {
    final course = _selectedCourse;
    if (course == null) return;
    setState(() {
      _selectedCourse = course.copyWith(lessonsAmount: lessonsAmount);
    });
  }

  void _onSelectedCourseUpdated(Course updatedCourse) {
    setState(() {
      _selectedCourse = updatedCourse;
    });
  }

  void _onSelectedCourseDeleted() {
    ref.read(coursesLoadProvider.notifier).loadCourses();
    setState(() {
      _selectedCourse = null;
      _view = _CourseView.courses;
    });
  }

  @override
  Widget build(BuildContext context) {
    final course = _selectedCourse;
    final loadState = ref.watch(coursesLoadProvider);

    switch (_view) {
      case _CourseView.courses:
        return _CoursesGrid(
          courses: loadState.courses,
          isLoading: loadState.isLoading,
          errorMessage: loadState.hasError ? loadState.errorMessage : null,
          onRetry: () => ref.read(coursesLoadProvider.notifier).loadCourses(),
          onSelectCourse: _openCourse,
          onCreateCourse: _openCreateCourse,
        );
      case _CourseView.details:
        if (course == null) {
          return _CoursesGrid(
            courses: loadState.courses,
            isLoading: loadState.isLoading,
            errorMessage: loadState.hasError ? loadState.errorMessage : null,
            onRetry: () => ref.read(coursesLoadProvider.notifier).loadCourses(),
            onSelectCourse: _openCourse,
            onCreateCourse: _openCreateCourse,
          );
        }
        return _CourseDetails(
          course: course,
          onBack: _backToCourses,
          onCreateLesson: _openCreateLesson,
          onEditLesson: _openEditLesson,
          onCourseUpdated: _onSelectedCourseUpdated,
          onLessonsAmountChanged: _onSelectedCourseLessonsChanged,
          onCourseDeleted: _onSelectedCourseDeleted,
        );
      case _CourseView.createLesson:
        if (course == null) {
          return _CoursesGrid(
            courses: loadState.courses,
            isLoading: loadState.isLoading,
            errorMessage: loadState.hasError ? loadState.errorMessage : null,
            onRetry: () => ref.read(coursesLoadProvider.notifier).loadCourses(),
            onSelectCourse: _openCourse,
            onCreateCourse: _openCreateCourse,
          );
        }
        return LessonEditorView(course: course, onBack: _backToDetails);
      case _CourseView.createCourse:
        return CreateCourseSection(
          onBack: _backFromCreateCourse,
          onCourseCreated: _onCourseCreated,
        );
    }
  }
}

enum _CourseView { courses, details, createLesson, createCourse }

class _CoursesGrid extends StatelessWidget {
  const _CoursesGrid({
    required this.courses,
    required this.isLoading,
    required this.errorMessage,
    required this.onRetry,
    required this.onSelectCourse,
    required this.onCreateCourse,
  });

  final List<Course> courses;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onRetry;
  final ValueChanged<Course> onSelectCourse;
  final VoidCallback onCreateCourse;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.strings.coursesTitle,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: context.colors.textPrimary,
                ),
              ),
            ),
            IconButton(
              onPressed: isLoading ? null : onRetry,
              icon: const Icon(Icons.refresh),
              tooltip: context.strings.refreshCoursesList,
            ),
            ElevatedButton.icon(
              onPressed: onCreateCourse,
              icon: Icon(Icons.add, color: context.colors.accentForeground),
              label: Text(
                context.strings.createCourse,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ).copyWith(color: context.colors.accentForeground),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.accent,
                foregroundColor: context.colors.accentForeground,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          context.strings.coursesSubtitle,
          style: TextStyle(color: context.colors.textSecondary),
        ),
        const SizedBox(height: 16),
        if (errorMessage != null) ...[
          Material(
            color: context.colors.alert.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: context.colors.alert),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      errorMessage!,
                      style: TextStyle(color: context.colors.alert),
                    ),
                  ),
                  TextButton(
                    onPressed: onRetry,
                    child: Text(context.strings.retry),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        if (isLoading && courses.isEmpty && errorMessage == null)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 48),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (!isLoading && courses.isEmpty && errorMessage == null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Text(
              context.strings.coursesEmptyState(context.strings.createCourse),
              style: TextStyle(color: context.colors.textSecondary),
              textAlign: TextAlign.center,
            ),
          )
        else
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final crossAxisCount = width >= 960 ? 3 : (width >= 640 ? 2 : 1);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: courses.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) => _CourseCard(
                  course: courses[index],
                  onTap: () => onSelectCourse(courses[index]),
                ),
              );
            },
          ),
        if (isLoading && courses.isNotEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
      ],
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.course, required this.onTap});

  final Course course;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final imageUrl = course.imageUrl.trim();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colors.popupSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.colors.border),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: _CourseRemoteImage(
                  url: imageUrl,
                  fit: BoxFit.cover,
                  whenEmpty: ColoredBox(
                    color: context.colors.surface,
                    child: Icon(
                      Icons.school_outlined,
                      size: 40,
                      color: context.colors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              course.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.strings.openCourse,
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Network course cover: SVG vs raster, loading and error fallbacks (never a blank frame).
class _CourseRemoteImage extends StatelessWidget {
  const _CourseRemoteImage({
    required this.url,
    required this.fit,
    required this.whenEmpty,
    this.compactProgress = false,
  });

  final String url;
  final BoxFit fit;
  final Widget whenEmpty;
  final bool compactProgress;

  static bool _pathLooksLikeSvg(String rawUrl) {
    final uri = Uri.tryParse(rawUrl.trim());
    final path = uri != null && uri.path.isNotEmpty
        ? uri.path
        : rawUrl.trim().split('?').first.split('#').first;
    return path.toLowerCase().endsWith('.svg');
  }

  @override
  Widget build(BuildContext context) {
    final trimmed = url.trim();

    if (trimmed.isEmpty) return whenEmpty;

    if (_pathLooksLikeSvg(trimmed)) {
      return SvgPicture.network(
        trimmed,
        fit: fit,
        placeholderBuilder: (_) =>
            _RemoteImagePending(compact: compactProgress),
      );
    }

    return CCNetworkImageView(
      imageUrl: trimmed,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _RemoteImagePending(compact: compactProgress);
      },
      errorBuilder: (_, __, ___) => _RemoteImageError(compact: compactProgress),
    );
  }
}

class _RemoteImagePending extends StatelessWidget {
  const _RemoteImagePending({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 22.0 : 28.0;
    return ColoredBox(
      color: context.colors.surface,
      child: Center(
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: context.colors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _RemoteImageError extends StatelessWidget {
  const _RemoteImageError({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.surface,
      child: Icon(
        Icons.broken_image_outlined,
        size: compact ? 28 : 40,
        color: context.colors.textSecondary,
      ),
    );
  }
}

class _CourseDetails extends ConsumerStatefulWidget {
  const _CourseDetails({
    required this.course,
    required this.onBack,
    required this.onCreateLesson,
    required this.onEditLesson,
    required this.onCourseUpdated,
    required this.onLessonsAmountChanged,
    required this.onCourseDeleted,
  });

  final Course course;
  final VoidCallback onBack;
  final VoidCallback onCreateLesson;
  final Future<void> Function(String lessonId) onEditLesson;
  final ValueChanged<Course> onCourseUpdated;
  final ValueChanged<int> onLessonsAmountChanged;
  final VoidCallback onCourseDeleted;

  @override
  ConsumerState<_CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends ConsumerState<_CourseDetails> {
  final Set<String> _deletingLessonIds = <String>{};
  bool _isDeletingCourse = false;
  bool _isReorderingLessons = false;

  Future<void> _persistLessonOrder(List<Lesson> lessonsInOrder) async {
    if (_isReorderingLessons || lessonsInOrder.isEmpty) return;

    setState(() {
      _isReorderingLessons = true;
    });

    final ids = lessonsInOrder.map((l) => l.id).toList();
    final result = await ref
        .read(lessonsRepositoryProvider)
        .updateLessonsSortOrder(
          courseId: widget.course.id,
          lessonIdsOrdered: ids,
        );

    if (!mounted) return;

    setState(() {
      _isReorderingLessons = false;
    });

    if (result is ErrorResult<void>) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.message)));
      return;
    }

    ref.invalidate(courseLessonsProvider(widget.course.id));
  }

  void _onLessonsReordered(List<Lesson> lessons, int oldIndex, int newIndex) {
    if (_isReorderingLessons || _isDeletingCourse) return;
    var ni = newIndex;
    if (ni > oldIndex) ni -= 1;
    final next = List<Lesson>.from(lessons);
    final item = next.removeAt(oldIndex);
    next.insert(ni, item);
    _persistLessonOrder(next);
  }

  Future<void> _editCourseDetails() async {
    final nameController = TextEditingController(text: widget.course.name);
    final imageController = TextEditingController(text: widget.course.imageUrl);

    final result = await showDialog<({String name, String imageUrl})>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit course'),
        content: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Course title'),
                autofocus: true,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: imageController,
                decoration: const InputDecoration(labelText: 'Picture URL'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop((
                name: nameController.text.trim(),
                imageUrl: imageController.text.trim(),
              ));
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result == null || !mounted) return;
    if (result.name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Course title is required')));
      return;
    }

    final updateResult = await ref
        .read(coursesRepositoryProvider)
        .updateCourseDetails(
          courseId: widget.course.id,
          name: result.name,
          imageUrl: result.imageUrl,
        );
    if (!mounted) return;

    if (updateResult is ErrorResult<void>) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(updateResult.message)));
      return;
    }

    widget.onCourseUpdated(
      widget.course.copyWith(name: result.name, imageUrl: result.imageUrl),
    );
    ref.read(coursesLoadProvider.notifier).loadCourses();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Course updated')));
  }

  Future<bool> _confirmDelete({
    required String title,
    required String message,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.strings.removeItem),
          ),
        ],
      ),
    );
    return confirmed ?? false;
  }

  Future<void> _deleteLesson(Lesson lesson) async {
    final shouldDelete = await _confirmDelete(
      title: 'Delete lesson?',
      message:
          'This will remove the lesson with all linked tasks and questions.',
    );
    if (!shouldDelete || !mounted) return;

    setState(() {
      _deletingLessonIds.add(lesson.id);
    });

    final result = await ref
        .read(lessonsRepositoryProvider)
        .deleteLessonCascade(lesson.id);

    if (!mounted) return;
    setState(() {
      _deletingLessonIds.remove(lesson.id);
    });

    if (result is ErrorResult<void>) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.message)));
      return;
    }

    final nextAmount = widget.course.lessonsAmount > 0
        ? widget.course.lessonsAmount - 1
        : 0;
    widget.onLessonsAmountChanged(nextAmount);

    ref.invalidate(courseLessonsProvider(widget.course.id));
    ref.read(coursesLoadProvider.notifier).loadCourses();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Lesson removed')));
  }

  Future<void> _deleteCourse() async {
    final shouldDelete = await _confirmDelete(
      title: 'Delete course?',
      message:
          'This will remove the course with all lessons, tasks and questions.',
    );
    if (!shouldDelete || !mounted) return;

    setState(() {
      _isDeletingCourse = true;
    });

    final result = await ref
        .read(coursesRepositoryProvider)
        .deleteCourseCascade(widget.course.id);

    if (!mounted) return;
    setState(() {
      _isDeletingCourse = false;
    });

    if (result is ErrorResult<void>) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.message)));
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Course removed')));
    widget.onCourseDeleted();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.course.imageUrl.trim();
    final lessonsAsync = ref.watch(courseLessonsProvider(widget.course.id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: _isDeletingCourse ? null : widget.onBack,
              icon: const Icon(Icons.arrow_back),
            ),
            Expanded(
              child: Text(
                widget.course.name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: context.colors.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: _isDeletingCourse ? null : _editCourseDetails,
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Edit'),
            ),
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: _isDeletingCourse ? null : _deleteCourse,
              icon: _isDeletingCourse
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.delete_outline),
              label: Text(context.strings.removeItem),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _isDeletingCourse ? null : widget.onCreateLesson,
              icon: Icon(Icons.add, color: context.colors.accentForeground),
              label: Text(
                context.strings.createLesson,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ).copyWith(color: context.colors.accentForeground),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.accent,
                foregroundColor: context.colors.accentForeground,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _CourseImageThumb(imageUrl: imageUrl),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                imageUrl.isEmpty ? context.strings.noImageAdded : imageUrl,
                style: TextStyle(color: context.colors.textSecondary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Text(
                context.strings.lessonsTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: context.colors.textPrimary,
                ),
              ),
            ),
            IconButton(
              onPressed: _isDeletingCourse
                  ? null
                  : () =>
                        ref.invalidate(courseLessonsProvider(widget.course.id)),
              tooltip: context.strings.refreshLessons,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        const SizedBox(height: 12),
        lessonsAsync.when(
          skipLoadingOnReload: true,
          data: (lessons) {
            if (lessons.isEmpty) {
              return Text(
                context.strings.courseLessonsEmpty,
                style: TextStyle(color: context.colors.textSecondary),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_isReorderingLessons)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: LinearProgressIndicator(minHeight: 2),
                  ),
                Text(
                  context.strings.lessonReorderHint,
                  style: TextStyle(color: context.colors.textSecondary, fontSize: 13),
                ),
                const SizedBox(height: 12),
                ReorderableListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  buildDefaultDragHandles: false,
                  onReorder: _isDeletingCourse
                      ? (_, __) {}
                      : (oldIndex, newIndex) =>
                            _onLessonsReordered(lessons, oldIndex, newIndex),
                  children: [
                    for (var i = 0; i < lessons.length; i++)
                      KeyedSubtree(
                        key: ValueKey(lessons[i].id),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReorderableDragStartListener(
                                index: i,
                                enabled:
                                    !_isDeletingCourse && !_isReorderingLessons,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 4,
                                    top: 12,
                                  ),
                                  child: Icon(
                                    Icons.drag_handle,
                                    color: context.colors.textSecondary,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: _CourseLessonTile(
                                  lesson: lessons[i],
                                  isDeleting: _deletingLessonIds.contains(
                                    lessons[i].id,
                                  ),
                                  onEdit: _isDeletingCourse
                                      ? null
                                      : () =>
                                            widget.onEditLesson(lessons[i].id),
                                  onDelete: _isDeletingCourse
                                      ? null
                                      : () => _deleteLesson(lessons[i]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.strings.courseLessonsLoadError,
                style: TextStyle(color: context.colors.alert),
              ),
              const SizedBox(height: 8),
              Text(
                '$e',
                style: TextStyle(color: context.colors.textSecondary, fontSize: 12),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () =>
                    ref.invalidate(courseLessonsProvider(widget.course.id)),
                icon: const Icon(Icons.refresh),
                label: Text(context.strings.refreshLessons),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CourseImageThumb extends StatelessWidget {
  const _CourseImageThumb({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl.trim();
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 72,
        height: 72,
        child: _CourseRemoteImage(
          url: url,
          fit: BoxFit.cover,
          whenEmpty: _placeholder(context),
          compactProgress: true,
        ),
      ),
    );
  }

  Widget _placeholder(BuildContext context) => Container(
    color: context.colors.surface,
    alignment: Alignment.center,
    child: Icon(Icons.image_outlined, color: context.colors.textSecondary),
  );
}

class _CourseLessonTile extends StatelessWidget {
  const _CourseLessonTile({
    required this.lesson,
    required this.isDeleting,
    required this.onEdit,
    required this.onDelete,
  });

  final Lesson lesson;
  final bool isDeleting;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final topic = lesson.topic.trim();

    return Material(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      lesson.title.isEmpty ? '—' : lesson.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: context.colors.textPrimary,
                      ),
                    ),
                  ),
                  if (lesson.isYouTubeLesson)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.ondemand_video_outlined,
                        size: 20,
                        color: context.colors.textSecondary,
                      ),
                    ),
                  IconButton(
                    onPressed: isDeleting ? null : onEdit,
                    tooltip: 'Edit lesson',
                    icon: const Icon(Icons.edit_outlined, size: 20),
                  ),
                  IconButton(
                    onPressed: isDeleting ? null : onDelete,
                    tooltip: context.strings.removeItem,
                    icon: isDeleting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.delete_outline, size: 20),
                  ),
                ],
              ),
              if (topic.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  context.strings.lessonCardTopic(topic),
                  style: TextStyle(color: context.colors.textSecondary, fontSize: 14),
                ),
              ],
              if (lesson.description.trim().isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  lesson.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: context.colors.textSecondary, fontSize: 13),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

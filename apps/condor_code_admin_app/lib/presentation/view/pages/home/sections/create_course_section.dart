import 'package:condorcode_admin/presentation/logic/courses/course_create_notifier/course_create_notifier.dart';
import 'package:condorcode_admin/presentation/view/common/widgets/text_field.dart';
import 'package:condorcode_admin/presentation/view/pages/home/widgets/section_card.dart';
import 'package:condorcode_admin/utilities/context_extensions.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateCourseSection extends ConsumerStatefulWidget {
  const CreateCourseSection({
    required this.onBack,
    this.onCourseCreated,
    super.key,
  });

  final VoidCallback onBack;
  final ValueChanged<Course>? onCourseCreated;

  @override
  ConsumerState<CreateCourseSection> createState() =>
      _CreateCourseSectionState();
}

class _CreateCourseSectionState extends ConsumerState<CreateCourseSection> {
  late final TextEditingController _nameController;
  late final TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _imageUrlController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(courseCreateProvider.notifier).reset();
    });

    _nameController.addListener(
      () => ref
          .read(courseCreateProvider.notifier)
          .updateName(_nameController.text),
    );
    _imageUrlController.addListener(
      () => ref
          .read(courseCreateProvider.notifier)
          .updateImageUrl(_imageUrlController.text),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(courseCreateProvider);
    final notifier = ref.read(courseCreateProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: widget.onBack,
              icon: const Icon(Icons.arrow_back),
            ),
            Expanded(
              child: Text(
                context.strings.createCourseTitle,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          context.strings.createCourseHint,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        SectionCard(
          title: context.strings.createCourse,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: _nameController,
                label: context.strings.courseNameLabel,
                errorText: state.nameError ? state.nameErrorMessage : null,
                icon: Icons.title,
              ),
              CustomTextField(
                controller: _imageUrlController,
                label: context.strings.courseImageUrlLabel,
                icon: Icons.image_outlined,
                keyboardType: TextInputType.url,
              ),
              if (state.hasErrorMessage) ...[
                const SizedBox(height: 8),
                Text(
                  state.commonErrorMessage ?? '',
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ],
              if (state.successMessage?.isNotEmpty == true) ...[
                const SizedBox(height: 8),
                Text(
                  state.successMessage ?? '',
                  style: const TextStyle(color: Colors.green),
                ),
              ],
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.isProcessing
                      ? null
                      : () async {
                          final created = await notifier.saveCourse();
                          if (!context.mounted) return;
                          if (created != null) {
                            widget.onCourseCreated?.call(created);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: state.isProcessing
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          context.strings.saveCourse,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

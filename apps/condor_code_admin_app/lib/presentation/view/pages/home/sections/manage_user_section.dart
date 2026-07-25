import 'package:condorcode_admin/presentation/logic/users/tester_requests_notifier/tester_requests_notifier.dart';
import 'package:condorcode_admin/presentation/view/pages/home/widgets/section_card.dart';
import 'package:condorcode_admin/utilities/context_extensions.dart';
import 'package:domain/models/tester_access_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ui_kit/ui_kit.dart';

class ManageUserSection extends ConsumerStatefulWidget {
  const ManageUserSection({super.key});

  @override
  ConsumerState<ManageUserSection> createState() => _ManageUserSectionState();
}

class _ManageUserSectionState extends ConsumerState<ManageUserSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(testerRequestsProvider.notifier).loadRequests(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(testerRequestsProvider);
    final notifier = ref.read(testerRequestsProvider.notifier);
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.strings.usersTitle,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: context.colors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          context.strings.usersSubtitle,
          style: TextStyle(color: context.colors.textSecondary),
        ),
        const SizedBox(height: 16),
        SectionCard(
          title: context.strings.testerRequestsTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.strings.testerRequestsSubtitle,
                style: TextStyle(color: context.colors.textSecondary),
              ),
              const SizedBox(height: 16),
              if (state.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (state.errorMessage != null)
                Text(
                  state.errorMessage!,
                  style: TextStyle(color: context.colors.alert),
                )
              else if (state.requests.isEmpty)
                Text(
                  context.strings.testerRequestsEmpty,
                  style: TextStyle(color: context.colors.textSecondary),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.requests.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final request = state.requests[index];
                    return _TesterRequestTile(
                      request: request,
                      dateFormat: dateFormat,
                      isProcessing: state.isProcessing,
                      onApprove: () => notifier.approve(request),
                      onReject: () => notifier.reject(request),
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TesterRequestTile extends StatelessWidget {
  const _TesterRequestTile({
    required this.request,
    required this.dateFormat,
    required this.isProcessing,
    required this.onApprove,
    required this.onReject,
  });

  final TesterAccessRequest request;
  final DateFormat dateFormat;
  final bool isProcessing;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    final createdAt = request.createdAt != null
        ? dateFormat.format(request.createdAt!.toLocal())
        : '—';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            request.email,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            '${context.strings.testerRequestsCreatedAt}: $createdAt',
            style: TextStyle(color: context.colors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: isProcessing ? null : onApprove,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.accent,
                    foregroundColor: context.colors.accentForeground,
                  ),
                  child: Text(context.strings.testerRequestsApprove),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: isProcessing ? null : onReject,
                  child: Text(context.strings.testerRequestsReject),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

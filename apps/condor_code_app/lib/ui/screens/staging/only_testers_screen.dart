import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/screens/staging/only_testers_cubit/only_testers_cubit.dart';
import 'package:condor_code/ui/screens/staging/only_testers_cubit/only_testers_state.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/snack_bar/snack_bar_producer_widget.dart';
import 'package:condor_code/ui/widgets/top_navigation_bar.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';

class OnlyTestersScreen extends StatelessWidget {
  const OnlyTestersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<OnlyTestersCubit>(),
      child: const _OnlyTestersBody(),
    );
  }
}

class _OnlyTestersBody extends StatelessWidget {
  const _OnlyTestersBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey800,
      body: SafeArea(
        child: SnackBarProducerWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TopNavigationBar(
                text: localization.onlyTestersTitle,
                isLeading: false,
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 16,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: BlocBuilder<OnlyTestersCubit, OnlyTestersState>(
                        builder: (context, state) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 24),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: AppColors.neon.withValues(
                                      alpha: 0.12,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: AppColors.neon.withValues(
                                        alpha: 0.35,
                                      ),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.lock_outline_rounded,
                                    color: AppColors.neon,
                                    size: 48,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 28),
                              Text(
                                localization.onlyTestersBody,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.body1.copyWith(
                                  color: AppColors.grey200,
                                  height: 1.45,
                                ),
                              ),
                              if (state.hasPendingRequest) ...[
                                const SizedBox(height: 16),
                                Text(
                                  localization.onlyTestersRequestPendingHint,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.body2.copyWith(
                                    color: AppColors.neon,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 28),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed:
                                      state.isLoading ||
                                          state.isSubmitting ||
                                          state.hasPendingRequest
                                      ? null
                                      : () => context
                                            .read<OnlyTestersCubit>()
                                            .requestTesterAccess(),
                                  style: AppButtonStyles.mainButtonStyle,
                                  child: state.isSubmitting
                                      ? const SizedBox(
                                          height: 22,
                                          width: 22,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.white,
                                          ),
                                        )
                                      : Text(
                                          state.hasPendingRequest
                                              ? localization
                                                    .onlyTestersRequestPendingButton
                                              : localization
                                                    .onlyTestersRequestAccessButton,
                                        ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: state.isSubmitting
                                      ? null
                                      : () async {
                                          await di<AuthRepository>().logout();
                                        },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.white,
                                    side: const BorderSide(
                                      color: AppColors.grey400,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                  ),
                                  child: Text(localization.knowledgeBaseLogout),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

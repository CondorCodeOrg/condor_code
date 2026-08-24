import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/screens/auth/auth_cubit/auth_cubit.dart';
import 'package:condor_code/ui/screens/auth/auth_cubit/auth_state.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/snack_bar/snack_bar_producer_widget.dart';
import 'package:condor_code/ui/widgets/top_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  static const double _formMaxWidth = 400;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration(String label) {
    final radius = BorderRadius.circular(12);
    return InputDecoration(
      labelText: label,
      labelStyle: AppTextStyles.body2.copyWith(
        color: context.colors.textSecondary,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(
          color: context.colors.border.withValues(alpha: 0.45),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: context.colors.accent),
      ),
      filled: true,
      fillColor: context.colors.surface.withValues(alpha: 0.35),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback onToggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: AppTextStyles.body1.copyWith(color: context.colors.textPrimary),
      decoration: _fieldDecoration(label).copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: context.colors.textSecondary,
          ),
          onPressed: onToggleVisibility,
        ),
      ),
    );
  }

  void _submit(AuthCubit cubit, AuthState state) {
    if (state.isSignUpMode) {
      cubit.signUpWithEmail(
        fullName: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );
      return;
    }
    cubit.signInWithEmail(_emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: di<AuthCubit>(),
      child: Scaffold(
        backgroundColor: context.colors.scaffoldBackground,
        body: SafeArea(
          child: SnackBarProducerWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (prev, next) =>
                      prev.isSignUpMode != next.isSignUpMode,
                  builder: (context, state) {
                    final title = state.isSignUpMode
                        ? localization.registration
                        : localization.signInTitle;
                    return TopNavigationBar(text: title, isLeading: false);
                  },
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 24,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: _formMaxWidth,
                        ),
                        child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            final cubit = context.read<AuthCubit>();
                            final subtitle = state.isSignUpMode
                                ? localization.signUpSubtitle
                                : localization.signInSubtitle;
                            final primaryLabel = state.isSignUpMode
                                ? localization.signUpButton
                                : localization.signInButton;
                            final switchLabel = state.isSignUpMode
                                ? localization.switchToSignIn
                                : localization.switchToSignUp;

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  subtitle,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.body1.copyWith(
                                    color: context.colors.textSecondary,
                                    height: 1.45,
                                  ),
                                ),
                                const SizedBox(height: 28),
                                if (state.isSignUpMode) ...[
                                  TextField(
                                    controller: _nameController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    autocorrect: false,
                                    style: AppTextStyles.body1.copyWith(
                                      color: context.colors.textPrimary,
                                    ),
                                    decoration: _fieldDecoration(
                                      localization.signUpNameLabel,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                ],
                                TextField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  style: AppTextStyles.body1.copyWith(
                                    color: context.colors.textPrimary,
                                  ),
                                  decoration: _fieldDecoration(
                                    localization.signInEmailLabel,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                _passwordField(
                                  controller: _passwordController,
                                  label: localization.signInPasswordLabel,
                                  obscure: _obscurePassword,
                                  onToggleVisibility: () => setState(
                                    () => _obscurePassword = !_obscurePassword,
                                  ),
                                ),
                                if (state.isSignUpMode) ...[
                                  const SizedBox(height: 14),
                                  _passwordField(
                                    controller: _confirmPasswordController,
                                    label:
                                        localization.signUpConfirmPasswordLabel,
                                    obscure: _obscureConfirmPassword,
                                    onToggleVisibility: () => setState(
                                      () => _obscureConfirmPassword =
                                          !_obscureConfirmPassword,
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: state.isSubmitting
                                        ? null
                                        : () => _submit(cubit, state),
                                    style: AppButtonStyles.mainButtonStyle(
                                      context,
                                    ),
                                    child: state.isSubmitting
                                        ? SizedBox(
                                            height: 22,
                                            width: 22,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: context.colors.textPrimary,
                                            ),
                                          )
                                        : Text(primaryLabel),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    onPressed: state.isSubmitting
                                        ? null
                                        : cubit.signInWithGoogle,
                                    icon: Icon(
                                      Icons.g_mobiledata,
                                      color: context.colors.textPrimary,
                                      size: 28,
                                    ),
                                    label: Text(
                                      localization.signInWithGoogle,
                                      style: AppTextStyles.body2.copyWith(
                                        color: context.colors.textPrimary,
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      side: BorderSide(
                                        color: context.colors.border.withValues(
                                          alpha: 0.45,
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextButton(
                                  onPressed: state.isSubmitting
                                      ? null
                                      : () => cubit.setSignUpMode(
                                          !state.isSignUpMode,
                                        ),
                                  child: Text(
                                    switchLabel,
                                    style: AppTextStyles.body2.copyWith(
                                      color: context.colors.accent,
                                    ),
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
      ),
    );
  }
}

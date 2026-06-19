import 'package:condorcode_admin/presentation/logic/auth/sign_up_notifier/sign_up_notifier.dart';
import 'package:condorcode_admin/presentation/router/router.dart';
import 'package:condorcode_admin/presentation/view/common/widgets/admin_theme_toggle_button.dart';
import 'package:condorcode_admin/presentation/view/common/widgets/text_field.dart';
import 'package:condorcode_admin/utilities/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_kit/ui_kit.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _emailController.addListener(
      () =>
          ref.read(signUpProvider.notifier).updateEmail(_emailController.text),
    );
    _usernameController.addListener(
      () => ref
          .read(signUpProvider.notifier)
          .updateUsername(_usernameController.text),
    );
    _passwordController.addListener(
      () => ref
          .read(signUpProvider.notifier)
          .updatePassword(_passwordController.text),
    );
    _confirmPasswordController.addListener(
      () => ref
          .read(signUpProvider.notifier)
          .updateConfirmPassword(_confirmPasswordController.text),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpProvider);
    final notifier = ref.read(signUpProvider.notifier);

    return Scaffold(
      backgroundColor: context.colors.scaffoldBackground,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      context.strings.createAccount,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: context.colors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.strings.enterDataToAccessAdmin,
                      style: TextStyle(color: context.colors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    CustomTextField(
                      controller: _usernameController,
                      label: context.strings.username,
                      errorText: state.usernameError
                          ? state.usernameErrorMessage
                          : null,
                      icon: Icons.person_outline,
                    ),
                    CustomTextField(
                      controller: _emailController,
                      label: context.strings.email,
                      errorText: state.emailError ? state.emailErrorMessage : null,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      label: context.strings.password,
                      isPassword: true,
                      isVisible: state.isPasswordVisible,
                      toggleVisibility: notifier.togglePasswordVisibility,
                      errorText: state.passwordError
                          ? state.passwordErrorMessage
                          : null,
                      icon: Icons.lock_outline,
                    ),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      label: context.strings.confirmPassword,
                      isPassword: true,
                      isVisible: state.isConfirmPasswordVisible,
                      toggleVisibility: notifier.toggleConfirmedPasswordVisibility,
                      errorText: state.confirmPasswordError
                          ? state.confirmPasswordErrorMessage
                          : null,
                      icon: Icons.lock_reset,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: state.isProcessing
                          ? null
                          : () async {
                              await notifier.signUp();
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colors.accent,
                        foregroundColor: context.colors.accentForeground,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: state.isProcessing
                          ? const SizedBox(
                              height: 22,
                              width: 128,
                              child: Skeleton(
                                name: CondorHollowSkeletonIds.authSubmitButton,
                                loading: true,
                                color: Colors.white24,
                                highlightColor: Colors.white70,
                                child: SizedBox.shrink(),
                              ),
                            )
                          : Text(
                              context.strings.signUp,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.strings.alreadyHaveAnAccount),
                        TextButton(
                          onPressed: () {
                            const LoginRoute().push(context);
                          },
                          child: Text(context.strings.signIn),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            top: 8,
            right: 8,
            child: AdminThemeToggleButton(),
          ),
        ],
      ),
    );
  }
}

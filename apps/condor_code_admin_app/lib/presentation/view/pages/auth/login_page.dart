import 'package:condorcode_admin/config/app_config.dart';
import 'package:condorcode_admin/di/provider_manager.dart';
import 'package:condorcode_admin/presentation/logic/auth/login_email_notifier/login_with_email_notifier.dart';
import 'package:condorcode_admin/presentation/logic/auth/social_auth_notifier/social_auth_notifier.dart';
import 'package:condorcode_admin/presentation/router/router.dart';
import 'package:condorcode_admin/presentation/view/common/widgets/text_field.dart';
import 'package:condorcode_admin/utilities/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_kit/ui_kit.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.addListener(
      () => ref
          .read(loginWithEmailProvider.notifier)
          .updateEmail(_emailController.text),
    );
    _passwordController.addListener(
      () => ref
          .read(loginWithEmailProvider.notifier)
          .updatePassword(_passwordController.text),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginWithEmailProvider);
    final notifier = ref.read(loginWithEmailProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.darkGrey800,
            child: AppLogo(label: _getLogoLabel()),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.admin_panel_settings,
                      size: 64,
                      color: Colors.lightGreenAccent,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      context.strings.enterDataToAccessAdmin,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    CustomTextField(
                      controller: _emailController,
                      label: context.strings.email,
                      errorText: state.emailError
                          ? state.emailErrorMessage
                          : null,
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
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: state.isProcessing
                          ? null
                          : () async {
                              await notifier.signIn();
                              if (context.mounted) {
                                const HomeRoute().go(context);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreenAccent,
                        foregroundColor: Colors.white,
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
                              context.strings.signIn,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            context.strings.or,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: state.isProcessing
                          ? null
                          : () async {
                              await ref
                                  .read(socialAuthProvider.notifier)
                                  .continueWithGoogle();
                              if (context.mounted) {
                                const HomeRoute().go(context);
                              }
                            },
                      icon: const Icon(Icons.g_mobiledata, size: 30),
                      label: Text(
                        context.strings.signInWithGoogle,
                        style: const TextStyle(fontSize: 16),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Colors.black12),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.strings.noAccountYet),
                        TextButton(
                          onPressed: () {
                            const SignUpRoute().push(context);
                          },
                          child: Text(context.strings.signUp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppLogoLabel _getLogoLabel() => switch (di<AppConfig>().buildType) {
    BuildType.dev => AppLogoLabel.dev,
    BuildType.staging => AppLogoLabel.staging,
    BuildType.prod => AppLogoLabel.prod,
  };
}

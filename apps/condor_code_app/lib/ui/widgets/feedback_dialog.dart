import 'dart:io';

import 'package:condor_code/ui/l10n/app_localizations.dart';
import 'package:condor_code/ui/screens/feedback/feedback_cubit.dart';
import 'package:condor_code/ui/screens/feedback/feedback_state.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:domain/models/feedback_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({super.key});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showEmailField = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthStatus();
    });
  }

  Future<void> _checkAuthStatus() async {
    final user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    setState(() {
      _showEmailField = user == null;
    });
  }

  Future<void> _submitFeedback() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<FeedbackCubit>();
    final user = FirebaseAuth.instance.currentUser;

    final platform = await _getPlatform();
    final deviceInfo = await _getDeviceInfo();

    if (!mounted) return;

    final feedback = FeedbackModel(
      id: '',
      message: _messageController.text,
      userId: user?.uid,
      email: _showEmailField ? _emailController.text : null,
      timestamp: DateTime.now(),
      platform: platform,
      deviceInfo: deviceInfo,
    );

    cubit.submitFeedback(feedback);
  }

  Future<String> _getPlatform() async {
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    if (Platform.isLinux) return 'linux';
    if (Platform.isMacOS) return 'macos';
    if (Platform.isWindows) return 'windows';
    return 'unknown';
  }

  Future<String?> _getDeviceInfo() async {
    try {
      final deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final android = await deviceInfo.androidInfo;
        return 'Android ${android.version.release} | ${android.model} | ${android.manufacturer}';
      }

      if (Platform.isIOS) {
        final ios = await deviceInfo.iosInfo;
        return 'iOS ${ios.systemVersion} | ${ios.model}';
      }

      if (Platform.isLinux) {
        final linux = await deviceInfo.linuxInfo;
        return 'Linux | ${linux.name}';
      }

      if (Platform.isMacOS) {
        final mac = await deviceInfo.macOsInfo;
        return 'macOS ${mac.osRelease} | ${mac.model}';
      }

      if (Platform.isWindows) {
        final win = await deviceInfo.windowsInfo;
        return 'Windows | ${win.productName}';
      }

      return 'unknown';
    } catch (_) {
      return 'unavailable';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<FeedbackCubit, FeedbackState>(
      listener: (context, state) {
        if (state.success) {
          Navigator.pop(context);
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.feedbackTitle,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _messageController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: l10n.feedbackLabel,
                    hintText: l10n.feedbackHint,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.feedbackRequired;
                    }
                    if (value.length < 10) {
                      return l10n.feedbackMinLength;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                if (_showEmailField) ...[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: l10n.feedbackEmailLabel,
                      hintText: l10n.feedbackEmailHint,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return l10n.feedbackInvalidEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                ],
                BlocBuilder<FeedbackCubit, FeedbackState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(l10n.feedbackCancel),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: state.isSubmitting
                              ? null
                              : _submitFeedback,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.neon,
                            foregroundColor: AppColors.darkGrey800,
                            minimumSize: const Size(120, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: state.isSubmitting
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.darkGrey800,
                                  ),
                                )
                              : Text(l10n.feedbackSubmit),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

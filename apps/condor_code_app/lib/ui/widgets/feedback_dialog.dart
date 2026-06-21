import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:domain/models/feedback_model.dart';
import 'package:domain/repository/feedback_repository.dart';
import 'package:condor_code/di/provider_manager.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({super.key});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
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

    setState(() => _isSubmitting = true);

    try {
      final user = FirebaseAuth.instance.currentUser;

      final feedback = FeedbackModel(
        id: '',
        message: _messageController.text,
        userId: user?.uid,
        email: _showEmailField ? _emailController.text : null,
        timestamp: DateTime.now(),
        platform: await _getPlatform(),
        deviceInfo: await _getDeviceInfo(),
      );

      // Get repository from DI
      final repository = di<FeedbackRepository>();
      final success = await repository.submitFeedback(feedback);

      // Track analytics event
      await FirebaseAnalytics.instance.logEvent(
        name: 'feedback_submitted',
        parameters: {
          'success': success,
          'has_email': (_showEmailField && _emailController.text.isNotEmpty),
          'is_authenticated': user != null,
          'message_length': _messageController.text.length,
        },
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Дякуємо за ваш відгук! 🙏'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Помилка при надсиланні. Спробуйте ще раз.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Помилка: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  Future<String> _getPlatform() async {
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    if (Platform.isLinux) return 'linux';
    if (Platform.isMacOS) return 'macos';
    if (Platform.isWindows) return 'windows';
    return 'unknown';
  }

  // Future<String?> _getDeviceInfo() async {
  //   // TODO: Implement with device_info_plus package
  //   return null;
  // }

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
    return Dialog(
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
                    'Залишити відгук',
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
                decoration: const InputDecoration(
                  labelText: 'Ваш відгук *',
                  hintText: 'Розкажіть нам про ваш досвід...',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка, введіть ваш відгук';
                  }
                  if (value.length < 10) {
                    return 'Відгук повинен містити щонайменше 10 символів';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (_showEmailField) ...[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email (необов\'язково)',
                    hintText: 'example@email.com',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Введіть коректний email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.white,
                    ),
                    child: const Text('Скасувати'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitFeedback,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.neon,
                      foregroundColor: AppColors.darkGrey800,
                      minimumSize: const Size(120, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.darkGrey800,
                            ),
                          )
                        : const Text('Надіслати'),
                  ),
                ],
              ),
            ],
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

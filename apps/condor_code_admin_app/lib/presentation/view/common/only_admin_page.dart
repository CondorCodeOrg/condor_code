import 'package:condorcode_admin/presentation/logic/auth/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:condorcode_admin/utilities/context_extensions.dart';
import 'package:ui_kit/ui_kit.dart';

class OnlyAdminPage extends ConsumerStatefulWidget {
  const OnlyAdminPage({super.key});

  @override
  ConsumerState createState() => _OnlyAdminPageState();
}

class _OnlyAdminPageState extends ConsumerState<OnlyAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBackground,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.strings.sorryOnlyAdminCanAccess,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
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
                child: Text(context.strings.logout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

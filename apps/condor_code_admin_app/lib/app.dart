import 'dart:async';

import 'package:condorcode_admin/presentation/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_kit/theme/fade_only_page_transitions.dart';

import 'package:condorcode_admin/generated/l10n/l10n.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with WidgetsBindingObserver {
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //TODO: (WeakDroid) Implement user auth state changes and navigate accordingly
      // _streamSubscription = getIt<UserRepository>().userExistStream.listen((exists) {
      //   if (!exists && mounted) {
      //     ref.read(AppRouter.routerProvider).go(const SecretPinRoute().location);
      //   }
      // });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routerConfig = ref.watch(AppRouter.routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(pageTransitionsTheme: fadeOnlyPageTransitionsTheme()),
      routerConfig: routerConfig,
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) => child ?? const SizedBox.shrink(),
    );
  }
}

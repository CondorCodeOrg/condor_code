import 'package:condor_code/config/app_config.dart';
import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/l10n/app_localizations.dart';
import 'package:condor_code/ui/navigation/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ui_kit/ui_kit.dart'
    show AppColors, fadeOnlyPageTransitionsTheme;

class CondorCodeApp extends StatefulWidget {
  final AppConfig config;

  const CondorCodeApp({super.key, required this.config});

  @override
  State<CondorCodeApp> createState() => _CondorCodeAppState();
}

class _CondorCodeAppState extends State<CondorCodeApp> {
  @override
  void initState() {
    super.initState();

    switch (widget.config.buildType) {
      case BuildType.dev:
        di<Analytics>().setUserProperty(name: 'environment', value: 'dev');
      case BuildType.staging:
        di<Analytics>().setUserProperty(name: 'environment', value: 'prod');
      case BuildType.prod:
        di<Analytics>().setUserProperty(name: 'environment', value: 'staging');
    }

    _setPortraitOrientation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: const Locale('uk'),
      supportedLocales: const [Locale('uk')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.neon,
          brightness: Brightness.dark,
        ),
        pageTransitionsTheme: fadeOnlyPageTransitionsTheme(),
      ),
      routerConfig: getRouter(widget.config),
    );
  }

  void _setPortraitOrientation() {
    if (kIsWeb) return;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }
}

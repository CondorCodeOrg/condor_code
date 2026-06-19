import 'package:condor_code/config/app_config.dart';
import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/l10n/app_localizations.dart';
import 'package:condor_code/ui/navigation/go_router.dart';
import 'package:condor_code/ui/theme/theme_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

class CondorCodeApp extends StatefulWidget {
  final AppConfig config;

  const CondorCodeApp({super.key, required this.config});

  @override
  State<CondorCodeApp> createState() => _CondorCodeAppState();
}

class _CondorCodeAppState extends State<CondorCodeApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = getRouter(widget.config);

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
    return BlocProvider.value(
      value: di<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            locale: const Locale('uk'),
            supportedLocales: const [Locale('uk')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: buildCondorTheme(Brightness.light),
            darkTheme: buildCondorTheme(Brightness.dark),
            themeMode: themeMode,
            themeAnimationDuration: const Duration(milliseconds: 300),
            themeAnimationCurve: Curves.easeInOut,
            routerConfig: _router,
          );
        },
      ),
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

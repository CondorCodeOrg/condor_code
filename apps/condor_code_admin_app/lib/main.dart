import 'package:condorcode_admin/app.dart';
import 'package:condorcode_admin/config/app_config.dart';
import 'package:condorcode_admin/config/firebase/firebase_options_dev.dart'
    as fb_dev;
import 'package:condorcode_admin/config/firebase/firebase_options_prod.dart'
    as fb_prod;
import 'package:condorcode_admin/config/firebase/firebase_options_stg.dart'
    as fb_staging;
import 'package:condorcode_admin/di/provider_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;

  const buildType = String.fromEnvironment('BUILD_TYPE', defaultValue: 'dev');
  const dataSource = String.fromEnvironment(
    'DATA_SOURCE',
    defaultValue: 'mock',
  );

  registerCondorHollowBones();
  usePathUrlStrategy();

  final config = AppConfig(
    buildType: BuildType.values.byName(buildType),
    dataSource: DataSource.values.byName(dataSource),
  );

  if (config.dataSource == DataSource.remote) {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(options: _getFirebaseOptions(config));
    }
  }

  final providerManager = ProviderManager();
  providerManager.configureDependencies(config);

  runApp(const ProviderScope(child: App()));
}

FirebaseOptions _getFirebaseOptions(AppConfig config) {
  switch (config.buildType) {
    case BuildType.dev:
      return fb_dev.DefaultFirebaseOptions.currentPlatform;
    case BuildType.staging:
      return fb_staging.DefaultFirebaseOptions.currentPlatform;
    case BuildType.prod:
      return fb_prod.DefaultFirebaseOptions.currentPlatform;
  }
}

import 'package:condorcode_admin/config/app_config.dart';
import 'package:data/data.dart' as data;
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:ui_kit/locale/locale_service.dart';
import 'package:ui_kit/theme/theme_mode_service.dart';

final di = GetIt.instance;

class ProviderManager {
  /// Configures dependencies in the provided [GetIt] instance.
  Future<void> configureDependencies(AppConfig config) async {
    di.registerSingleton<AppConfig>(config);
    await _registerDataModule(di, config);
    _registerServices(di);
  }

  void _registerServices(GetIt di) {
    di.registerLazySingleton<ThemeModeService>(
      () => ThemeModeService(di<ThemeModeRepository>()),
    );
    di.registerLazySingleton<LocaleService>(
      () => LocaleService(di<LocaleRepository>()),
    );
  }

  Future<void> _registerDataModule(GetIt di, AppConfig config) async {
    await data.DataModule.init(di, switch (config.dataSource) {
      DataSource.mock => data.DataSource.mock,
      DataSource.remote => data.DataSource.remote,
    });
  }
}

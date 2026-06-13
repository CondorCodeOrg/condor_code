import 'package:condorcode_admin/config/app_config.dart';
import 'package:data/data.dart' as data;
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

class ProviderManager {
  /// Configures dependencies in the provided [GetIt] instance.
  Future<void> configureDependencies(AppConfig config) async {
    await _registerDataModule(di, config);
  }

  Future<void> _registerDataModule(GetIt di, AppConfig config) async {
    await data.DataModule.init(di, switch (config.dataSource) {
      DataSource.mock => data.DataSource.mock,
      DataSource.remote => data.DataSource.remote,
    });
  }
}

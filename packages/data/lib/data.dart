import 'package:data/di/di.dart';
import 'package:get_it/get_it.dart';

class DataModule {
  static Future<void> init(GetIt di, DataSource dataSource) async {
    await initDI(di, dataSource);
  }
}

enum DataSource { remote, mock }

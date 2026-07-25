import 'package:domain/data_result/data_result.dart';
import 'package:domain/models/enums/app_locale.dart';

abstract class LocaleRepository {
  /// Returns null when the user has not chosen a language yet.
  Future<DataResult<AppLocale?>> getLocale();

  Future<DataResult<void>> saveLocale(AppLocale locale);
}

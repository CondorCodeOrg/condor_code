import 'package:data/data_sources/shared_pref/shared_preferences_manager.dart';
import 'package:domain/data_result/data_result.dart';
import 'package:domain/data_result/safe_data_call.dart';
import 'package:domain/models/enums/app_locale.dart';
import 'package:domain/repository/locale_repository.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  LocaleRepositoryImpl(this._sharedPreferencesManager);

  final SharedPreferencesManager _sharedPreferencesManager;

  @override
  Future<DataResult<AppLocale?>> getLocale() async {
    return await safeDataCall(
      dataCall: () async =>
          await _sharedPreferencesManager.getLocaleLanguageCode(),
      processResult: (code) =>
          SuccessResult<AppLocale?>(AppLocale.tryParse(code)),
    );
  }

  @override
  Future<DataResult<void>> saveLocale(AppLocale locale) async {
    return await safeDataCall(
      dataCall: () =>
          _sharedPreferencesManager.saveLocaleLanguageCode(locale.languageCode),
      processResult: (_) => SuccessResult(null),
    );
  }
}

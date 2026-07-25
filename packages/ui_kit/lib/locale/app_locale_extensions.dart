import 'package:domain/models/enums/app_locale.dart';
import 'package:flutter/material.dart';

extension AppLocaleX on AppLocale {
  Locale get toFlutter => Locale(languageCode);
}

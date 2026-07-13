import 'package:domain/models/enums/theme_mode.dart' as domain;
import 'package:flutter/material.dart' as material;

extension DomainThemeModeX on domain.ThemeMode {
  material.ThemeMode get toMaterial => switch (this) {
    domain.ThemeMode.light => material.ThemeMode.light,
    domain.ThemeMode.dark => material.ThemeMode.dark,
  };
}

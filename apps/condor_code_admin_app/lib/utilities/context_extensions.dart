import 'package:flutter/material.dart';

import 'package:condorcode_admin/generated/l10n/l10n.dart';

extension ContextExtensions on BuildContext {
  //TODO: (WeakDroid) Implement theme extensions for typography, colors, and elevated button styles if needed
  // TypographyTheme get typographyTheme => TypographyTheme.of(this);
  //
  // ColorTheme get colorTheme => ColorTheme.of(this);
  //
  // ElevatedButtonStyles get elevatedButtonStyles => ElevatedButtonStyles.of(this);

  EdgeInsets get paddingOf => MediaQuery.paddingOf(this);

  Size get sizeOf => MediaQuery.sizeOf(this);

  double get widthOf => sizeOf.width;

  double get heightOf => sizeOf.height;

  S get strings => S.of(this);
}

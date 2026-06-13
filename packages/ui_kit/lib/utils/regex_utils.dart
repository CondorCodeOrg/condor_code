mixin RegExpUtils {
  static final email = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+$',
  );
  static final atLeastOneNumber = RegExp('^(?=.*[0-9])');
  static final atLeastOneSymbol = RegExp(r'^(?=.*[!@#$&*~])');
}

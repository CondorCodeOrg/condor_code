import 'package:syntax_highlight/syntax_highlight.dart';

class UiKitInit {
  static bool _initialized = false;
  static late HighlighterTheme theme;

  static Future<void> ensureInitialized() async {
    if (_initialized) return;

    await Highlighter.initialize(['dart']);

    theme = await HighlighterTheme.loadDarkTheme();

    _initialized = true;
  }
}

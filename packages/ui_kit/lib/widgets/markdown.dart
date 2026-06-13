import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:syntax_highlight/syntax_highlight.dart';
import 'package:ui_kit/styles/colors/app_colors.dart';
import 'package:ui_kit/styles/text_styles/app_text_styles.dart';
import 'package:ui_kit/init/ui_kit_init.dart';
import 'package:flutter/services.dart';

class Markdown extends StatelessWidget {
  final String data;

  const Markdown({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _MarkdownInit.ensure(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox();
        }

        return MarkdownBody(
          data: data,
          selectable: true,
          builders: {'code': _CodeBlockBuilder(context: context)},
          styleSheet: MarkdownStyleSheet(
            p: AppTextStyles.body1.copyWith(color: AppColors.white),

            h1: AppTextStyles.h1.copyWith(color: AppColors.white, fontSize: 26),

            h2: AppTextStyles.h2.copyWith(color: AppColors.white, fontSize: 22),

            h3: AppTextStyles.body2.copyWith(
              color: AppColors.white,
              fontSize: 18,
            ),

            a: AppTextStyles.body1.copyWith(
              color: AppColors.neon,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.neon,
            ),

            code: AppTextStyles.code,

            codeblockPadding: const EdgeInsets.all(12),
            codeblockDecoration: BoxDecoration(
              color: AppColors.grey600,
              borderRadius: BorderRadius.circular(14),
            ),

            blockquote: AppTextStyles.body3.copyWith(color: AppColors.grey200),

            listBullet: AppTextStyles.body1.copyWith(color: AppColors.white),
          ),
        );
      },
    );
  }
}

class _AppSyntaxHighlighter extends SyntaxHighlighter {
  late final Highlighter _highlighter;

  _AppSyntaxHighlighter() {
    _highlighter = Highlighter(language: 'dart', theme: UiKitInit.theme);
  }

  @override
  TextSpan format(String source) {
    return _highlighter.highlight(source);
  }
}

class _MarkdownInit {
  static bool _initialized = false;

  static Future<void> ensure() async {
    if (_initialized) return;

    await UiKitInit.ensureInitialized();

    _initialized = true;
  }
}

class _CodeBlockBuilder extends MarkdownElementBuilder {
  final BuildContext context;

  _CodeBlockBuilder({required this.context});

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final code = element.textContent;
    final className = element.attributes['class'] ?? '';
    final isConsole = className.contains('language-console');

    if (isConsole) {
      return _ConsoleBlock(code: code);
    }
    return _DartBlock(code: code, context: context);
  }
}

class _DartBlock extends StatelessWidget {
  const _DartBlock({required this.code, required this.context});

  final String code;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.grey600,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 12, top: 36),
            child: SelectableText.rich(_AppSyntaxHighlighter().format(code)),
          ),
          Positioned(
            top: -1.4,
            right: 1,
            child: IconButton(
              icon: const Icon(Icons.copy, size: 16, color: AppColors.white),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: code));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Center(
                        child: Text(
                          'Скопійовано',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      backgroundColor: AppColors.grey800,
                      behavior: SnackBarBehavior.floating,
                      elevation: 0,
                      duration: const Duration(milliseconds: 1500),
                      width: MediaQuery.of(context).size.width / 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ConsoleBlock extends StatelessWidget {
  final String code;

  const _ConsoleBlock({required this.code});

  @override
  Widget build(BuildContext context) {
    final lines = code.split('\n');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.consoleColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines.map((line) {
          final isUser = line.startsWith('[user]');

          if (isUser) {
            final text = line
                .replaceAll('[user]', '')
                .replaceAll('[/user]', '');

            return Text(
              text,
              style: AppTextStyles.console.copyWith(
                color: AppColors.consoleUserColor,
              ),
            );
          }

          return Text(line, style: AppTextStyles.console);
        }).toList(),
      ),
    );
  }
}

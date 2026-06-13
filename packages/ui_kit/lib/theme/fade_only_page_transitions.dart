import 'package:flutter/material.dart';

/// [PageTransitionsBuilder] that applies only a fade (no slide / zoom).
///
/// Use with [ThemeData.pageTransitionsTheme] so default [MaterialPage],
/// [MaterialPageRoute], and similar routes follow the same behavior on every
/// platform (including Android’s usual horizontal slide).
class FadeOnlyPageTransitionsBuilder extends PageTransitionsBuilder {
  const FadeOnlyPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      ),
      child: child,
    );
  }
}

/// Every [TargetPlatform] uses fade-only page transitions.
PageTransitionsTheme fadeOnlyPageTransitionsTheme() {
  return PageTransitionsTheme(
    builders: {
      for (final platform in TargetPlatform.values)
        platform: const FadeOnlyPageTransitionsBuilder(),
    },
  );
}

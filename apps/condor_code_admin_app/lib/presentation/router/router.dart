import 'dart:async';
import 'dart:math' as math;

import 'package:condorcode_admin/presentation/logic/providers.dart';
import 'package:condorcode_admin/presentation/logic/user/current_user_provider.dart';
import 'package:condorcode_admin/presentation/view/common/only_admin_page.dart';
import 'package:condorcode_admin/presentation/view/pages/auth/login_page.dart';
import 'package:condorcode_admin/presentation/view/pages/auth/sign_up_page.dart';
import 'package:condorcode_admin/presentation/view/pages/error_page.dart';
import 'package:condorcode_admin/presentation/view/pages/home/home_page.dart';
import 'package:condorcode_admin/presentation/view/pages/lesson/lesson_detail_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';

final appRouterRefreshProvider = Provider<GoRouterRefreshNotifier>((ref) {
  final notifier = GoRouterRefreshNotifier(ref);
  ref.onDispose(notifier.dispose);
  return notifier;
});

class GoRouterRefreshNotifier extends ChangeNotifier {
  GoRouterRefreshNotifier(this._ref) {
    _authSubscription = _ref
        .read(authRepositoryProvider)
        .authStateChanges
        .listen((_) {
          notifyListeners();
        });
    _ref.listen(isAdminProvider, (_, __) => notifyListeners());
    notifyListeners();
  }

  final Ref _ref;
  late final StreamSubscription<dynamic> _authSubscription;

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }
}

mixin AppRouter {
  /// Navigator keys
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final authRoutes = [SignUpRoute.path, LoginRoute.path];
  static final routerProvider = Provider<GoRouter>((ref) {
    final refresh = ref.watch(appRouterRefreshProvider);

    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: const LoginRoute().location,
      debugLogDiagnostics: kDebugMode,
      routes: $appRoutes,

      refreshListenable: refresh,

      redirect: (context, state) {
        final container = ProviderScope.containerOf(context);
        final user = container.read(currentUserProvider);
        final isAdminAsync = container.read(isAdminProvider);
        final isAuthenticated = user != null;
        final isAuthRoute = authRoutes.contains(state.matchedLocation);

        if (!isAuthenticated) {
          return isAuthRoute ? null : const LoginRoute().location;
        }

        if (isAdminAsync.isLoading || isAdminAsync.hasError) {
          return null;
        }

        final isAdmin = isAdminAsync.requireValue;

        if (!isAdmin) {
          if (state.matchedLocation == const OnlyAdminRoute().location) {
            return null;
          }
          return const OnlyAdminRoute().location;
        }

        if (isAdmin && isAuthRoute) {
          return const HomeRoute().location;
        }

        return null;
      },
      errorPageBuilder: (context, state) =>
          buildPageUnconstrained(key: state.pageKey, child: const ErrorPage()),
    );
  });

  // Keep 1366px as the min width for this web app
  static Page<T> buildShellPage<T>({
    required ValueKey key,
    required Widget child,
  }) {
    final scrollController = ScrollController();
    return CustomTransitionPage<T>(
      key: key,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      child: LayoutBuilder(
        builder: (context, constraints) => Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                width: math.max(1366, constraints.maxWidth),
              ),
              child: child,
            ),
          ),
        ),
      ),
      maintainState: false,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

  // Use this when route is adaptive for any screen size
  static Page<T> buildNestedPage<T>({
    required ValueKey key,
    required Widget child,
  }) => CustomTransitionPage<T>(
    key: key,
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
    child: child,
    maintainState: false,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );

  // Use this when route is adaptive for any screen size
  static Page<T> buildPageUnconstrained<T>({
    required ValueKey key,
    required Widget child,
  }) => CustomTransitionPage<T>(
    key: key,
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
    child: child,
    maintainState: false,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

@TypedGoRoute<HomeRoute>(path: HomeRoute.path, name: HomeRoute.name)
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  static const name = 'home';
  static const path = '/home';

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppRouter.buildShellPage(
        key: state.pageKey,
        child: build(context, state),
      );
}

@TypedGoRoute<SignUpRoute>(path: SignUpRoute.path, name: SignUpRoute.name)
class SignUpRoute extends GoRouteData with $SignUpRoute {
  const SignUpRoute();

  static const name = 'sign_up';
  static const path = '/sign-up';

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignUpPage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppRouter.buildShellPage(
        key: state.pageKey,
        child: build(context, state),
      );
}

@TypedGoRoute<LoginRoute>(path: LoginRoute.path, name: LoginRoute.name)
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  static const name = 'login';
  static const path = '/login';

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginPage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppRouter.buildShellPage(
        key: state.pageKey,
        child: build(context, state),
      );
}

@TypedGoRoute<OnlyAdminRoute>(
  path: OnlyAdminRoute.path,
  name: OnlyAdminRoute.name,
)
class OnlyAdminRoute extends GoRouteData with $OnlyAdminRoute {
  const OnlyAdminRoute();

  static const name = 'only_admin';
  static const path = '/only-admin';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnlyAdminPage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppRouter.buildShellPage(
        key: state.pageKey,
        child: build(context, state),
      );
}

@TypedGoRoute<LessonDetailRoute>(
  path: LessonDetailRoute.path,
  name: LessonDetailRoute.name,
)
class LessonDetailRoute extends GoRouteData with $LessonDetailRoute {
  const LessonDetailRoute({required this.courseId, required this.lessonId});

  static const name = 'lesson_detail';
  static const path = '/lesson/:courseId/:lessonId';

  final String courseId;
  final String lessonId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      LessonDetailPage(courseId: courseId, lessonId: lessonId);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppRouter.buildShellPage(
        key: state.pageKey,
        child: build(context, state),
      );
}

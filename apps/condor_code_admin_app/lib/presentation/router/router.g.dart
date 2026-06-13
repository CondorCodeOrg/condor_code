// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $homeRoute,
  $signUpRoute,
  $loginRoute,
  $onlyAdminRoute,
  $lessonDetailRoute,
];

RouteBase get $homeRoute => GoRouteData.$route(
  path: '/home',
  name: 'home',
  factory: $HomeRoute._fromState,
);

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signUpRoute => GoRouteData.$route(
  path: '/sign-up',
  name: 'sign_up',
  factory: $SignUpRoute._fromState,
);

mixin $SignUpRoute on GoRouteData {
  static SignUpRoute _fromState(GoRouterState state) => const SignUpRoute();

  @override
  String get location => GoRouteData.$location('/sign-up');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
  path: '/login',
  name: 'login',
  factory: $LoginRoute._fromState,
);

mixin $LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location('/login');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onlyAdminRoute => GoRouteData.$route(
  path: '/only-admin',
  name: 'only_admin',
  factory: $OnlyAdminRoute._fromState,
);

mixin $OnlyAdminRoute on GoRouteData {
  static OnlyAdminRoute _fromState(GoRouterState state) =>
      const OnlyAdminRoute();

  @override
  String get location => GoRouteData.$location('/only-admin');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $lessonDetailRoute => GoRouteData.$route(
  path: '/lesson/:courseId/:lessonId',
  name: 'lesson_detail',
  factory: $LessonDetailRoute._fromState,
);

mixin $LessonDetailRoute on GoRouteData {
  static LessonDetailRoute _fromState(GoRouterState state) => LessonDetailRoute(
    courseId: state.pathParameters['courseId']!,
    lessonId: state.pathParameters['lessonId']!,
  );

  LessonDetailRoute get _self => this as LessonDetailRoute;

  @override
  String get location => GoRouteData.$location(
    '/lesson/${Uri.encodeComponent(_self.courseId)}/${Uri.encodeComponent(_self.lessonId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

import 'package:condorcode_admin/di/provider_manager.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/courses_repository.dart';
import 'package:domain/repository/lessons_repository.dart';
import 'package:domain/repository/tester_access_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return di<AuthRepository>();
});

final lessonsRepositoryProvider = Provider<LessonsRepository>((ref) {
  return di<LessonsRepository>();
});

final coursesRepositoryProvider = Provider<CoursesRepository>((ref) {
  return di<CoursesRepository>();
});

final testerAccessRepositoryProvider = Provider<TesterAccessRepository>((ref) {
  return di<TesterAccessRepository>();
});

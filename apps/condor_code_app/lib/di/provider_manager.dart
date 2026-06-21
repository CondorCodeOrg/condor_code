import 'package:condor_code/config/app_config.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/firebase/firebase_analytics_impl.dart';
import 'package:condor_code/ui/analytics/mock/mock_analytics_impl.dart';
import 'package:condor_code/ui/analytics/provider/analytics_events_provider.dart';
import 'package:condor_code/ui/analytics/provider/analytics_events_provider_impl.dart';
import 'package:condor_code/ui/base/provider/events/snack_bar_events_provider.dart';
import 'package:condor_code/ui/navigation/staging_gate_notifier.dart';
import 'package:condor_code/ui/screens/contacts/contacts_cubit/contacts_cubit.dart';
import 'package:condor_code/ui/screens/course/course_cubit/course_cubit.dart';
import 'package:condor_code/ui/screens/courses/courses_cubit/courses_cubit.dart';
import 'package:condor_code/ui/screens/knowledge_base/knowledge_base_cubit/knowledge_base_home_cubit.dart';
import 'package:condor_code/ui/screens/knowledge_base/roadmap/cubit/knowledge_base_roadmap_cubit.dart';
import 'package:condor_code/ui/screens/knowledge_check/knowledge_check_cubit/knowledge_check_cubit.dart';
import 'package:condor_code/ui/screens/lesson/bloc/lesson_cubit.dart';
import 'package:condor_code/ui/screens/lesson/bloc/questions/questions_bloc.dart';
import 'package:condor_code/ui/screens/lesson/provider/lesson_screen_events_provider.dart';
import 'package:condor_code/ui/screens/lesson_details/lesson_details_cubit/lesson_details_cubit.dart';
import 'package:condor_code/ui/screens/lessons_list/lessons_list_cubit/lessons_list_cubit.dart';
import 'package:condor_code/ui/screens/main/bloc/bottom_navigation_cubit.dart';
import 'package:condor_code/ui/screens/main/bloc/snack_bar_cubit.dart';
import 'package:condor_code/ui/screens/staging/only_testers_cubit/only_testers_cubit.dart';
import 'package:condor_code/ui/screens/staging/staging_auth_cubit/staging_auth_cubit.dart';
import 'package:condor_code/ui/screens/task_answer/task_answer_cubit/task_answer_cubit.dart';
import 'package:condor_code/ui/screens/task_details/task_details_cubit/task_details_cubit.dart';
import 'package:condor_code/ui/screens/tasks_list/tasks_list_cubit/tasks_list_cubit.dart';
import 'package:data/data.dart' as data;
import 'package:domain/domain.dart';
import 'package:domain/repository/feedback_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:data/data_sources/remote/feedback_remote_data_source.dart';
import 'package:data/repository/feedback_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final di = GetIt.instance;

class ProviderManager {
  /// Configures dependencies in the provided [GetIt] instance.
  Future<void> configureDependencies(AppConfig config) async {
    di.registerSingleton<AppConfig>(config);
    _registerAnalytics(di, config);
    await _registerDataModule(di, config);
    _registerProviders(di, config);
    _registerBlocs(di);
  }

  void _registerProviders(GetIt di, AppConfig config) {
    di.registerLazySingleton<StagingGateNotifier>(
      () => StagingGateNotifier(di<AuthRepository>(), di<Analytics>(), config),
    );
    di.registerLazySingleton<SnackBarEventsProvider>(
      () => SnackBarEventsProvider(),
    );
    di.registerLazySingleton<LessonScreenEventsProvider>(
      () => LessonScreenEventsProvider(),
    );
    di.registerLazySingleton<AnalyticsEventsProvider>(
      () => AnalyticsEventsProviderImpl(di()),
    );

    if (!di.isRegistered<FirebaseFirestore>()) {
      di.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance,
      );
    }

    // Register Feedback Remote Data Source
    di.registerLazySingleton<FeedbackRemoteDataSource>(
      () => FeedbackRemoteDataSource(di<FirebaseFirestore>()),
    );

    // Register Feedback Repository
    di.registerLazySingleton<FeedbackRepository>(
      () => FeedbackRepositoryImpl(di<FeedbackRemoteDataSource>()),
    );
  }

  void _registerBlocs(GetIt di) {
    di.registerFactory<BottomNavigationCubit>(() => BottomNavigationCubit());
    di.registerFactoryParam<QuestionsBloc, String, dynamic>(
      (lessonId, _) => QuestionsBloc(
        lessonId: lessonId,
        questionRepository: di<QuestionRepository>(),
        lessonScreenEventsProvider: di<LessonScreenEventsProvider>(),
        snackBarEventsProvider: di<SnackBarEventsProvider>(),
      ),
    );
    di.registerFactory<LessonCubit>(
      () => LessonCubit(
        lessonScreenEventsProvider: di<LessonScreenEventsProvider>(),
        snackBarEventsProvider: di<SnackBarEventsProvider>(),
      ),
    );
    di.registerFactory<ContactsCubit>(
      () => ContactsCubit(snackBarEventsProvider: di()),
    );
    di.registerFactoryParam<CourseCubit, String, String?>(
      (courseId, initialLessonId) => CourseCubit(
        courseId: courseId,
        lessonsRepository: di(),
        tasksRepository: di(),
        snackBarEventsProvider: di(),
        initialLessonId: initialLessonId,
      ),
    );
    di.registerFactoryParam<LessonDetailsCubit, String, dynamic>(
      (lessonId, _) => LessonDetailsCubit(
        lessonsRepository: di(),
        snackBarEventsProvider: di(),
        lessonId: lessonId,
        tasksRepository: di(),
      ),
    );
    di.registerFactoryParam<TaskDetailsCubit, String, dynamic>(
      (taskId, _) => TaskDetailsCubit(
        taskId: taskId,
        snackBarEventsProvider: di(),
        tasksRepository: di(),
      ),
    );
    di.registerFactoryParam<TaskAnswerCubit, Answer, dynamic>(
      (answer, _) =>
          TaskAnswerCubit(snackBarEventsProvider: di(), answer: answer),
    );
    di.registerFactoryParam<LessonsListCubit, String, dynamic>(
      (courseId, _) => LessonsListCubit(
        lessonsRepository: di(),
        snackBarEventsProvider: di(),
        courseId: courseId,
      ),
    );
    di.registerFactoryParam<TasksListCubit, String, dynamic>(
      (lessonId, _) => TasksListCubit(
        tasksRepository: di(),
        snackBarEventsProvider: di(),
        lessonId: lessonId,
      ),
    );
    di.registerFactoryParam<KnowledgeCheckCubit, String, String?>(
      (lessonId, initialTaskId) => KnowledgeCheckCubit(
        lessonId: lessonId,
        tasksRepository: di(),
        snackBarEventsProvider: di(),
        initialTaskId: initialTaskId,
      ),
    );
    di.registerLazySingleton<StagingAuthCubit>(
      () => StagingAuthCubit(
        authRepository: di(),
        sharedPreferencesManager: di(),
        snackBarEventsProvider: di(),
        analytics: di(),
      ),
    );
    di.registerFactory<OnlyTestersCubit>(
      () => OnlyTestersCubit(
        testerAccessRepository: di(),
        snackBarEventsProvider: di(),
      ),
    );
    di.registerFactory<CoursesCubit>(
      () => CoursesCubit(
        coursesRepository: di(),
        lessonsRepository: di(),
        snackBarEventsProvider: di(),
      ),
    );
    di.registerFactory<KnowledgeBaseHomeCubit>(
      () => KnowledgeBaseHomeCubit(
        knowledgeBaseRepository: di(),
        snackBarEventsProvider: di(),
      ),
    );
    di.registerFactory<KnowledgeBaseRoadmapCubit>(
      () => KnowledgeBaseRoadmapCubit(
        knowledgeBaseRepository: di(),
        snackBarEventsProvider: di(),
      ),
    );
    di.registerSingleton(SnackBarCubit(di()));
  }

  void _registerAnalytics(GetIt di, AppConfig config) {
    di.registerLazySingleton<Analytics>(
      () => switch (config.dataSource) {
        DataSource.mock => MockAnalyticsImpl(),
        DataSource.remote => switch (config.buildType) {
          BuildType.dev => MockAnalyticsImpl(),
          BuildType.staging => FirebaseAnalyticsImpl(),
          BuildType.prod => FirebaseAnalyticsImpl(),
        },
      },
    );
  }

  Future<void> _registerDataModule(GetIt di, AppConfig config) async {
    await data.DataModule.init(di, switch (config.dataSource) {
      DataSource.mock => data.DataSource.mock,
      DataSource.remote => data.DataSource.remote,
    });
  }
}

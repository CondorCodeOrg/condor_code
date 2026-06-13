import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/data.dart';
import 'package:data/data_sources/remote/manager/mock_remote_data_manager.dart';
import 'package:data/data_sources/remote/manager/remote_data_manager.dart';
import 'package:data/data_sources/remote/manager/remote_data_manager_impl.dart';
import 'package:data/data_sources/shared_pref/shared_preferences_manager.dart';
import 'package:data/data_sources/shared_pref/shared_preferences_manager_impl.dart';
import 'package:data/repository/auth_repository_impl.dart';
import 'package:data/repository/courses_repository_impl.dart';
import 'package:data/repository/knowledge_base_repository_impl.dart';
import 'package:data/repository/lessons_repository_impl.dart';
import 'package:data/repository/profile_repository_impl.dart';
import 'package:data/repository/question_repository_impl.dart';
import 'package:data/repository/tasks_repository_impl.dart';
import 'package:data/repository/tester_access_repository_impl.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> initDI(GetIt di, DataSource dataSource) async {
  _registerDao(di, dataSource);
  _registerRepositories(di);
}

void _registerDao(GetIt di, DataSource dataSource) {
  di.registerLazySingleton<SharedPreferencesManager>(
    () => SharedPreferencesManagerImpl(),
  );

  switch (dataSource) {
    case DataSource.remote:
      final firebaseApp = Firebase.app();

      di.registerLazySingleton<RemoteDataManager>(
        () => RemoteDataManagerImpl(
          auth: FirebaseAuth.instanceFor(app: firebaseApp),
          fireStore: FirebaseFirestore.instanceFor(app: firebaseApp),
          googleSignIn: GoogleSignIn(),
        ),
      );
    case DataSource.mock:
      di.registerLazySingleton<RemoteDataManager>(
        () => MockRemoteDataManager(),
      );
  }
}

void _registerRepositories(GetIt di) {
  di.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl());
  di.registerLazySingleton<LessonsRepository>(
    () => LessonsRepositoryImpl(remoteDataManager: di()),
  );
  di.registerLazySingleton<CoursesRepository>(
    () => CoursesRepositoryImpl(remoteDataManager: di()),
  );
  di.registerLazySingleton<TasksRepository>(
    () => TasksRepositoryImpl(remoteDataManager: di()),
  );
  di.registerLazySingleton<QuestionRepository>(
    () => QuestionsRepositoryImpl(remoteDataManager: di()),
  );
  di.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(di()));
  di.registerLazySingleton<TesterAccessRepository>(
    () => TesterAccessRepositoryImpl(di()),
  );
  di.registerLazySingleton<KnowledgeBaseRepository>(
    () => KnowledgeBaseRepositoryImpl(remoteDataManager: di()),
  );
}

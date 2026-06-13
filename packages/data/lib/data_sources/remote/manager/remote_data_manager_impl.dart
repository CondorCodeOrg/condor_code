import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/data_sources/remote/database_constants.dart';
import 'package:data/data_sources/remote/manager/remote_data_manager.dart';
import 'package:data/data_sources/remote/models/course_remote.dart';
import 'package:data/data_sources/remote/models/lesson_bundle_remote.dart';
import 'package:data/data_sources/remote/models/lesson_remote.dart';
import 'package:data/data_sources/remote/models/question_remote.dart';
import 'package:data/data_sources/remote/models/task_remote.dart';
import 'package:data/data_sources/remote/models/tester_access_request_remote.dart';
import 'package:data/data_sources/remote/models/user_remote.dart';
import 'package:data/data_sources/remote/remote_document_parsers.dart';
import 'package:domain/models/knowledge_base_news_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class RemoteDataManagerImpl implements RemoteDataManager {
  final FirebaseAuth _auth;
  final FirebaseFirestore _fireStore;
  final GoogleSignIn _googleSignIn;

  RemoteDataManagerImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore fireStore,
    required GoogleSignIn googleSignIn,
  }) : _auth = auth,
       _fireStore = fireStore,
       _googleSignIn = googleSignIn;

  @override
  UserRemote? get currentUser {
    final user = _auth.currentUser;
    if (user == null) return null;
    return UserRemote(
      id: user.uid,
      fullName: user.displayName ?? '',
      email: user.email ?? '',
      role: 'user',
    );
  }

  @override
  Stream<UserRemote?> get authStateChanges =>
      _auth.authStateChanges().map((user) {
        if (user == null) return null;
        return UserRemote(
          id: user.uid,
          fullName: user.displayName ?? '',
          email: user.email ?? '',
          role: 'user',
        );
      });

  @override
  bool get isUserExist => currentUser != null;

  @override
  String get currentUserId {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  //Fetch user role from Firestore based on UID
  @override
  Future<String?> getUserRole(String uid) async {
    final doc = await _fireStore
        .collection(DatabaseCollections.users)
        .doc(uid)
        .get();
    return doc.data()?['role'] as String?;
  }

  @override
  bool get isEmailPasswordAuth {
    final user = _auth.currentUser;
    return user?.providerData.any((p) => p.providerId == 'password') ?? false;
  }

  @override
  Future<UserRemote> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = userCredential.user;
    if (user == null) throw Exception('User creation failed');

    final userData = {
      'fullName': '',
      'email': email.trim(),
      'role': 'user',
      'createdAt': FieldValue.serverTimestamp(),
    };

    await _fireStore
        .collection(DatabaseCollections.users)
        .doc(user.uid)
        .set(userData);

    return UserRemote(
      id: user.uid,
      fullName: userData['fullName'] as String,
      email: userData['email'] as String,
      role: userData['role'] as String,
    );
  }

  @override
  Future<void> createUserProfile({
    required String uid,
    required String username,
    required String email,
  }) async {
    final userRef = _fireStore.collection(DatabaseCollections.users).doc(uid);
    await userRef.set({
      'fullName': username,
      'email': email,
      'role': 'user',
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  @override
  Future<UserRemote> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = userCredential.user;
    if (user == null) throw Exception('User not authenticated');

    final snapshot = await _fireStore
        .collection(DatabaseCollections.users)
        .doc(user.uid)
        .get();

    final userData = snapshot.data();
    final String roleFromDb = userData?['role'] ?? 'user';

    return UserRemote(
      id: user.uid,
      fullName: user.displayName ?? '',
      email: user.email ?? '',
      role: roleFromDb,
    );
  }

  @override
  Future<UserRemote?> signInWithGoogle() async {
    final credential = await _getCredentialWithGoogle();
    if (credential == null) return null;

    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user;

    if (user == null) return null;

    final userDoc = _fireStore
        .collection(DatabaseCollections.users)
        .doc(user.uid);
    final snapshot = await userDoc.get();

    String role = 'user';

    if (!snapshot.exists) {
      await userDoc.set({
        'fullName': user.displayName ?? '',
        'email': user.email ?? '',
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } else {
      role = snapshot.data()?['role'] ?? 'user';
    }

    return UserRemote(
      id: user.uid,
      fullName: user.displayName ?? '',
      email: user.email ?? '',
      role: role,
    );
  }

  Future<OAuthCredential?> _getCredentialWithGoogle() async {
    await _googleSignIn.signOut();
    final googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      Logger.print(data: 'Google Sign In cancelled by user.');
      return null;
    }

    final googleAuth = await googleUser.authentication;

    return GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    Logger.print(
      data: 'User logged out successfully',
      from: 'RemoteDataSource.logout',
    );
  }

  @override
  Future<LessonRemote> saveLesson(LessonRemote lesson) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final bool isNew = lesson.id.isEmpty;
    var lessonToSave = lesson;
    if (isNew && lesson.courseId.trim().isNotEmpty) {
      final sortOrder = await _allocateSortOrderForNewLessonInCourse(
        lesson.courseId,
      );
      lessonToSave = lesson.copyWith(sortOrder: sortOrder);
    }

    final docRef = isNew
        ? _fireStore.collection(DatabaseCollections.lessons).doc()
        : _fireStore
              .collection(DatabaseCollections.lessons)
              .doc(lessonToSave.id);
    final Map<String, dynamic> data = lessonToSave.toJson();
    data['id'] = docRef.id;

    if (isNew) {
      data['createdAt'] = FieldValue.serverTimestamp();
      final batch = _fireStore.batch();
      batch.set(docRef, data);
      if (lesson.courseId.isNotEmpty) {
        final courseRef = _fireStore
            .collection(DatabaseCollections.courses)
            .doc(lesson.courseId);
        batch.update(courseRef, {'lessonsAmount': FieldValue.increment(1)});
      }
      await batch.commit();
    } else {
      await docRef.set(data, SetOptions(merge: true));
    }
    return lessonToSave.copyWith(id: docRef.id);
  }

  @override
  Future<List<LessonRemote>> fetchLessonsForCourse(String courseId) async {
    final snapshot = await _fireStore
        .collection(DatabaseCollections.lessons)
        .where('courseId', isEqualTo: courseId)
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return RemoteDocumentParsers.lessonFromFirestoreData(
        Map<String, dynamic>.from(data),
        doc.id,
      );
    }).toList();
  }

  /// Обчислює [LessonRemote.sortOrder] для **щойно створеного** урока в курсі.
  ///
  /// З клієнта зазвичай приходить дефолт `0`. Якщо записати його як є, усі нові
  /// уроки матимуть однаковий порядок і не стануть однозначно сортуватися.
  /// Тому підвантажуємо вже збережені уроки цього курсу й ставимо новому
  /// значення **на кінець**: `max(sortOrder серед сусідів) + 1`.
  /// Якщо у курсі ще немає уроків, повертається `0`.
  Future<int> _allocateSortOrderForNewLessonInCourse(String courseId) async {
    final normalized = courseId.trim();
    if (normalized.isEmpty) return 0;

    final siblings = await fetchLessonsForCourse(normalized);
    final maxExistingOrder = siblings.fold<int>(
      -1,
      (max, lesson) => lesson.sortOrder > max ? lesson.sortOrder : max,
    );
    return maxExistingOrder + 1;
  }

  @override
  Future<LessonRemote> fetchLesson(String lessonId) async {
    final doc = await _fireStore
        .collection(DatabaseCollections.lessons)
        .doc(lessonId)
        .get();
    if (!doc.exists || doc.data() == null) {
      throw Exception('Lesson not found');
    }
    return RemoteDocumentParsers.lessonFromFirestoreData(
      Map<String, dynamic>.from(doc.data()!),
      doc.id,
    );
  }

  @override
  Future<List<TaskRemote>> fetchTasksForLesson(String lessonId) async {
    final snapshot = await _fireStore
        .collection(DatabaseCollections.tasks)
        .where('lessonId', isEqualTo: lessonId)
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return RemoteDocumentParsers.taskFromFirestoreData(
        Map<String, dynamic>.from(data),
        doc.id,
      );
    }).toList();
  }

  @override
  Future<TaskRemote> fetchTask(String taskId) async {
    final doc = await _fireStore
        .collection(DatabaseCollections.tasks)
        .doc(taskId)
        .get();
    if (!doc.exists || doc.data() == null) {
      throw Exception('Task not found');
    }
    return RemoteDocumentParsers.taskFromFirestoreData(
      Map<String, dynamic>.from(doc.data()!),
      doc.id,
    );
  }

  @override
  Future<List<QuestionRemote>> fetchQuestionsForLesson(String lessonId) async {
    final snapshot = await _fireStore
        .collection(DatabaseCollections.questions)
        .where('lessonId', isEqualTo: lessonId)
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return RemoteDocumentParsers.questionFromFirestoreData(
        Map<String, dynamic>.from(data),
        doc.id,
      );
    }).toList();
  }

  @override
  Future<void> deleteLessonCascade(String lessonId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final normalizedLessonId = lessonId.trim();
    if (normalizedLessonId.isEmpty) {
      throw ArgumentError('lessonId is empty');
    }

    final lessonRef = _fireStore
        .collection(DatabaseCollections.lessons)
        .doc(normalizedLessonId);
    final lessonSnapshot = await lessonRef.get();
    if (!lessonSnapshot.exists) {
      return;
    }

    final lessonData = lessonSnapshot.data() ?? <String, dynamic>{};
    final lessonCourseId = (lessonData['courseId'] as String?)?.trim() ?? '';

    final linkedCollections = await Future.wait([
      _fireStore
          .collection(DatabaseCollections.tasks)
          .where('lessonId', isEqualTo: normalizedLessonId)
          .get(),
      _fireStore
          .collection(DatabaseCollections.questions)
          .where('lessonId', isEqualTo: normalizedLessonId)
          .get(),
    ]);

    final taskSnapshot = linkedCollections[0];
    final questionSnapshot = linkedCollections[1];

    final batch = _fireStore.batch();
    batch.delete(lessonRef);
    for (final task in taskSnapshot.docs) {
      batch.delete(task.reference);
    }
    for (final question in questionSnapshot.docs) {
      batch.delete(question.reference);
    }

    if (lessonCourseId.isNotEmpty) {
      final courseRef = _fireStore
          .collection(DatabaseCollections.courses)
          .doc(lessonCourseId);
      batch.update(courseRef, {'lessonsAmount': FieldValue.increment(-1)});
    }

    await batch.commit();
  }

  /// See [RemoteDataManager.saveLessonBundle] for id semantics and return shape.
  @override
  Future<LessonBundleRemote> saveLessonBundle({
    required LessonRemote lesson,
    required List<TaskRemote> tasks,
    required List<QuestionRemote> questions,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final batch = _fireStore.batch();

    final lessonRef = lesson.id.isEmpty
        ? _fireStore.collection(DatabaseCollections.lessons).doc()
        : _fireStore.collection(DatabaseCollections.lessons).doc(lesson.id);
    final resolvedLessonId = lessonRef.id;

    final isNewLesson = lesson.id.isEmpty;
    var lessonToWrite = lesson.copyWith(id: resolvedLessonId);
    if (isNewLesson && lessonToWrite.courseId.trim().isNotEmpty) {
      final sortOrder = await _allocateSortOrderForNewLessonInCourse(
        lessonToWrite.courseId,
      );
      lessonToWrite = lessonToWrite.copyWith(sortOrder: sortOrder);
    }
    final lessonPayload = Map<String, dynamic>.from(lessonToWrite.toJson());
    if (isNewLesson) {
      lessonPayload['createdAt'] = FieldValue.serverTimestamp();
    }
    batch.set(lessonRef, lessonPayload, SetOptions(merge: true));
    if (isNewLesson && lessonToWrite.courseId.isNotEmpty) {
      final courseRef = _fireStore
          .collection(DatabaseCollections.courses)
          .doc(lessonToWrite.courseId);
      batch.update(courseRef, {'lessonsAmount': FieldValue.increment(1)});
    }

    if (!isNewLesson) {
      final existingLinkedCollections = await Future.wait([
        _fireStore
            .collection(DatabaseCollections.tasks)
            .where('lessonId', isEqualTo: resolvedLessonId)
            .get(),
        _fireStore
            .collection(DatabaseCollections.questions)
            .where('lessonId', isEqualTo: resolvedLessonId)
            .get(),
      ]);

      final existingTaskIds = tasks
          .where((task) => task.id.isNotEmpty)
          .map((task) => task.id)
          .toSet();
      final existingQuestionIds = questions
          .where((question) => question.id.isNotEmpty)
          .map((question) => question.id)
          .toSet();

      final tasksSnapshot = existingLinkedCollections[0];
      final questionsSnapshot = existingLinkedCollections[1];

      for (final taskDoc in tasksSnapshot.docs) {
        if (!existingTaskIds.contains(taskDoc.id)) {
          batch.delete(taskDoc.reference);
        }
      }
      for (final questionDoc in questionsSnapshot.docs) {
        if (!existingQuestionIds.contains(questionDoc.id)) {
          batch.delete(questionDoc.reference);
        }
      }
    }

    final resolvedTasks = <TaskRemote>[];
    for (final task in tasks) {
      final taskRef = task.id.isEmpty
          ? _fireStore.collection(DatabaseCollections.tasks).doc()
          : _fireStore.collection(DatabaseCollections.tasks).doc(task.id);
      final written = task.copyWith(id: taskRef.id, lessonId: resolvedLessonId);
      batch.set(taskRef, written.toJson(), SetOptions(merge: true));
      resolvedTasks.add(written);
    }

    final resolvedQuestions = <QuestionRemote>[];
    for (final question in questions) {
      final questionRef = question.id.isEmpty
          ? _fireStore.collection(DatabaseCollections.questions).doc()
          : _fireStore
                .collection(DatabaseCollections.questions)
                .doc(question.id);
      final written = question.copyWith(
        id: questionRef.id,
        lessonId: resolvedLessonId,
      );
      batch.set(questionRef, written.toJson(), SetOptions(merge: true));
      resolvedQuestions.add(written);
    }

    await batch.commit();

    return LessonBundleRemote(
      lesson: lessonToWrite,
      tasks: resolvedTasks,
      questions: resolvedQuestions,
    );
  }

  @override
  Future<void> updateLessonsSortOrder({
    required String courseId,
    required List<String> lessonIdsOrdered,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final batch = _fireStore.batch();
    for (var i = 0; i < lessonIdsOrdered.length; i++) {
      final id = lessonIdsOrdered[i].trim();
      if (id.isEmpty) continue;
      final ref = _fireStore.collection(DatabaseCollections.lessons).doc(id);
      batch.update(ref, {'sortOrder': i});
    }
    await batch.commit();
  }

  @override
  Future<List<CourseRemote>> fetchAllCourses() async {
    final snapshot = await _fireStore
        .collection(DatabaseCollections.courses)
        .get();
    return snapshot.docs.map((doc) {
      final json = Map<String, dynamic>.from(doc.data());
      json['id'] = doc.id;
      return CourseRemote.fromJson(json);
    }).toList();
  }

  @override
  Future<void> updateCourseDetails({
    required String courseId,
    required String name,
    required String imageUrl,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final normalizedCourseId = courseId.trim();
    if (normalizedCourseId.isEmpty) {
      throw ArgumentError('courseId is empty');
    }

    await _fireStore
        .collection(DatabaseCollections.courses)
        .doc(normalizedCourseId)
        .set({
          'name': name.trim(),
          'imageUrl': imageUrl.trim(),
        }, SetOptions(merge: true));
  }

  @override
  Future<void> deleteCourseCascade(String courseId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final normalizedCourseId = courseId.trim();
    if (normalizedCourseId.isEmpty) {
      throw ArgumentError('courseId is empty');
    }

    final courseRef = _fireStore
        .collection(DatabaseCollections.courses)
        .doc(normalizedCourseId);
    final lessonSnapshot = await _fireStore
        .collection(DatabaseCollections.lessons)
        .where('courseId', isEqualTo: normalizedCourseId)
        .get();

    final referencesToDelete = <DocumentReference<Map<String, dynamic>>>[];
    referencesToDelete.addAll(lessonSnapshot.docs.map((doc) => doc.reference));

    for (final lessonDoc in lessonSnapshot.docs) {
      final linkedCollections = await Future.wait([
        _fireStore
            .collection(DatabaseCollections.tasks)
            .where('lessonId', isEqualTo: lessonDoc.id)
            .get(),
        _fireStore
            .collection(DatabaseCollections.questions)
            .where('lessonId', isEqualTo: lessonDoc.id)
            .get(),
      ]);

      final tasksSnapshot = linkedCollections[0];
      final questionsSnapshot = linkedCollections[1];

      referencesToDelete.addAll(tasksSnapshot.docs.map((doc) => doc.reference));
      referencesToDelete.addAll(
        questionsSnapshot.docs.map((doc) => doc.reference),
      );
    }

    await _deleteDocumentsInBatches(referencesToDelete);

    await courseRef.delete();
  }

  Future<void> _deleteDocumentsInBatches(
    List<DocumentReference<Map<String, dynamic>>> references,
  ) async {
    const maxBatchOperations = 450;
    var batch = _fireStore.batch();
    var operationCount = 0;

    Future<void> flushBatch() async {
      if (operationCount == 0) return;
      await batch.commit();
      batch = _fireStore.batch();
      operationCount = 0;
    }

    for (final ref in references) {
      batch.delete(ref);
      operationCount++;
      if (operationCount >= maxBatchOperations) {
        await flushBatch();
      }
    }

    await flushBatch();
  }

  @override
  Future<CourseRemote> uploadFullCourseBundle({
    required CourseRemote course,
    required List<LessonRemote> lessons,
    required List<TaskRemote> tasks,
    required List<QuestionRemote> questions,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final emptyLessonIds = lessons.where((lesson) => lesson.id.isEmpty).length;
    final hasUnresolvedLessonLinks =
        tasks.any((task) => task.lessonId.isEmpty) ||
        questions.any((question) => question.lessonId.isEmpty);

    if (emptyLessonIds > 1 && hasUnresolvedLessonLinks) {
      throw ArgumentError(
        'Bundle upload requires stable lesson ids when tasks or questions are attached to new lessons.',
      );
    }

    final batch = _fireStore.batch();

    final courseRef = course.id.isEmpty
        ? _fireStore.collection(DatabaseCollections.courses).doc()
        : _fireStore.collection(DatabaseCollections.courses).doc(course.id);
    final courseId = courseRef.id;

    final courseData = course
        .copyWith(id: courseId, lessonsAmount: lessons.length)
        .toJson();
    batch.set(courseRef, courseData, SetOptions(merge: true));

    final Map<String, String> lessonIdMap = {};

    for (var lessonIndex = 0; lessonIndex < lessons.length; lessonIndex++) {
      final lesson = lessons[lessonIndex];
      final lessonRef = lesson.id.isEmpty
          ? _fireStore.collection(DatabaseCollections.lessons).doc()
          : _fireStore.collection(DatabaseCollections.lessons).doc(lesson.id);
      final originalLessonId = lesson.id;
      final resolvedLessonId = lessonRef.id;

      if (originalLessonId.isNotEmpty) {
        lessonIdMap[originalLessonId] = resolvedLessonId;
      } else {
        lessonIdMap[''] = resolvedLessonId;
      }

      final lessonData = lesson
          .copyWith(
            id: resolvedLessonId,
            courseId: courseId,
            sortOrder: lessonIndex,
          )
          .toJson();

      batch.set(lessonRef, lessonData, SetOptions(merge: true));
    }

    for (final task in tasks) {
      final resolvedLessonId = lessonIdMap[task.lessonId] ?? task.lessonId;
      if (resolvedLessonId.isEmpty) {
        throw ArgumentError(
          'Task "${task.id}" is missing a resolvable lessonId for bundle upload.',
        );
      }

      final taskRef = task.id.isEmpty
          ? _fireStore.collection(DatabaseCollections.tasks).doc()
          : _fireStore.collection(DatabaseCollections.tasks).doc(task.id);

      final taskData = task
          .copyWith(id: taskRef.id, lessonId: resolvedLessonId)
          .toJson();

      batch.set(taskRef, taskData, SetOptions(merge: true));
    }

    for (final question in questions) {
      final resolvedLessonId =
          lessonIdMap[question.lessonId] ?? question.lessonId;
      if (resolvedLessonId.isEmpty) {
        throw ArgumentError(
          'Question "${question.id}" is missing a resolvable lessonId for bundle upload.',
        );
      }

      final questionRef = question.id.isEmpty
          ? _fireStore.collection(DatabaseCollections.questions).doc()
          : _fireStore
                .collection(DatabaseCollections.questions)
                .doc(question.id);

      final questionData = question
          .copyWith(id: questionRef.id, lessonId: resolvedLessonId)
          .toJson();

      batch.set(questionRef, questionData, SetOptions(merge: true));
    }

    await batch.commit();
    return course.copyWith(id: courseId);
  }

  @override
  Future<void> submitTesterAccessRequest() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final docRef = _fireStore
        .collection(DatabaseCollections.testerAccessRequests)
        .doc(user.uid);
    final existing = await docRef.get();
    final existingStatus = existing.data()?['status'] as String?;

    if (existing.exists && existingStatus == 'pending') {
      throw Exception('request-already-pending');
    }

    await docRef.set({
      'userId': user.uid,
      'email': user.email ?? '',
      'fullName': user.displayName ?? '',
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
      'reviewedAt': null,
      'reviewedBy': null,
    });
  }

  @override
  Future<TesterAccessRequestRemote?> fetchTesterAccessRequestForUser(
    String userId,
  ) async {
    final doc = await _fireStore
        .collection(DatabaseCollections.testerAccessRequests)
        .doc(userId)
        .get();
    if (!doc.exists || doc.data() == null) return null;
    return TesterAccessRequestRemote.fromFirestore(doc.data()!, doc.id);
  }

  @override
  Future<List<TesterAccessRequestRemote>>
  fetchPendingTesterAccessRequests() async {
    final snapshot = await _fireStore
        .collection(DatabaseCollections.testerAccessRequests)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map(
          (doc) => TesterAccessRequestRemote.fromFirestore(doc.data(), doc.id),
        )
        .toList();
  }

  @override
  Future<void> approveTesterAccessRequest({
    required String requestId,
    required String userId,
  }) async {
    final batch = _fireStore.batch();
    batch.update(_fireStore.collection(DatabaseCollections.users).doc(userId), {
      'role': 'tester',
    });
    batch.update(
      _fireStore
          .collection(DatabaseCollections.testerAccessRequests)
          .doc(requestId),
      {
        'status': 'approved',
        'reviewedAt': FieldValue.serverTimestamp(),
        'reviewedBy': currentUserId,
      },
    );
    await batch.commit();
  }

  @override
  Future<void> rejectTesterAccessRequest({required String requestId}) async {
    await _fireStore
        .collection(DatabaseCollections.testerAccessRequests)
        .doc(requestId)
        .update({
          'status': 'rejected',
          'reviewedAt': FieldValue.serverTimestamp(),
          'reviewedBy': currentUserId,
        });
  }

  @override
  Future<List<KnowledgeBaseNewsItem>> fetchKnowledgeBaseNews() {
    // TODO: implement fetchKnowledgeBaseNews
    throw UnimplementedError();
  }

  @override
  Future<String> fetchKnowledgeBaseRoadmapJson() {
    // TODO: implement fetchKnowledgeBaseRoadmapJson
    throw UnimplementedError();
  }
}

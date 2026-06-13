/// Firestore collection names used by [RemoteDataManagerImpl].
///
/// **Security rules (deploy in Firebase Console; not stored in this repo):**
/// - Authenticated users with `role == 'admin'` (or your admin claim) should
///   be allowed `read, write` on [courses], [lessons], [tasks], [questions]
///   so the admin app can manage nested course → lesson → task/question data.
/// - Student app typically needs `read` on those collections; writes only for
///   admin (or omit writes for clients entirely).
/// - [testerAccessRequests]: authenticated user may create/update own doc
///   (`docId == uid`, `status: pending`); admins read all and update status;
///   approve flow also requires admin write on [users] `role` field.
abstract class DatabaseCollections {
  static const String lessons = 'lessons';
  static const String courses = 'courses';
  static const String tasks = 'tasks';
  static const String questions = 'questions';
  static const String users = 'users';

  /// Staging: users request promotion to `tester`; admins approve in admin app.
  static const String testerAccessRequests = 'tester_access_requests';
}

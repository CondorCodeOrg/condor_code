# Firebase Analytics

This document describes the architecture and usage of Firebase Analytics in the **Condor Code** app.

## TL;DR

- **Staging and Prod only** — Dev does not send any events.
- **Every event** automatically gets `cc_session_id` (session grouping).
- **User identity** — `identifyUser(userId)` is called automatically on login/logout.
- **All strings** — event and parameter names are constants from `analytics_constants.dart`; hardcoding is forbidden.

---

## Architecture

```
┌─────────────────────────────────────┐
│         UI / Screens                │
│   logEvent(AnalyticsEventName.xxx)  │
└─────────────┬───────────────────────┘
              │
              ▼
┌─────────────────────────────────────┐
│         Analytics (abstract)        │
│  logEvent | identifyUser | sessionId│
└─────────────┬───────────────────────┘
              │
              ▼
┌─────────────────────────────────────┐
│    FirebaseAnalyticsImpl            │
│  • appends cc_session_id to every   │
│    event                            │
│  • calls FirebaseAnalytics          │
│  • no-op for Dev                    │
└─────────────────────────────────────┘
```

### Files

| File | Purpose |
|------|---------|
| `lib/ui/analytics/analytics.dart` | Abstract `Analytics` class — contract for the whole app |
| `lib/ui/analytics/analytics_constants.dart` | **Single source of truth** for event and parameter names |
| `lib/ui/analytics/firebase_analytics_impl.dart` | Concrete Firebase implementation |
| `lib/ui/analytics/analytics_navigator_observer.dart` | `NavigatorObserver` that logs `screen_view` on every navigation change |
| `lib/ui/analytics/provider/analytics_events_provider.dart` | Interface for automatic events (enter/exit screen, login/logout) |
| `lib/ui/analytics/provider/analytics_events_provider_impl.dart` | `AnalyticsEventsProvider` implementation |

---

## Event Constants

### Event names (`AnalyticsEventName`)

| Constant | Value | When logged |
|----------|-------|-------------|
| `screenView` | `screen_view` | Every screen change (automatic) |
| `navClick` | `nav_click` | Navigation tap (top nav, side nav) |
| `buttonClick` | `button_click` | Key button taps |
| `openCourse` | `open_course` | Opening a course |
| `selectLesson` | `select_lesson` | Selecting a lesson inside a course |
| `openTask` | `open_task` | Opening a task |
| `userLogin` | `user_login` | Successful login |
| `userLogout` | `user_logout` | Logout |
| `wishFlutterCourse` | `wish_flutter_course` | Tapping "I want a Flutter course" on empty states |

### Parameter names (`AnalyticsPropertyName`)

| Constant | Value | Description |
|----------|-------|-------------|
| `sessionId` | `cc_session_id` | Session ID (timestamp) |
| `screenName` | `screen_name` | Screen name |
| `screenClass` | `screen_class` | Widget class of the screen |
| `destination` | `destination` | Navigation route |
| `buttonId` | `button_id` | Button identifier |
| `courseId` | `course_id` | Firestore course ID |
| `courseName` | `course_name` | Course name |
| `lessonId` | `lesson_id` | Lesson ID |
| `lessonTitle` | `lesson_title` | Lesson title |
| `taskId` | `task_id` | Task ID |
| `environment` | `environment` | `prod` or `staging` |
| `userId` | `user_id` | Authenticated user ID |
| `firebaseScreen` | `firebase_screen` | For Firebase `screen_view` |
| `firebaseScreenClass` | `firebase_screen_class` | For Firebase `screen_view` |
| `screenId` | `screen_id` | Screen ID (for `AnalyticsEventsProvider`) |
| `screenTitle` | `screen_title` | Screen title |

### Button identifiers (`AnalyticsButtonId`)

| Constant | Value |
|----------|-------|
| `homeLearnMore` | `home_learn_more` |
| `checkKnowledge` | `check_knowledge` |

### Navigation routes (`AnalyticsDestination`)

| Constant | Value |
|----------|-------|
| `home` | `/home` |
| `courses` | `/courses` |
| `contacts` | `/contacts` |
| `knowledgeBaseHome` | `/knowledge-base/home` |
| `knowledgeBaseRoadmap` | `/knowledge-base/roadmap` |
| `knowledgeBaseResources` | `/knowledge-base/resources` |

---

## How Session ID Works

Each app launch generates a new `sessionId` (timestamp in milliseconds). This ID is automatically appended to **every** event inside `FirebaseAnalyticsImpl.logEvent()`:

```dart
final enriched = <String, dynamic>{
  ...parameters,
  AnalyticsPropertyName.sessionId: sessionId,
};
```

> ⚠️ Firebase Analytics reserves the name `session_id`, so we use `cc_session_id`.

---

## User Identity

To prevent the same account from being counted as multiple "New Users", `identifyUser` is called on login:

```dart
await analytics.identifyUser(user.id);  // setUserId + user property
```

On logout:
```dart
await analytics.identifyUser(null);      // clears the ID
```

This happens automatically in `StagingGateNotifier`, which listens to `AuthRepository.authStateChanges`.

---

## Environment Filtering

Analytics behavior is controlled by `AppConfig` (`BUILD_TYPE` and `DATA_SOURCE`):

| `DATA_SOURCE` | `BUILD_TYPE` | Analytics Implementation | Events Sent |
|---------------|--------------|------------------------|-------------|
| `mock` | any | `MockAnalyticsImpl` | No (no-op) |
| `remote` | `dev` | `MockAnalyticsImpl` | No (no-op) |
| `remote` | `staging` | `FirebaseAnalyticsImpl` | Yes |
| `remote` | `prod` | `FirebaseAnalyticsImpl` | Yes |

For staging and production builds, the environment property is set automatically:

```dart
di<Analytics>().setUserProperty(
  name: AnalyticsPropertyName.environment,
  value: 'prod', // or 'staging'
);
```

**Dev** and **mock** modes do not send any analytics events.

---

## How to Add a New Event

1. **Add a constant** in `lib/ui/analytics/analytics_constants.dart`:

```dart
// AnalyticsEventName
static const String myNewEvent = 'my_new_event';

// AnalyticsPropertyName (if a new parameter is needed)
static const String myParam = 'my_param';
```

2. **Use it** in code:

```dart
di<Analytics>().logEvent(AnalyticsEventName.myNewEvent, {
  AnalyticsPropertyName.myParam: someValue,
});
```

3. **Do not use hardcoded strings!** All event and parameter names must be constants.

4. **Register a Custom Definition** in Firebase Console (Analytics → Custom Definitions) if you want to see the parameter in reports. Registration can take up to 24 hours.

---

## How to View Events

### DebugView (for testing)

1. Firebase Console → Analytics → DebugView
2. Run a Staging or Prod build
3. Events appear in real time with all parameters

### Events (standard reports)

1. Firebase Console → Analytics → Events
2. Look for: `screen_view`, `nav_click`, `open_course`, etc.
3. Filter by `environment = staging` or `environment = prod`

> ⚠️ Custom parameters do **not** appear in Events until registered as Custom Definitions.

### User Explorer

- Go to **User Explorer**
- Search by `Effective user ID` (this is `user_pseudo_id` or `user_id`)
- You can view the event history of a specific user

---

## BigQuery (SQL Analysis)

If you need detailed session analysis, connect BigQuery:

```sql
SELECT
  event_timestamp,
  event_name,
  user_pseudo_id,
  (SELECT value.string_value FROM UNNEST(user_properties) WHERE key = 'user_id') AS user_id,
  (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'cc_session_id') AS session_id,
  (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'screen_name') AS screen
FROM `your-project.analytics_.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20250101' AND '20250131'
  AND (SELECT value.string_value FROM UNNEST(user_properties) WHERE key = 'environment') = 'prod'
ORDER BY user_pseudo_id, event_timestamp;
```

---

## Known Firebase Analytics Limitations

1. **Only `String` and `num`** — passing `Set<String>` or other types throws `AssertionError`.
2. **Reserved names** — `session_id`, `firebase_event_origin`, and others cannot be used as custom parameters.
3. **25 parameters per event** — maximum.
4. **500 unique event names** — project limit.
5. **24 hours** — delay for Custom Definition registration.

---

## Pre-release Checklist

- [ ] All new events use constants from `analytics_constants.dart`
- [ ] No hardcoded strings inside `logEvent()` calls
- [ ] `flutter analyze` passes with no new errors
- [ ] Custom Definitions registered in Firebase Console (if needed)

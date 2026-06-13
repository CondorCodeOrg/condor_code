---
sidebar_position: 4
title: Admin app, main app, and shared content (Firestore)
---

# Admin app, main app, and shared content (Firestore)

This page explains how **condor_code_admin_app** and **condor_code_app** stay in sync for **courses and lessons**. It focuses on behaviour that is easy to miss (especially **lesson order**) and on pitfalls for future changes.

There is **no separate “admin API”** that the main app calls. Both apps use the **`packages/domain`** contracts and **`packages/data`** implementations against the **same Firebase project** (Firestore). The database is the single source of truth.

---

## Mental model

| Concern | Where it lives |
|--------|----------------|
| Entities (`Lesson`, `Course`, `LessonItem`, …) | `packages/domain` |
| Repository interfaces | `packages/domain/lib/repository/` |
| Firestore reads/writes, DTOs (`*Remote`), mappers | `packages/data` |
| Admin UI (Riverpod, reordering) | `apps/condor_code_admin_app` |
| Learner UI (Bloc/Cubit, course screen) | `apps/condor_code_app` |

Any feature that must appear in **both** apps should be reflected in **domain + data** first, then wired in each app’s presentation layer.

---

## Lesson order (`sortOrder`)

### Field

- Each lesson document in Firestore includes **`sortOrder`** (integer).
- Domain: `Lesson.sortOrder`, `LessonItem.sortOrder`; remote: `LessonRemote.sortOrder` (JSON key `sortOrder`).
- Older documents may **omit** the field; parsers and generated JSON treat missing values as **`0`**.

### Sorting when reading (both apps)

`LessonsRepositoryImpl` sorts lessons for a course by:

1. **`sortOrder` ascending**
2. Tie-break: **`title`** (or **name** on `LessonItem`) case-insensitively

So the **same repository code** defines order for:

- **`fetchLessonsForCourse`** (full `Lesson` list — admin course detail, editors)
- **`getLessonsItems`** (lightweight `LessonItem` list — learner **course screen** side panel)

Reference: `packages/data/lib/repository/lessons_repository_impl.dart` (local helpers `_compareLessonsClientOrder`, `_compareLessonItemsClientOrder`).

### How `sortOrder` gets set

| Scenario | Behaviour |
|----------|-----------|
| **New lesson** (`saveLesson`, `saveLessonBundle`, new id) | `RemoteDataManagerImpl._allocateSortOrderForNewLessonInCourse` loads siblings for the course and assigns **`max(sortOrder) + 1`** so new lessons append after existing ones (client often sends default `0`). |
| **Bulk course upload** | `uploadFullCourseBundle` sets **`sortOrder` to the lesson’s index** in the uploaded list (`0 .. n-1`). |
| **Admin drag-and-drop reorder** | Admin persists **`0 .. n-1`** for the ordered list of lesson ids via **`updateLessonsSortOrder`** (batch Firestore updates). |

Reference: `packages/data/lib/data_sources/remote/remote_data_manager_impl.dart` (`_allocateSortOrderForNewLessonInCourse`, `updateLessonsSortOrder`, `uploadFullCourseBundle` loop).

### Admin UI specifics

- Lessons for a course are loaded with **`courseLessonsProvider`** (`apps/condor_code_admin_app/.../course_lessons_provider.dart`). Ordering comes from the repository (not alphabet-by-title).
- Reordering uses **`ReorderableListView`** and, after a drag, **`LessonsRepository.updateLessonsSortOrder`**, then **`ref.invalidate(courseLessonsProvider(courseId))`** so the list refetches.

### Learner app specifics

- **`CourseCubit`** loads **`getLessonsItems(courseId)`**; the list is already ordered in the repository.
- Changing order in admin requires **no main-app code change** — only Firestore updates and a refresh (or reopen) on the client.

---

## Legacy and migration notes

- If every lesson has **`sortOrder == 0`** (field missing or default), order is **only** the alphabetical tie-break until an admin **reorders once** or you run a one-off migration to assign distinct `sortOrder` values.
- After a user reorders in admin, documents get explicit **`0 .. n-1`**, which is stable going forward.

---

## Things to watch when extending this approach

1. **Single source of truth** — If you add a new lesson field that both apps must show, add it to **domain → remote DTO → mapper/Firestore parser**, not only in one app.
2. **Ordering** — Any new list endpoint for “lessons in course” should use the **same sort** as `LessonsRepositoryImpl` or call the same helper, or learners and admins will disagree.
3. **New lesson creation** — Do not rely on the client sending a correct `sortOrder`; creation paths should keep using **allocation** (max + 1) or explicit batch indexing (upload bundle).
4. **Firestore batch limits** — `updateLessonsSortOrder` uses a single batch; if a course could exceed **500** writes per batch, the implementation would need chunking (unlikely for lesson counts).
5. **Concurrency** — Two simultaneous “create lesson” operations could theoretically get the same next index; acceptable for rare admin use, but worth knowing if you automate mass imports.

---

## Quick file index (for humans and tooling)

| Topic | Location |
|-------|----------|
| `sortOrder` on `Lesson` / `copyWith` | `packages/domain/lib/models/lesson.dart` |
| `LessonItem.sortOrder` | `packages/domain/lib/models/lesson_item.dart` |
| `updateLessonsSortOrder` API | `packages/domain/lib/repository/lessons_repository.dart` |
| Sort + mapping | `packages/data/lib/repository/lessons_repository_impl.dart` |
| Firestore lesson DTO + JSON | `packages/data/lib/data_sources/remote/models/lesson_remote.dart` |
| Tolerant Firestore parse | `packages/data/lib/data_sources/remote/remote_document_parsers.dart` |
| Allocate sort for new lesson, reorder batch | `packages/data/lib/data_sources/remote/remote_data_manager_impl.dart` |
| Admin lesson list + reorder UI | `apps/condor_code_admin_app/.../content_section.dart` (`_CourseDetails`) |
| Admin lessons FutureProvider | `apps/condor_code_admin_app/.../course_lessons_provider.dart` |
| Learner course lessons | `apps/condor_code_app/.../course_cubit/course_cubit.dart` |

Related UI wiki pages: [Side panel / screen layout](widgets/side-panel-screen-widget.md), [YouTube player widget](widgets/youtube-player-widget.md).

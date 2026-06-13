# Navigation Conventions (Condor Code App)

This document describes **how routing works** in `apps/condor_code_app`: what users expect (especially browser history), how we implement it in code, and **mandatory patterns for embedded YouTube playback**.

Paths are defined in `lib/ui/navigation/route_constants.dart` and wired in `lib/ui/navigation/go_router.dart`.

---

## User Navigation Flow (Condor Code App)

This section summarizes the real user journey and navigation logic:

- **Entry Point:**
  - Web: Home screen (`/home`)
  - Mobile: Courses list (`/courses`)

- **Main Tabs:**
  - Home, Courses, Knowledge Base, Contacts (all accessible via bottom navigation)

- **Courses Flow:**
  - User selects a course from `/courses` (CoursesListScreen)
  - Navigates to `/course/:courseId/:lessonId` (CourseScreen)
  - Sidebar lists lessons; selecting a lesson pushes a new lesson route
  - In-lesson, user can open Knowledge Check (tasks) for that lesson

- **Knowledge Check Flow:**
  - Navigates to `/courses/:courseId/lessons/:lessonId/tasks/:taskId` (KnowledgeCheckScreen)
  - Sidebar lists tasks; selecting a task pushes a new task route

- **Back Navigation:**
  - Browser Back: Steps through lesson/task history
  - In-app Back (header): Exits to courses list or lesson in one step

- **Knowledge Base:**
  - `/knowledgeBase/home`, `/knowledgeBase/roadmap`, `/knowledgeBase/resources` (all under KnowledgeBaseShell)

- **Contacts:**
  - `/contactsScreen` (ContactsScreen)

---

## Router setup (short)

- **`GoRouter`** uses a **`StatefulShellRoute.indexedStack`** with multiple branches (home, **courses**, knowledge base, contacts).
- The **courses branch** owns: courses list, **course + lesson**, empty-course placeholder, and **knowledge check (tasks)**.
- **`coursesBranchRouteObserver`** (`lib/ui/navigation/route_observers.dart`) is registered on that branch via `StatefulShellBranch(observers: [...])`. It powers **`RouteAware`** widgets (see YouTube below).

**Naming caveat:** `RouteConstants.knowledgeCheck` is **`/courses`**. Knowledge-check URLs are therefore shaped like:

`/courses/:courseId/lessons/:lessonId/tasks/:taskId`

They share the `/courses` prefix with the **courses list** route (`/courses` exactly). Matching is disambiguated by the full path pattern in `go_router.dart`.

### Web: URL bar and `push`

By default, **`context.push`** may **not** update the browser address bar (especially inside a shell). We set **`GoRouter.optionURLReflectsImperativeAPIs = true`** at app startup in each `main_*.dart` so lesson/task stacks stay reflected in the URL and match Back / Forward.

---

## User-visible behaviour: browser Back / Forward

We intentionally stack **logical steps** so the browser history matches exploration inside a course or knowledge check.

### Course screen — switching lessons

- **Expected:** User opens lesson A, then lesson B, then lesson C. **Back** goes C → B → A → previous screen (e.g. courses list). **Forward** replays A → B → C.
- **Implementation:** Lesson changes use **`context.push(...)`** with the path `/course/:courseId/:lessonId` (see `course_screen.dart`). Each push adds a history entry.
- **Initial entry** from the courses list uses **`context.go`** after resolving the first lesson id (`CoursesCubit` + `BlocListener` in `courses_list_screen.dart`) so the URL uses a real lesson id, not a `first` placeholder.
- **Sidebar selection** must track the **lesson id for this route instance** (`initialLessonId` passed into `CourseScreen`), not only `CourseCubit.selectedLesson`, so the highlighted lesson matches the URL immediately (during fetch) and stays aligned with browser Back / Forward. Helpers: `_effectiveSidebarLessonId` in `course_screen.dart`, same idea for tasks in `knowledge_check_screen.dart` (`_effectiveSidebarTaskId`).

### Knowledge check — switching tasks

- **Expected:** Same linear history for tasks as for lessons.
- **Implementation:** Task changes use **`context.push`** (`knowledge_check_screen.dart`).
- **Opening** knowledge check **from a lesson** uses **`context.push`** after **`TasksRepository.getTasks`** resolves the first task id (`course_action_panel.dart`) so the URL never stays on the `first` placeholder.

### In-app Back buttons (header widget, not the browser chrome)

These deliberately **differ** from the browser Back button:

- **Browser Back / Forward:** walks the **`push`** stack step by step (each lesson or task is one history entry).
- **Course header (`ScreenBackButton`):** **`context.go('/courses')`** — exits the **whole** course flow at once (does not pop lesson-by-lesson).
- **Knowledge check header:** **`context.go('/course/:courseId/:lessonId')`** — returns to the lesson in **one** step (does not pop task-by-task).

Implementations: `_exitCourseViaAppBar` and `_exitKnowledgeCheckViaAppBar` in the respective screen files.

---

## Implementation rules (`push` vs `go`)

| Goal | Use |
|------|-----|
| Replace current location, single history entry | **`context.go`** |
| Append a step (Back should return here) | **`context.push`** |

Do **not** use a **custom `pageKey`** on `CustomTransitionPage` that depends only on `courseId`/`lessonId`/`taskId`. Re-opening the same lesson/task via **push** while it already exists **below** on the stack would duplicate keys and trigger Navigator **`!keyReservation.contains(key)`**. Rely on **`state.pageKey`** from go_router (unique per stack entry).

---

## Courses list → course URL

`CoursesCubit.openCourse` loads lesson ids, emits a one-shot **`CourseOpenCommand`**, and the UI **`BlocListener`** performs **`go`** then **`consumeOpenCommand()`** (`courses_state.dart`, `courses_list_screen.dart`). Keeps navigation out of dumb list widgets and preserves snackbar/error handling via the cubit.

---

## YouTube player and routes (mandatory for every embedded player)

### Problem

With **`push`**, the previous screen **stays mounted** under the new route. **`dispose`** on the old player **does not run**, so **iframe audio can keep playing** until that route is popped.

### Solution in this repo

`YouTubePlayerWidget` (`lib/ui/widgets/youtube_player.dart`) mixes in **`RouteAware`** and subscribes to **`coursesBranchRouteObserver`**:

- **`didPushNext`** — another route was pushed on top → **`pauseVideo()`**
- **`didPop`** — this route was removed → **`pauseVideo()`**

Subscription is refreshed in **`didChangeDependencies`** (`unsubscribe` then `subscribe` if `ModalRoute` is a **`PageRoute`**). **`dispose`** unsubscribes and **`close()`** the controller.

### Checklist for **new screens** that embed YouTube

1. If the screen lives **outside** the courses shell branch, **`coursesBranchRouteObserver` will not notify it**. Either:
   - attach a **`RouteObserver`** to that branch’s navigator as well, **or**
   - reuse / extend a shared observer pattern for that subtree.
2. For any **`YouTubePlayerWidget`** on a route that can be **covered** by another **`push`** without disposing: keep **`RouteAware`** + observer behaviour **or** an equivalent guarantee (pause/stop when the route is no longer on top).
3. Prefer **`pauseVideo()`** when losing visibility; use **`stopVideo()`** only if product requires a harder teardown (e.g. lingering web audio).

---

## Primary code references

| Topic | Location |
|-------|-----------|
| Router graph | `apps/condor_code_app/lib/ui/navigation/go_router.dart` |
| Path constants | `apps/condor_code_app/lib/ui/navigation/route_constants.dart` |
| Branch observer | `apps/condor_code_app/lib/ui/navigation/route_observers.dart` |
| Course lesson navigation | `apps/condor_code_app/lib/ui/screens/course/course_screen.dart` |
| Knowledge check navigation | `apps/condor_code_app/lib/ui/screens/knowledge_check/knowledge_check_screen.dart` |
| Open KC from lesson | `apps/condor_code_app/lib/ui/screens/course/widgets/course_action_panel.dart` |
| Courses → course open | `apps/condor_code_app/lib/ui/screens/courses/courses_cubit/courses_cubit.dart`, `courses_list_screen.dart` |
| YouTube + RouteAware | `apps/condor_code_app/lib/ui/widgets/youtube_player.dart` |

---

## Related docs

- [Architectural conventions](./arch_conventions.md) — layers, Bloc, DI  
- [UI conventions](./ui_conventions.md) — widgets vs helpers, Cubits  

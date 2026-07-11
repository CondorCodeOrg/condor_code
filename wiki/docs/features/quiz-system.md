# Test System Architecture

The Test System replaces the legacy lesson quiz system. It is designed to be highly extensible, responsive, web-compatible, and integrated with analytics.

## Core Components

The test system consists of the following key structures:

1. **TestSelectionScreen** (`lib/ui/screens/test_selection/test_selection_screen.dart`):
   - Initiated from the Course Action Panel with the "Take Tests" button.
   - Fetches available tests for a specific lesson via the `TestSelectionCubit`.
   - Displays a list of practice tests using a card-based visual design (`TestCard`).
   - Adapts button layout and statistics layout based on the device width.

2. **TestScreen** (`lib/ui/screens/test/test_screen.dart`):
   - The main gameplay environment where questions are presented sequentially.
   - Restricts horizontal content width to 800px on desktop configurations (width >= 1024px) for optimized scanning.
   - Includes physical keyboard listeners:
     - `1`, `2`, `3`, `4` key inputs: Select matching answer options.
     - `Enter` key input: Proceeds through "Move On" and confirms answer bottom sheet dialogues.

3. **TestSelectionCubit & TestCubit**:
   - `TestSelectionCubit` queries the local/remote lessons and questions database to produce list item models (`TestModel`).
   - `TestCubit` manages the transient state of the active test session (e.g. loading, moving, right/wrong evaluations, finished, load failure).

## Web Compatibility Adjustments

To ensure absolute compatibility across Web and Desktop targets:
- Removed dependencies on mobile-only toast libraries (e.g. `Fluttertoast`), substituting standard `SnackBarEventsProvider` and `SnackBarCubit` snackbars.
- Pervasively wrapped `AudioPlayer.play(...)` calls in try-catch handlers to prevent unhandled browser security errors (such as missing user gesture blocks).
- Replaced direct `Navigator` operations with GoRouter context-based navigation (`context.go`, `context.pop`) to maintain browser history tracking.

## Analytics & Event Schema

Events are dispatched to the analytics provider (`di<Analytics>()`) at major user checkpoints:

| Event Name | Parameter Properties | Trigger Condition |
| --- | --- | --- |
| `test_selected` | `lesson_id`, `test_id` | Tapping a test card in `TestSelectionScreen` |
| `test_started` | `lesson_id`, `test_id` | Clicking the "Start Test" button |
| `question_answered` | `lesson_id`, `question_id`, `is_correct` (1/0) | Submitting an answer option in `TestScreen` |
| `test_completed` | `lesson_id`, `correct_count`, `incorrect_count`, `duration_seconds` | Finalizing the quiz and navigating to `ResultScreen` |

# Naming Conventions

This document defines naming standards for the CondorCode codebase.

## Boolean Variables

**Boolean variables must use the `is` prefix:**

- `isLoading`, `isVisible`, `isExpanded` — for UI state
- `isTasksExist`, `isLessonsLoading` — for data loading state
- `isError`, `isEmpty` — for condition flags

**Why:** The `is` prefix makes boolean intent immediately clear and consistent across the codebase. Always use `is` for boolean state fields in Cubits, Blocs, and models.

---
sidebar_position: 1
---

# SidePanelScreenWidget Ecosystem

**Location:** `apps/condor_code_app/lib/ui/widgets/side_panel_screen_widget.dart`

## Purpose

A set of widgets that handle responsive collapsible side-panel layouts. The ecosystem eliminates duplicated breakpoint/collapse logic across screens and enforces a consistent panel structure through strong typing.

### Widgets in the ecosystem

| Widget | Role |
|---|---|
| `SidePanelScreenWidget` | Top-level responsive layout (breakpoints, reflow) |
| `SidePanel` | Typed container for side-panel content (decoration, header, widths) |
| `SidePanelHeader` | Reusable icon-badge + title row for panel headers |

## Problem It Solves

Multiple screens (CourseScreen, KnowledgeBaseShell) shared nearly identical layout logic:

- A left panel that collapses to a narrow strip on medium screens
- A right panel that moves below the body when horizontal space runs out
- Breakpoint detection via `LayoutBuilder`
- Conditional padding and gaps
- Decorated containers with optional headers

Instead of each screen implementing its own `LayoutBuilder` → `Row`/`Column` switching and container styling, they now delegate to these shared widgets.

## Layout Modes

`SidePanelScreenWidget` uses `LayoutBuilder` to measure available width and picks one of three modes:

| Mode | Condition | Layout |
|---|---|---|
| **Wide** | `width >= wideBreakpoint` | `[header?]` → `Row(SidePanel expanded, body, actionsContent?)` |
| **Medium** | `width >= mediumBreakpoint` | `[header?]` → `Row(SidePanel collapsed, body)` → `actionsContent?` below |
| **Narrow** | `width < mediumBreakpoint` | Delegates to `narrowLayout` if provided; otherwise uses medium |

### Visual diagram

```
┌─────────────────────────────────────────────────────┐
│  Wide (>= wideBreakpoint)                           │
│  ┌────────┐ ┌──────────────────────┐ ┌────────────┐ │
│  │  Side  │ │        body          │ │  actions   │ │
│  │ Panel  │ │                      │ │  content   │ │
│  │(expand)│ │                      │ │            │ │
│  └────────┘ └──────────────────────┘ └────────────┘ │
└─────────────────────────────────────────────────────┘

┌───────────────────────────────────────┐
│  Medium (>= mediumBreakpoint)         │
│  ┌──┐ ┌────────────────────────────┐  │
│  │Si│ │          body              │  │
│  │de│ │                            │  │
│  │Pa│ │                            │  │
│  └──┘ └────────────────────────────┘  │
│  ┌─────────────────────────────────┐  │
│  │       actions content           │  │
│  └─────────────────────────────────┘  │
└───────────────────────────────────────┘

┌─────────────────────────┐
│  Narrow (< medium)      │
│  Fully custom widget    │
│  provided by the caller │
│  via `narrowLayout`     │
└─────────────────────────┘
```

## API

### SidePanelScreenWidget

```dart
const SidePanelScreenWidget({
  required SidePanelBuilder sidePanelBuilder, // Builds a SidePanel for collapsed state
  required Widget body,                       // Center content

  ActionsContentBuilder? actionsContentBuilder, // Right panel builder
  Widget? header,                       // Optional top header
  Widget? narrowLayout,                 // Custom layout for narrow screens

  double actionsContentWidth = 220,
  double wideBreakpoint      = 1100,
  double mediumBreakpoint    = 700,
  EdgeInsets contentPadding  = EdgeInsets.zero,
  double gap                 = 16,
});
```

#### `SidePanelBuilder`

```dart
typedef SidePanelBuilder = SidePanel Function(bool collapsed);
```

Returns a strongly-typed `SidePanel`. The layout reads `panel.currentWidth` to size the side column — widths are owned by the panel, not the layout widget.

#### `ActionsContentBuilder`

```dart
typedef ActionsContentBuilder = Widget Function(bool isExpanded);
```

- `true` — rendered in the right column (wide layout)
- `false` — rendered below the body (medium layout)

### SidePanel

```dart
const SidePanel({
  required bool collapsed,
  required Widget child,

  double expandedWidth      = 260,
  double collapsedWidth     = 72,
  BoxDecoration? decoration,     // null → default card style
  Widget? header,                // hidden when collapsed
  bool compact              = false,  // shrinkWrap mode
  bool safeArea             = false,
  bool showHeaderDivider    = true,
});
```

`SidePanel` provides:
- **Container decoration** — default card style (rounded, semi-transparent) or custom (e.g. KB's right-border rail)
- **Header** — shown only when `!collapsed`, with an optional divider
- **Compact mode** — `MainAxisSize.min` and no `Expanded` wrapper, for use inside scrollable parents
- **Width ownership** — `currentWidth` getter returns the correct width for the current collapsed state

### SidePanelHeader

```dart
const SidePanelHeader({
  required IconData icon,
  required String title,
});
```

Renders a 30×30 neon icon badge + title text. Used in both the course lessons panel header ("Уроки") and the course actions panel header ("Дії").

## Usage Examples

### CourseScreen

Three panels with `SidePanelBuilder`, custom narrow layout:

```dart
SidePanelScreenWidget(
  sidePanelBuilder: (collapsed) => SidePanel(
    collapsed: collapsed,
    expandedWidth: 280,
    collapsedWidth: 62,
    header: SidePanelHeader(
      icon: Icons.list_alt_rounded,
      title: localization.courseLessons,
    ),
    child: CourseLessonsList(
      lessons: lessons,
      collapsed: collapsed,
      selectedLessonId: selectedId,
      onLessonSelected: onSelect,
    ),
  ),
  body: CourseLessonDetailsPanel(lesson: lesson, ...),
  actionsContentBuilder: (isExpanded) => CourseActionPanel(
    expanded: isExpanded,
    lessonId: lessonId,
    courseName: courseName,
  ),
  header: CourseHeader(courseName: courseName),
  narrowLayout: NarrowCourseLayout(...),
  actionsContentWidth: 220,
  contentPadding: EdgeInsets.all(16),
)
```

### KnowledgeBaseShell

Two panels (no actions, no narrow mode, no padding, custom decoration):

```dart
SidePanelScreenWidget(
  sidePanelBuilder: (collapsed) => SidePanel(
    collapsed: collapsed,
    expandedWidth: 260,
    collapsedWidth: 72,
    decoration: BoxDecoration(
      color: AppColors.grey800,
      border: Border(right: BorderSide(...)),
    ),
    safeArea: true,
    showHeaderDivider: false,
    child: KnowledgeBaseSideRailContent(collapsed: collapsed),
  ),
  body: child,  // routed child
  wideBreakpoint: 1024,
  mediumBreakpoint: 0,  // always show at least collapsed rail
  gap: 0,               // no gap between rail and child
)
```

### SidePanelHeader reuse (CourseActionPanel)

```dart
SidePanelHeader(
  icon: Icons.bolt_rounded,
  title: localization.courseActions,
)
```

## Design Decisions

| Decision | Rationale |
|---|---|
| `SidePanelBuilder` returning typed `SidePanel` | Strong typing ensures only `SidePanel` instances are accepted. A single builder replaces two separate widget parameters and eliminates width duplication. |
| Widths owned by `SidePanel`, not `SidePanelScreenWidget` | The panel knows its own expanded/collapsed widths. The layout reads `panel.currentWidth` — no redundant width parameters on the layout widget. |
| `LayoutBuilder` over `MediaQuery` | Respects actual available space, not full screen width. Works correctly when the widget is nested inside other shells or navigation bars. |
| `SidePanel` with `decoration` parameter | KB uses a right-border rail style; Course uses a rounded card. A default decoration covers the common case; custom decoration handles the rest. |
| `SidePanelHeader` as a shared widget | The icon-badge + title pattern was duplicated across course lessons panel and course actions panel. Extracting it eliminates duplication and ensures visual consistency. |
| `ActionsContentBuilder` with `isExpanded` flag | Allows the caller to render structurally different widgets for column vs. bottom placement (e.g. a full card with header vs. a compact button bar). |
| `narrowLayout` as a full override | Narrow/mobile layouts are too diverse across screens (scrollable stacks, bottom-pinned buttons, etc.) to express with parameters. A full override keeps the widget simple. |
| `SidePanel.compact` mode | Panels inside scrollable parents (narrow layouts) must not use `Expanded`. Setting `compact: true` switches to `MainAxisSize.min`. |
| `mediumBreakpoint: 0` disables narrow mode | Screens like KnowledgeBaseShell always show a side rail (even collapsed). Setting `mediumBreakpoint` to 0 means narrow mode is never reached. |

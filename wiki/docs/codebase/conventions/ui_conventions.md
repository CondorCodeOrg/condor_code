# UI Conventions (Flutter)

## General Principles

- Keep UI code clear, predictable, and easy to read.
- Prefer explicit structure over short but hard-to-follow code.
- Split large widgets into small, focused private widgets.

## Widget Structure

### Do not use helper UI methods

- Avoid extracting UI into helper methods like `_buildHeader()`, `_buildCard()`, etc.
- Instead, create private widget classes:
  - Good: `_Header extends StatelessWidget`
  - Good: `_ProfileCard extends StatelessWidget`
- Why: private widgets are easier to test, reuse, and reason about than many helper methods.

### Prefer private widgets

- If a widget is used only in one file, make it private (`_WidgetName`).
- Keep the main screen/widget class short and focused on layout composition.

## State Management Rules

### Prefer Cubit over StatefulWidget

- Use `Cubit` for UI state management, even for small UI parts.
- Do not introduce local mutable UI state if it can be modeled as state + events.
- Keep state explicit and observable.

### When StatefulWidget is allowed

Create a `StatefulWidget` only when lifecycle handling is required, for example:

- disposing controllers (`TextEditingController`, `AnimationController`, etc.)
- handling subscriptions/listeners tied to widget lifecycle
- observing lifecycle callbacks (`initState`, `dispose`, `didChangeDependencies`, etc.)

If lifecycle is not required, use `StatelessWidget` + `Cubit`.

## Data Access Rules

### Do not use repositories directly in widgets

- Widgets and screens must **never** call repositories directly.
- All data access is mediated through a `Cubit` (or `Bloc`).
- Repositories are injected into Cubits, not into widgets.
- This keeps UI code focused on presentation and ensures state is observable and testable.

## Readability and Comments

- Code must be self-explanatory.
- Add comments only where logic is non-obvious.
- Do not add comments that simply restate the code.
- Prefer short, meaningful comments that explain intent.

## Constants and Variables

### Constants

- If constants are reused across files/features, move them to a separate constants file.
- Keep file-level constants near related domain/feature when possible.

### Variables

- Prefer private fields/variables by default (`_value`).
- Expose public members only when there is a clear need.

# Localization Conventions

## Golden Rule

**All user-facing strings must be localized. No hardcoded text in UI code.**

This applies to every piece of text the user can see: labels, buttons, titles, messages, hints, tooltips, error texts, placeholders, and snack bars.

## How Localization Works

The project uses Flutter's built-in `l10n` mechanism with ARB files.

| File | Purpose |
|---|---|
| `l10n.yaml` | Configuration (arb directory, template file, output) |
| `lib/ui/l10n/app_en.arb` | English strings (template) |
| `lib/ui/l10n/app_uk.arb` | Ukrainian strings |
| `lib/ui/l10n/app_localizations.dart` | Generated class with typed accessors |
| `lib/ui/utils/localization.dart` | Convenience getter for quick access |

## Usage

### With `BuildContext` (always preferred)

```dart
final l10n = AppLocalizations.of(context)!;
Text(l10n.courses);
```

### Rules

- **Always prefer `BuildContext`** over any global or static accessor.
- **Never rely on a global context** for localization. It is fragile, tied to navigation state, and breaks when the widget tree changes.
- **Never use localization inside Cubits or Blocs.** State managers must stay language-agnostic. Any user-facing message emitted from a Cubit should be a raw key / data object, and the UI layer (widget with `BuildContext`) maps it to a localized string.

## Adding a New String

1. Add the key and English value to `app_en.arb`:

```json
"myNewLabel": "Some text"
```

2. If the string has parameters, add metadata:

```json
"greeting": "Hello, {name}!",
"@greeting": {
  "placeholders": {
    "name": {
      "type": "String"
    }
  }
}
```

3. Add the Ukrainian translation to `app_uk.arb` with the same key.

4. Run code generation:

```bash
flutter gen-l10n
```

5. Use the generated accessor in code: `l10n.greeting('Oleh')`.

## What Must NOT Appear in Code

```dart
// ❌ BAD — hardcoded string
Text('Уроки');

// ❌ BAD — hardcoded string in a button
ElevatedButton(child: Text('Check knowledge'));

// ❌ BAD — hardcoded tooltip
Tooltip(message: 'Settings');
```

```dart
// ✅ GOOD
Text(l10n.lessons);

// ✅ GOOD
ElevatedButton(child: Text(l10n.checkMyKnowledge));

// ✅ GOOD
Tooltip(message: l10n.knowledgeBaseSettings);
```

## Exceptions

The only cases where a raw string is acceptable:

- **Technical/debug-only text** that users never see (e.g., log tags, assert messages).
- **Constant identifiers** (route paths, asset paths, map keys).
- **Punctuation or formatting characters** that are language-independent (e.g., `' · '`, `' / '`).

Everything else — localize it.

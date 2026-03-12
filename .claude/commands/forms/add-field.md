Add a new form field component named `$ARGUMENTS` to the `simple_design` package.

## Steps

1. Read the most similar existing field in `simple_design/lib/src/components/inputs/` for reference.
2. Create `simple_design/lib/src/components/inputs/sd_$ARGUMENTS.dart`.
3. Export it from `simple_design/lib/simple_design.dart`.
4. Add a demo section to `sd_showcase/lib/screens/forms/forms.screen.dart`.

## Component spec

The component class must be named `SD` + PascalCase of `$ARGUMENTS` (e.g. `SDTimePicker`).

**Required parameters:**
- `label` — field label shown above/inside the input
- `onChanged` — callback for value changes
- `enabled` — defaults to `true`; when `false`, renders muted and non-interactive

**Required states (all 5):**
| State | How to trigger |
|---|---|
| default | Normal render |
| focused | User taps / keyboard focus |
| filled/active | Has a value |
| error | `errorText` parameter is non-null |
| disabled | `enabled: false` |

## Rules — no exceptions

- Colors → `Theme.of(context).colorScheme.*`
- Text styles → `Theme.of(context).textTheme.*`
- Decoration → `InputDecoration` with `Theme.of(context).inputDecorationTheme`
- Touch target ≥ 48dp
- Wrap in `Semantics(label: label, child: ...)`
- Dartdoc comment with one usage example above the class

## Quality checklist — verify all 7 before finishing

```
□ 1. Theme values only
□ 2. All 5 states
□ 3. Touch target ≥ 48dp
□ 4. WCAG AA contrast
□ 5. Semantics widget
□ 6. Simple API (usable in 1–2 lines)
□ 7. Dartdoc comment with example
```

## Showcase section to add in forms.screen.dart

Add a `_Section` block that shows:
- Default state (empty)
- Filled/active state (with a value)
- Error state (`errorText` set)
- Disabled state (`enabled: false`)

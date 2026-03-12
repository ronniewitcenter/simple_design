Add a new `SDButton` variant named `$ARGUMENTS` to `simple_design/lib/src/components/buttons/sd_button.dart`.

## Steps

1. Read `simple_design/lib/src/components/buttons/sd_button.dart` in full.
2. Add a new named constructor following the exact same pattern as the existing variants (`primary`, `secondary`, `ghost`, `danger`).
3. The variant name is: `$ARGUMENTS` (e.g. `SDButton.warning(...)`).

## Rules — all required, no exceptions

- Color must come from `Theme.of(context).colorScheme.*` — never hardcoded
- Minimum height: 48dp enforced
- All 5 states: default → focused → pressed → loading (`SDSpinner`) → disabled (`onPressed: null`)
- Wrap the returned widget in `Semantics(label: label, button: true, child: ...)`
- Support `leadingIcon`, `fullWidth`, and `loading` parameters — same signature as existing variants
- Add a dartdoc comment above the constructor with one usage example

## Quality checklist — verify all 7 before finishing

```
□ 1. Theme values only — no hardcoded colors, sizes, or spacing
□ 2. All 5 states implemented
□ 3. Touch target ≥ 48dp
□ 4. WCAG AA contrast — text ≥ 4.5:1 (confirm color pairing)
□ 5. Semantics widget present
□ 6. Simple API — usable in 1 line
□ 7. Dartdoc comment with usage example
```

After implementing, update `sd_showcase/lib/screens/buttons/buttons.screen.dart` to showcase the new variant in all 3 states (default, loading, disabled).
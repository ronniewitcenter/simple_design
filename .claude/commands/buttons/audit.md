Audit the `SDButton` component against the 7-point quality checklist.

## Steps

1. Read `simple_design/lib/src/components/buttons/sd_button.dart` in full.
2. Read `sd_showcase/lib/screens/buttons/buttons.screen.dart` in full.
3. For each of the 4 variants (`primary`, `secondary`, `ghost`, `danger`), check every item below.

## Checklist — check each item for every variant

```
□ 1. Theme values only
      - No Color(0x...), no hardcoded padding, no hardcoded fontSize
      - Colors from colorScheme.*, text from textTheme.*

□ 2. All 5 states present
      - default (normal interaction)
      - focused (FocusNode or InkWell focus)
      - pressed (InkWell splash / highlightColor)
      - loading (SDSpinner visible, label hidden, onPressed disabled)
      - disabled (onPressed: null → visually muted)

□ 3. Touch target ≥ 48dp
      - MinimumSize or SizedBox enforces height ≥ 48

□ 4. WCAG AA contrast
      - Foreground/background color pairing is accessible
      - Flag any pair that is likely insufficient

□ 5. Semantics widget
      - Semantics(label: label, button: true, ...) wraps each variant

□ 6. Simple API
      - Can be used in 1–2 lines without extra setup

□ 7. Dartdoc comment with usage example above each constructor
```

## Output format

For each variant, output a table row:

| Variant | 1 Theme | 2 States | 3 Touch | 4 Contrast | 5 Semantics | 6 API | 7 Docs |
|---|---|---|---|---|---|---|---|
| primary | ✅/❌ | ✅/❌ | ✅/❌ | ✅/❌ | ✅/❌ | ✅/❌ | ✅/❌ |

Then list every ❌ as an actionable fix with the exact file and line number.
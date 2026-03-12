Audit all form field components in `simple_design/lib/src/components/inputs/` against the 7-point quality checklist.

## Steps

1. List all files in `simple_design/lib/src/components/inputs/`.
2. Read each file in full.
3. Read `sd_showcase/lib/screens/forms/forms.screen.dart` to verify showcase coverage.

## Components to audit

| File | Class |
|---|---|
| `sd_text_field.dart` | `SDTextField` |
| `sd_dropdown.dart` | `SDDropdown` |
| `sd_checkbox.dart` | `SDCheckbox` |
| `sd_radio.dart` | `SDRadio` |
| `sd_switch.dart` | `SDSwitch` |
| `sd_slider.dart` | `SDSlider` |
| `sd_date_picker.dart` | `SDDatePicker` |
| `sd_multi_select.dart` | `SDMultiSelect` |
| `sd_form.dart` | `SDForm` |

## Checklist — check each item for every component

```
□ 1. Theme values only
      - No hardcoded Color(0x...), fontSize, padding
      - Colors from colorScheme.*, text from textTheme.*
      - Decoration via InputDecoration / inputDecorationTheme

□ 2. All 5 states present
      - default, focused, filled/active, error (errorText), disabled (enabled: false)

□ 3. Touch target ≥ 48dp
      - Interactive area height ≥ 48

□ 4. WCAG AA contrast
      - Label and value text ≥ 4.5:1 against background

□ 5. Semantics widget
      - Semantics(label: ..., child: ...) wraps each component

□ 6. Simple API
      - Usable in 1–2 lines

□ 7. Dartdoc comment with usage example
```

## Output format

Output a summary table:

| Component | 1 Theme | 2 States | 3 Touch | 4 Contrast | 5 Semantics | 6 API | 7 Docs | Showcase |
|---|---|---|---|---|---|---|---|---|
| SDTextField | ✅/❌ | ✅/❌ | ✅/❌ | ✅/❌ | ✅/❌ | ✅/❌ | ✅/❌ | ✅/❌ |

Then list every ❌ as an actionable fix with the exact file and line number.

Flag any component that is NOT demoed in the forms showcase screen.
Scaffold a complete validated form screen using `$ARGUMENTS` as the form name/purpose.

## Steps

1. Read `simple_design/lib/src/components/inputs/sd_form.dart` and `sd_text_field.dart`.
2. Read `sd_showcase/lib/screens/forms/forms.screen.dart` for layout patterns.
3. Create the form as a self-contained widget.

## Output

Generate a Flutter widget class named `SD` + PascalCase(`$ARGUMENTS`) + `Form` (e.g. `SDLoginForm`) with:

### Structure
```dart
class SD${Name}Form extends StatefulWidget {
  final void Function(Map<String, dynamic> values) onSubmit;
  const SD${Name}Form({super.key, required this.onSubmit});
}
```

### Required elements
- `SDForm` wrapper with a `GlobalKey<FormState>`
- At least the fields appropriate for `$ARGUMENTS` (infer from the name, e.g. "login" → email + password)
- Each field uses an existing `simple_design` input component
- Submit button: `SDButton.primary(label: 'Submit', ...)`
- Cancel/reset button: `SDButton.ghost(label: 'Cancel', ...)`
- Validation on every field (`validator:` parameter)
- Loading state on the submit button while submitting

### Validation rules
- Required fields: show `'This field is required'` when empty
- Email fields: validate format with a regex
- Password fields: min 8 characters, `obscureText: true`
- Show all errors inline via `errorText` on each field

## Rules — no exceptions
- No hardcoded colors, sizes, or spacing — theme only
- All inputs use `simple_design` components (`SDTextField`, `SDDropdown`, etc.)
- Touch targets ≥ 48dp
- `Semantics` on every interactive element

## After generating
- Place the widget in `simple_design/lib/src/components/inputs/sd_${name}_form.dart`
- Export from `simple_design/lib/simple_design.dart`
- Add a route + screen to `sd_showcase` to demo the form
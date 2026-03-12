import 'package:flutter/material.dart';

/// A labeled checkbox.
///
/// ```dart
/// SDCheckbox(label: 'Accept terms', value: _checked, onChanged: (v) => setState(() => _checked = v ?? false))
/// ```
class SDCheckbox extends StatelessWidget {
  const SDCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final String label;
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      checked: value,
      enabled: enabled,
      child: CheckboxListTile(
        title: Text(label),
        value: value,
        onChanged: enabled ? onChanged : null,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

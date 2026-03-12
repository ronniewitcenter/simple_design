import 'package:flutter/material.dart';

/// A labeled toggle switch.
///
/// ```dart
/// SDSwitch(label: 'Notifications', value: _on, onChanged: (v) => setState(() => _on = v))
/// ```
class SDSwitch extends StatelessWidget {
  const SDSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      toggled: value,
      enabled: enabled,
      child: SwitchListTile(
        title: Text(label),
        value: value,
        onChanged: enabled ? onChanged : null,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

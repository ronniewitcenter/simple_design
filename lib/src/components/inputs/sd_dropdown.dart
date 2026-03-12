import 'package:flutter/material.dart';

/// A single-select dropdown item.
class SDDropdownItem<T> {
  const SDDropdownItem({required this.value, required this.label});
  final T value;
  final String label;
}

/// A themed single-select dropdown.
///
/// ```dart
/// SDDropdown<String>(
///   label: 'Country',
///   items: [SDDropdownItem(value: 'us', label: 'United States')],
///   onChanged: (v) {},
/// )
/// ```
class SDDropdown<T> extends StatelessWidget {
  const SDDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.label,
    this.hint,
    this.enabled = true,
  });

  final List<SDDropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final String? label;
  final String? hint;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label ?? hint,
      enabled: enabled,
      child: DropdownButtonFormField<T>(
        initialValue: value,
        onChanged: enabled ? onChanged : null,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        items: items
            .map((item) => DropdownMenuItem<T>(
                  value: item.value,
                  child: Text(item.label),
                ))
            .toList(),
      ),
    );
  }
}

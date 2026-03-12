import 'package:flutter/material.dart';

/// A tappable date input that opens the system date picker.
///
/// ```dart
/// SDDatePicker(label: 'Birth date', value: _date, onChanged: (d) => setState(() => _date = d))
/// ```
class SDDatePicker extends StatelessWidget {
  const SDDatePicker({
    super.key,
    this.value,
    required this.onChanged,
    this.label,
    this.enabled = true,
    this.firstDate,
    this.lastDate,
  });

  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final String? label;
  final bool enabled;
  final DateTime? firstDate;
  final DateTime? lastDate;

  String _format(DateTime dt) {
    final y = dt.year.toString();
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? now,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final displayText = value != null ? _format(value!) : null;

    return Semantics(
      label: label,
      button: true,
      enabled: enabled,
      child: InkWell(
        onTap: enabled ? () => _pick(context) : null,
        borderRadius: BorderRadius.circular(4),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            suffixIcon: const Icon(Icons.calendar_today_outlined),
            enabled: enabled,
          ),
          child: displayText != null
              ? Text(
                  displayText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: enabled
                            ? cs.onSurface
                            : cs.onSurface.withValues(alpha: 0.38),
                      ),
                )
              : null,
        ),
      ),
    );
  }
}

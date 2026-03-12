import 'package:flutter/material.dart';

/// A full-width divider with a centered text label.
///
/// ```dart
/// SDDividerLabel(label: 'OR')
/// SDDividerLabel(label: 'Today')
/// SDDividerLabel(label: 'Section Title')
/// ```
class SDDividerLabel extends StatelessWidget {
  const SDDividerLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: tt.labelSmall?.copyWith(
              color: cs.onSurfaceVariant,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

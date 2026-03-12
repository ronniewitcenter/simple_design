import 'package:flutter/material.dart';

/// An icon and text label always displayed together.
///
/// Per design rules, icons must never appear without a text label.
///
/// Usage:
/// ```dart
/// SDIconLabel(icon: Icons.home, label: 'Home')
/// SDIconLabel(icon: Icons.add, label: 'Add item', iconSize: 20)
/// ```
class SDIconLabel extends StatelessWidget {
  const SDIconLabel({
    super.key,
    required this.icon,
    required this.label,
    this.iconSize = 20,
    this.gap = 8,
    this.color,
  });

  final IconData icon;
  final String label;
  final double iconSize;
  final double gap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final resolvedColor = color ?? Theme.of(context).colorScheme.onSurface;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: iconSize, color: resolvedColor),
        SizedBox(width: gap),
        Text(label, style: TextStyle(color: resolvedColor)),
      ],
    );
  }
}

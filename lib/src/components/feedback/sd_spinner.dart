import 'package:flutter/material.dart';

/// A consistently-sized loading spinner.
///
/// Usage:
/// ```dart
/// SDSpinner()                        // 24dp, theme color
/// SDSpinner(size: 20, color: white)  // inside a button
/// ```
class SDSpinner extends StatelessWidget {
  const SDSpinner({super.key, this.size = 24, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

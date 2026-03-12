import 'package:flutter/material.dart';

/// A horizontal or vertical divider using the theme's outline color.
///
/// Usage:
/// ```dart
/// SDDivider.horizontal()
/// SDDivider.vertical(height: 24)
/// ```
class SDDivider extends StatelessWidget {
  const SDDivider._internal({required bool isVertical, this.height, super.key})
      : _isVertical = isVertical;

  /// A full-width horizontal rule.
  const SDDivider.horizontal({Key? key})
      : this._internal(isVertical: false, key: key);

  /// A vertical rule. [height] controls how tall the divider is.
  const SDDivider.vertical({required double height, Key? key})
      : this._internal(isVertical: true, height: height, key: key);

  final bool _isVertical;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.outlineVariant;
    if (_isVertical) {
      return VerticalDivider(color: color, width: 1, thickness: 1);
    }
    return Divider(color: color, height: 1, thickness: 1);
  }
}

import 'package:flutter/material.dart';

/// A themed range slider.
///
/// ```dart
/// SDSlider(value: _volume, onChanged: (v) => setState(() => _volume = v), label: 'Volume')
/// SDSlider(value: _opacity, min: 0, max: 1, divisions: 10, onChanged: (v) {})
/// ```
class SDSlider extends StatelessWidget {
  const SDSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.enabled = true,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      slider: true,
      enabled: enabled,
      child: SizedBox(
        height: 48,
        child: Slider(
          value: value,
          onChanged: enabled ? onChanged : null,
          min: min,
          max: max,
          divisions: divisions,
          label: label,
        ),
      ),
    );
  }
}

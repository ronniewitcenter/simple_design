import 'package:flutter/material.dart';

/// A single radio option used inside [SDRadioGroup].
class SDRadioOption<T> {
  const SDRadioOption({required this.value, required this.label});
  final T value;
  final String label;
}

/// A group of radio buttons.
///
/// ```dart
/// SDRadioGroup<String>(
///   label: 'Size',
///   value: _size,
///   options: [
///     SDRadioOption(value: 'sm', label: 'Small'),
///     SDRadioOption(value: 'lg', label: 'Large'),
///   ],
///   onChanged: (v) => setState(() => _size = v ?? _size),
/// )
/// ```
class SDRadioGroup<T> extends StatelessWidget {
  const SDRadioGroup({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.label,
    this.enabled = true,
  });

  final T value;
  final List<SDRadioOption<T>> options;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              label!,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        RadioGroup<T>(
          groupValue: value,
          onChanged: (v) {
            if (enabled) onChanged?.call(v);
          },
          child: Column(
            children: options
                .map((option) => Semantics(
                      label: option.label,
                      inMutuallyExclusiveGroup: true,
                      enabled: enabled,
                      child: RadioListTile<T>(
                        title: Text(option.label),
                        value: option.value,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

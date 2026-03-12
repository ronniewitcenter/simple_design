import 'package:flutter/material.dart';

/// A themed text input field.
///
/// ```dart
/// SDTextField(label: 'Email', hint: 'you@example.com', onChanged: (v) {})
/// SDTextField(label: 'Name', errorText: 'Required', enabled: false)
/// ```
class SDTextField extends StatelessWidget {
  const SDTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.onChanged,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label ?? hint,
      textField: true,
      enabled: enabled,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        enabled: enabled,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          errorText: errorText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

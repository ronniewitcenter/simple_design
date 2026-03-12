import 'package:flutter/material.dart';

/// A thin wrapper around Flutter's [Form] widget.
///
/// ```dart
/// final _formKey = GlobalKey<FormState>();
///
/// SDForm(
///   formKey: _formKey,
///   child: Column(children: [
///     SDTextField(label: 'Email', validator: (v) => v!.isEmpty ? 'Required' : null),
///     SDButton.primary(label: 'Submit', onPressed: () {
///       if (_formKey.currentState!.validate()) { /* submit */ }
///     }),
///   ]),
/// )
/// ```
class SDForm extends StatelessWidget {
  const SDForm({
    super.key,
    required this.formKey,
    required this.child,
  });

  final GlobalKey<FormState> formKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: child,
    );
  }
}

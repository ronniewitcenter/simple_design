import 'package:flutter/material.dart';
import '../feedback/sd_spinner.dart';
import '../typography/sd_icon_label.dart';

enum _SDButtonVariant { primary, secondary, ghost, danger }

/// A design-system button with 4 variants and 5 states.
///
/// All colors are resolved from the active [ColorScheme] — never hardcoded.
///
/// Usage:
/// ```dart
/// SDButton.primary(label: 'Submit', onPressed: () {})
/// SDButton.danger(label: 'Delete', onPressed: () {}, loading: true)
/// SDButton.secondary(label: 'Cancel', onPressed: null) // disabled
/// SDButton.ghost(label: 'Skip', onPressed: () {}, leadingIcon: Icons.skip_next)
/// ```
class SDButton extends StatelessWidget {
  const SDButton._internal({
    required this.label,
    required _SDButtonVariant variant,
    this.onPressed,
    this.loading = false,
    this.leadingIcon,
    this.fullWidth = false,
    super.key,
  }) : _variant = variant;

  /// Filled button — primary action.
  const SDButton.primary({
    required String label,
    VoidCallback? onPressed,
    bool loading = false,
    IconData? leadingIcon,
    bool fullWidth = false,
    Key? key,
  }) : this._internal(
          label: label,
          onPressed: onPressed,
          loading: loading,
          leadingIcon: leadingIcon,
          fullWidth: fullWidth,
          variant: _SDButtonVariant.primary,
          key: key,
        );

  /// Outlined button — secondary action.
  const SDButton.secondary({
    required String label,
    VoidCallback? onPressed,
    bool loading = false,
    IconData? leadingIcon,
    bool fullWidth = false,
    Key? key,
  }) : this._internal(
          label: label,
          onPressed: onPressed,
          loading: loading,
          leadingIcon: leadingIcon,
          fullWidth: fullWidth,
          variant: _SDButtonVariant.secondary,
          key: key,
        );

  /// Text-only button — minimal / ghost action.
  const SDButton.ghost({
    required String label,
    VoidCallback? onPressed,
    bool loading = false,
    IconData? leadingIcon,
    bool fullWidth = false,
    Key? key,
  }) : this._internal(
          label: label,
          onPressed: onPressed,
          loading: loading,
          leadingIcon: leadingIcon,
          fullWidth: fullWidth,
          variant: _SDButtonVariant.ghost,
          key: key,
        );

  /// Filled button in error color — destructive action.
  const SDButton.danger({
    required String label,
    VoidCallback? onPressed,
    bool loading = false,
    IconData? leadingIcon,
    bool fullWidth = false,
    Key? key,
  }) : this._internal(
          label: label,
          onPressed: onPressed,
          loading: loading,
          leadingIcon: leadingIcon,
          fullWidth: fullWidth,
          variant: _SDButtonVariant.danger,
          key: key,
        );

  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? leadingIcon;
  final bool fullWidth;
  final _SDButtonVariant _variant;

  static const double _minHeight = 48.0;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isEnabled = onPressed != null && !loading;
    final child = _buildChild(cs);
    final minSize = Size(fullWidth ? double.infinity : 0, _minHeight);

    final button = switch (_variant) {
      _SDButtonVariant.primary => ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: minSize),
          onPressed: isEnabled ? onPressed : null,
          child: child,
        ),
      _SDButtonVariant.secondary => OutlinedButton(
          style: OutlinedButton.styleFrom(minimumSize: minSize),
          onPressed: isEnabled ? onPressed : null,
          child: child,
        ),
      _SDButtonVariant.ghost => TextButton(
          style: TextButton.styleFrom(minimumSize: minSize),
          onPressed: isEnabled ? onPressed : null,
          child: child,
        ),
      _SDButtonVariant.danger => ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: minSize,
            backgroundColor: cs.error,
            foregroundColor: cs.onError,
          ),
          onPressed: isEnabled ? onPressed : null,
          child: child,
        ),
    };

    return Semantics(
      label: label,
      button: true,
      enabled: isEnabled,
      child: button,
    );
  }

  Widget _buildChild(ColorScheme cs) {
    if (loading) {
      return SDSpinner(size: 20, color: _spinnerColor(cs));
    }
    if (leadingIcon != null) {
      return SDIconLabel(icon: leadingIcon!, label: label);
    }
    return Text(label);
  }

  Color _spinnerColor(ColorScheme cs) => switch (_variant) {
        _SDButtonVariant.primary => cs.onPrimary,
        _SDButtonVariant.secondary => cs.primary,
        _SDButtonVariant.ghost => cs.primary,
        _SDButtonVariant.danger => cs.onError,
      };
}

import 'package:flutter/animation.dart';

/// Animation timing tokens for the Simple Design system.
///
/// Usage:
/// ```dart
/// AnimatedContainer(
///   duration: SDAnimation.normal,
///   curve: SDAnimation.curve,
/// )
/// ```
class SDAnimation {
  SDAnimation._();

  /// 100ms — hover reveals, press feedback
  static const Duration fast = Duration(milliseconds: 100);

  /// 200ms — expand/collapse, show/hide
  static const Duration normal = Duration(milliseconds: 200);

  /// 350ms — modals, page transitions, overlays
  static const Duration slow = Duration(milliseconds: 350);

  /// Standard easing curve used across all SD animations
  static const Curve curve = Curves.easeInOut;
}

import 'package:flutter/material.dart';

/// A text widget pre-wired to the active theme's type scale.
///
/// Every variant maps to a [TextTheme] property from the active [ThemeData],
/// so colors and sizes update automatically when the theme changes.
///
/// Usage:
/// ```dart
/// SDText.heading1('Welcome')
/// SDText.body('This is body text', color: Colors.grey)
/// SDText.caption('Last updated today', textAlign: TextAlign.center)
/// ```
class SDText extends StatelessWidget {
  const SDText._internal(
    this.text, {
    required _SDTextVariant variant,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    super.key,
  }) : _variant = variant;

  const SDText.displayLg(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key})
      : this._internal(text, variant: _SDTextVariant.displayLg, color: color, textAlign: textAlign, maxLines: maxLines, overflow: overflow, key: key);

  const SDText.displaySm(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key})
      : this._internal(text, variant: _SDTextVariant.displaySm, color: color, textAlign: textAlign, maxLines: maxLines, overflow: overflow, key: key);

  const SDText.heading1(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key})
      : this._internal(text, variant: _SDTextVariant.heading1, color: color, textAlign: textAlign, maxLines: maxLines, overflow: overflow, key: key);

  const SDText.heading2(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key})
      : this._internal(text, variant: _SDTextVariant.heading2, color: color, textAlign: textAlign, maxLines: maxLines, overflow: overflow, key: key);

  const SDText.heading3(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key})
      : this._internal(text, variant: _SDTextVariant.heading3, color: color, textAlign: textAlign, maxLines: maxLines, overflow: overflow, key: key);

  const SDText.bodyLg(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key})
      : this._internal(text, variant: _SDTextVariant.bodyLg, color: color, textAlign: textAlign, maxLines: maxLines, overflow: overflow, key: key);

  const SDText.body(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key})
      : this._internal(text, variant: _SDTextVariant.body, color: color, textAlign: textAlign, maxLines: maxLines, overflow: overflow, key: key);

  const SDText.bodySm(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key})
      : this._internal(text, variant: _SDTextVariant.bodySm, color: color, textAlign: textAlign, maxLines: maxLines, overflow: overflow, key: key);

  const SDText.label(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key})
      : this._internal(text, variant: _SDTextVariant.label, color: color, textAlign: textAlign, maxLines: maxLines, overflow: overflow, key: key);

  const SDText.caption(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key})
      : this._internal(text, variant: _SDTextVariant.caption, color: color, textAlign: textAlign, maxLines: maxLines, overflow: overflow, key: key);

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final _SDTextVariant _variant;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final base = switch (_variant) {
      _SDTextVariant.displayLg => tt.displayLarge,
      _SDTextVariant.displaySm => tt.displaySmall,
      _SDTextVariant.heading1  => tt.headlineLarge,
      _SDTextVariant.heading2  => tt.headlineMedium,
      _SDTextVariant.heading3  => tt.headlineSmall,
      _SDTextVariant.bodyLg    => tt.bodyLarge,
      _SDTextVariant.body      => tt.bodyMedium,
      _SDTextVariant.bodySm    => tt.bodySmall,
      _SDTextVariant.label     => tt.labelLarge,
      _SDTextVariant.caption   => tt.labelSmall,
    };

    return Text(
      text,
      style: base?.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

enum _SDTextVariant {
  displayLg, displaySm,
  heading1, heading2, heading3,
  bodyLg, body, bodySm,
  label, caption,
}
